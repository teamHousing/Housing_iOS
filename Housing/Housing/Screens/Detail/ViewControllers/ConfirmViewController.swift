//
//  ConfirmViewController.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/08.
//

import UIKit

import SnapKit
import Then
import Moya
import RxSwift
import RxCocoa

class ConfirmViewController: BaseViewController {
	// MARK: - Property
	private let userProvider = MoyaProvider<PromiseService>(
		plugins: [NetworkLoggerPlugin(verbose: true)])
	
	var determineButtonState : [Bool] = []
	var method : [CommunicationMethod] = []
	var selectedTime :[String] = []
	
	let confirmTableView = UITableView()
	
	let titleLabel = UILabel().then {
		$0.textColor = .primaryBlack
		$0.text = "약속 확정하기"
		$0.textAlignment = .left
		$0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
	}
	let lineView = UIView().then {
		$0.backgroundColor = .primaryBlack
	}
	let confirmImageView = UIImageView().then {
		$0.image = UIImage(named: "img4")
	}
	let contextLabel = UILabel().then {
		$0.textColor = .black
		$0.text = "202호 자취생이 원하는 약속이에요!\n이 중, 가능한 일정은 무엇인가요?"
		$0.numberOfLines = 0
		$0.textAlignment = .center
		$0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
	}
	let confirmButton = UIButton().then {
		$0.backgroundColor = .gray01
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.layer.cornerRadius = 24
		$0.setTitle("확정하기", for: .normal)
		$0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		$0.titleLabel?.textAlignment = .center
		$0.setTitleColor(.primaryWhite, for: .normal)
		$0.isEnabled = false
		$0.addTarget(self, action: #selector(confirmPromise), for: .touchUpInside)
	}
	let modifyButton = UIButton().then {
		$0.backgroundColor = .primaryWhite
		$0.setBorder(borderColor: .primaryBlack, borderWidth: 1)
		$0.layer.cornerRadius = 24
		$0.setTitle("일정 수정 요청", for: .normal)
		$0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		$0.titleLabel?.textAlignment = .center
		$0.setTitleColor(.primaryBlack, for: .normal)
		$0.addTarget(self, action: #selector(returnPromise), for: .touchUpInside)
	}
	
	// MARK: - Helper
	private func registerCell() {
		confirmTableView.register(ConfirmTableViewCell.self, forCellReuseIdentifier: ConfirmTableViewCell.reuseIdentifier)
	}
	
	private func layout() {
		let headerView = UIView(frame: CGRect(x: 0, y: 0, width:self.view.frame.size.width , height: 202)).then {
			$0.backgroundColor = .primaryWhite
		}
		let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 204)).then {
			$0.backgroundColor = .primaryWhite
		}
		self.view.add(self.confirmTableView) {
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.view)
			}
		}
		headerView.add(self.titleLabel) {
			$0.snp.makeConstraints {
				$0.top.equalTo(headerView.snp.top).offset(6)
				$0.leading.equalTo(headerView.snp.leading).offset(20)
			}
		}
		headerView.add(self.lineView) {
			$0.snp.makeConstraints {
				$0.bottom.equalTo(self.titleLabel.snp.bottom).offset(-8)
				$0.leading.equalTo(self.titleLabel.snp.trailing).offset(8)
				$0.trailing.equalTo(headerView.snp.trailing)
				$0.height.equalTo(1)
			}
		}
		headerView.add(self.confirmImageView) {
			$0.snp.makeConstraints {
				$0.centerX.equalTo(headerView)
				$0.top.equalTo(self.titleLabel.snp.bottom).offset(13)
				$0.height.width.equalTo(80)
			}
		}
		headerView.add(self.contextLabel) {
			$0.snp.makeConstraints {
				$0.centerX.equalTo(headerView)
				$0.top.equalTo(self.confirmImageView.snp.bottom).offset(4)
				$0.leading.equalTo(headerView.snp.leading).offset(53)
				$0.trailing.equalTo(headerView.snp.trailing).offset(-40)
			}
		}
		footerView.add(self.confirmButton) {
			$0.snp.makeConstraints {
				$0.top.equalTo(footerView.snp.top).offset(50)
				$0.centerX.equalTo(footerView)
				$0.width.equalTo(255)
				$0.height.equalTo(48)
			}
		}
		footerView.add(self.modifyButton) {
			$0.snp.makeConstraints {
				$0.top.equalTo(self.confirmButton.snp.bottom).offset(16)
				$0.centerX.equalTo(footerView)
				$0.width.equalTo(255)
				$0.height.equalTo(48)
			}
		}
		self.confirmTableView.tableHeaderView = headerView
		self.confirmTableView.tableFooterView = footerView
	}
	
	@objc
	private func confirmPromise() {
		userProvider.rx.request(.homePromiseConfirm(id: 1,
																								promise_option: selectedTime))
			.asObservable()
			.subscribe { (next) in
				if next.statusCode == 200 {
					do {
						print(next)
						self.navigationController?.popViewController(animated: true)
					} catch {
						print(error)
					}
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
	}
	
	@objc
	private func returnPromise() {
		userProvider.rx.request(.homePromiseHostModify(id: 1))
			.asObservable()
			.subscribe { (next) in
				if next.statusCode == 200 {
					do {
						self.navigationController?.parent?.children.last?.viewDidLoad()
						self.navigationController?.popViewController(animated: true)
					}
					catch {
						print(error)
					}
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
	}
	
	private func whenLoad() {
		tabBarController?.tabBar.isHidden = true
		navigationController?.navigationBar.topItem?.title = ""
		navigationController?.setNavigationBarHidden(false, animated: true)
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.tintColor = .black
		navigationController?.navigationBar.barTintColor = .white
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		registerCell()
		layout()
		
		userProvider.rx.request(.homePromiseTimeList(id: 1)).asObservable()
			.subscribe { (next) in
				if next.statusCode == 200 {
					do {
						let decoder = JSONDecoder()
						let data = try decoder.decode(ResponseType<responseData>.self, from: next.data)
						guard let dataArray : [[String]] = data.data?.promise_option else {return}
						for items in dataArray {
							let temp = CommunicationMethod(date: items[0], time: items[1], method: items[2])
							self.method.append(temp)
							self.determineButtonState.append(false)
						}
						self.confirmTableView.reloadData()
					}
					catch {
						print(error)
					}
				}
			} onError: { (error) in
				print(error.localizedDescription)
			}.disposed(by: disposeBag)
		
		self.confirmTableView.isScrollEnabled = true
		self.confirmTableView.separatorStyle = .none
		self.confirmTableView.isUserInteractionEnabled = true
		self.confirmTableView.estimatedRowHeight = CGFloat(self.method.count * 70)
		self.confirmTableView.rowHeight = UITableView.automaticDimension
		self.confirmTableView.delegate = self
		self.confirmTableView.dataSource = self
		self.confirmTableView.reloadData()
		
		for _ in 0..<self.method.count {
			self.determineButtonState.append(false)
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		whenLoad()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		tabBarController?.tabBar.isHidden = false
	}
}

// MARK: - UITableView Delegate
extension ConfirmViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
}

// MARK: - UITableView DataSource
extension ConfirmViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.method.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmTableViewCell") as?
						ConfirmTableViewCell else {
			return UITableViewCell()
		}
		cell.buttonState = self.determineButtonState[indexPath.row]
		cell.awakeFromNib()
		cell.dateLabel.text = self.method[indexPath.row].date
		cell.timeLabel.text = self.method[indexPath.row].time
		cell.methodLabel.text = self.method[indexPath.row].method
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmTableViewCell") as?
						ConfirmTableViewCell else { return }
		for i in 0..<self.determineButtonState.count{
			if i == indexPath.row {
				self.determineButtonState[i] = true
			}
			else {
				self.determineButtonState[i] = false
			}
		}
		if !self.selectedTime.isEmpty
		{
			selectedTime.removeAll()
		}
		self.selectedTime.append(method[indexPath.row].date)
		self.selectedTime.append(method[indexPath.row].time)
		self.selectedTime.append(method[indexPath.row].method)
		
		
		
		self.confirmButton.backgroundColor = .primaryBlack
		self.confirmButton.setBorder(borderColor: .primaryBlack, borderWidth: 1)
		self.confirmButton.isEnabled = true
		tableView.reloadData()
	}
}

// MARK: - Model
private struct responseData : Codable {
	let promise_option : [[String]]
}
