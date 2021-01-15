//
//  DatePickerViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/07.
//

import UIKit
import RxSwift
import RxCocoa
class DatePickerViewController: UIViewController {
	// MARK: - Component
	var requestData = RequestDataModel.shared
	var disposeBag = DisposeBag()
	let grayImage = UIImageView()
	var pickerMode : Int = 0
	let dimmerView = UIView().then{
		$0.backgroundColor = UIColor.darkGray
		$0.alpha = 0.7
	}
	private let cardView = UIView().then{
		$0.clipsToBounds = true
		$0.backgroundColor = .white
		$0.setRounded(radius: 10)
		$0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		
	}
	private let datePicker = UIDatePicker().then{
		$0.backgroundColor = .white
		$0.tintColor = .black
		$0.textColor = .black
		if #available(iOS 13.4, *) {
			$0.preferredDatePickerStyle = .wheels
		}
		$0.timeZone = NSTimeZone.local
		$0.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
	}
	private let confirmButton = UIButton().then{
		$0.setTitle("확인", for: .normal)
		$0.setTitleColor(.primaryOrange, for: .normal)
		$0.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
	}
	// MARK: - Helper

	@objc func datePickerValueChanged(_ sender: UIDatePicker){
		
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
		let selectedDate: String = dateFormatter.string(from: sender.date)
		//dateStringValue()
		print("Selected value \(selectedDate)")
	}
	@objc func confirmButtonClicked(sender : UIButton){
		hideCardAndGoBack()
	}
	private func layout() {
		self.view.adds([grayImage, dimmerView, cardView])
		grayImage.snp.makeConstraints{
			$0.bottom.equalToSuperview().offset(0)
			$0.top.equalToSuperview().offset(0)
			$0.trailing.equalToSuperview().offset(0)
			$0.leading.equalToSuperview().offset(0)
		}
		dimmerView.snp.makeConstraints{
			$0.bottom.equalToSuperview().offset(0)
			$0.top.equalToSuperview().offset(0)
			$0.trailing.equalToSuperview().offset(0)
			$0.leading.equalToSuperview().offset(0)
		}
		
		cardView.snp.makeConstraints{
			$0.bottom.equalToSuperview().offset(0)
			$0.trailing.equalToSuperview().offset(0)
			$0.leading.equalToSuperview().offset(0)
			if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
				 let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
				
				cardView.snp.updateConstraints{
					$0.top.equalToSuperview().offset(safeAreaHeight + bottomPadding)
				}
			}
			cardView.adds([datePicker, confirmButton])
			datePicker.snp.makeConstraints{
				$0.leading.equalTo(cardView.snp.leading)
				$0.trailing.equalTo(cardView.snp.trailing)
				$0.top.equalTo(cardView.snp.top).offset(49)
				$0.bottom.equalTo(cardView.snp.bottom)
			}
			confirmButton.snp.makeConstraints{
				$0.top.equalTo(cardView.snp.top)
				$0.bottom.equalTo(datePicker.snp.top)
				$0.trailing.equalTo(cardView.snp.trailing)
				$0.width.equalTo(40)
			}
			if pickerMode == 0 {
				datePicker.datePickerMode = .date
				datePicker.minimumDate = Date()
			}
			else {
				datePicker.datePickerMode = .time
			}
			dimmerView.alpha = 0.0
		}
		let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped(_:)))
		dimmerView.addGestureRecognizer(dimmerTap)
		dimmerView.isUserInteractionEnabled = true
	}
	@objc func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
		hideCardAndGoBack()
	}
	override func viewDidAppear(_ animated: Bool) {
		showCard()
	}
	
	private func showCard(){
		self.view.layoutIfNeeded()
		if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
			 let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
			
			cardView.snp.updateConstraints{
				$0.top.equalToSuperview().offset((safeAreaHeight + bottomPadding) / 1.66)
			}
		}
		let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
			self.view.layoutIfNeeded()
		})
		showCard.addAnimations({
			self.dimmerView.alpha = 0.7
		})
		showCard.startAnimation()
	}

	func bind() {
		let dateFormatter: DateFormatter = DateFormatter()
		switch pickerMode {
		case 0:
			
			dateFormatter.dateFormat = "yyyy-MM-dd"
			self.datePicker.rx.date.map{ dateFormatter.string(from: $0) }
				.bind(onNext: {a in self.requestData.date.onNext(a)})
			.disposed(by: disposeBag)
		case 1:
			dateFormatter.dateFormat = "HH"
			self.datePicker.rx.date.map{
				dateFormatter.string(from: $0)}
				.bind(to: requestData.startTime)
			.disposed(by: disposeBag)
		case 2:
			dateFormatter.dateFormat = "HH"
			self.datePicker.rx.date.map{dateFormatter.string(from: $0)}
				.bind(to: requestData.endTime)
			.disposed(by: disposeBag)
		default:
			dateFormatter.dateFormat = "yyyy-MM-dd"
		}
	}
	private func hideCardAndGoBack(){
		self.view.layoutIfNeeded()
		if let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
			 let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
			cardView.snp.updateConstraints{
				$0.top.equalToSuperview().offset(safeAreaHeight + bottomPadding)
			}
		}
		let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
			self.view.layoutIfNeeded()
		})
		hideCard.addAnimations {
			self.dimmerView.alpha = 0.0
		}
		hideCard.addCompletion({ position in
			if position == .end {
				if(self.presentingViewController != nil) {

					self.dismiss(animated: false, completion: nil)
				}
			}
		})
		hideCard.startAnimation()
	}
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		bind()
		layout()
		// Do any additional setup after loading the view.
	}
}
