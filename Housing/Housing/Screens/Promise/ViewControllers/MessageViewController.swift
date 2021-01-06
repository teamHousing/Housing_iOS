//
//  MessageViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/05.
//
import Then
import SnapKit

import UIKit

class MessageViewController: UIViewController {

	var requestData = RequestDataModel.shared
	func dataPreset() {
		requestData.editionalRequest = "늘 감사합니다 :)"
	}
	private let mainLabel = UILabel().then {
		$0.numberOfLines = 2
		$0.text = """
							집주인께
							전하고 싶은 말이 있나요?
							"""
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	
	private let lineImage = UIView().then {
		$0.backgroundColor = UIColor.primaryBlack
		$0.tintColor = UIColor.primaryBlack
		}
	
	private let presetButton1 = UIButton().then {
		$0.setTitle("늘 감사합니다 :)", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 12)
		$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		$0.contentHorizontalAlignment = .left
		$0.setBorder(borderColor: .salmon, borderWidth: 2)
		$0.setTitleColor(.black, for: .normal)
		$0.addTarget(self, action: #selector(presetMessageSelected), for: .touchUpInside)

	}
	private let presetButton2 = UIButton().then {
		$0.setTitle("최대한 신속하게 확인 부탁드려요.", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 12)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		$0.contentHorizontalAlignment = .left
		$0.setTitleColor(.black, for: .normal)
		$0.addTarget(self, action: #selector(presetMessageSelected), for: .touchUpInside)

	}
	private let presetButton3 = UIButton().then {
		$0.setTitle("방문 전 사전 연락 부탁드려요.", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 12)
		$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		$0.contentHorizontalAlignment = .left
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.setTitleColor(.black, for: .normal)
		$0.addTarget(self, action: #selector(presetMessageSelected), for: .touchUpInside)

	}
	private let presetButton4 = UIButton().then {
		$0.setTitle("부재 시 먼저 연락드리겠습니다.", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 12)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
		$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		$0.contentHorizontalAlignment = .left
		$0.setTitleColor(.black, for: .normal)
		$0.addTarget(self, action: #selector(presetMessageSelected), for: .touchUpInside)
	}
	private let presetButton5 = UITextField().then {
		$0.text = "직접 입력하기"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.setRounded(radius: 12)
		$0.setBorder(borderColor: .gray01, borderWidth: 1)
	}
	private let nextStep = UIButton().then {
		$0.setTitle("다음 단계", for: .normal)
		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		$0.backgroundColor = .black
		$0.setRounded(radius: 25)
		
		$0.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
	}
	
	private let page = UIPageControl().then{
		$0.numberOfPages = 4
		$0.currentPage = 2
		$0.currentPageIndicatorTintColor = .salmon
		$0.tintColor = .gray01
		$0.pageIndicatorTintColor = .gray01
	}
	@objc func nextButtonDidTapped() {
		let appointmentview = AppointmentViewController()
		self.navigationController?.pushViewController(appointmentview, animated: true)
	}
	@objc func presetMessageSelected(sender : UIButton) {
		clearSelection()
		sender.setBorder(borderColor: .salmon, borderWidth: 2)
		sender.layer.applyShadow()
		requestData.editionalRequest = sender.titleLabel?.text ?? ""
	}
	
	func clearSelection() {
		self.presetButton1.setBorder(borderColor: .gray01, borderWidth: 1)
		self.presetButton2.setBorder(borderColor: .gray01, borderWidth: 1)
		self.presetButton3.setBorder(borderColor: .gray01, borderWidth: 1)
		self.presetButton4.setBorder(borderColor: .gray01, borderWidth: 1)
		self.presetButton5.setBorder(borderColor: .gray01, borderWidth: 1)

	}
	
	private func widthConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewWidth = self.view.frame.width
		
		return (value / 375) * superViewWidth
	}
	private func heightConstraintAmount(value : CGFloat) -> CGFloat {
		let superViewHeight = self.view.frame.height
		
		return (value / 698) * superViewHeight
	}
	private func layout() {
		self.navigationController?.navigationBar.backgroundColor = .white
		self.view.backgroundColor = .white
		self.view.adds([
		mainLabel,
		lineImage,
			presetButton1,
			presetButton2,
			presetButton3,
			presetButton4,
			presetButton5,
			nextStep,
			page
		])
		 mainLabel.snp.makeConstraints{
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.leading.equalTo(view).offset(widthConstraintAmount(value: 20))
			$0.trailing.equalTo(view).offset(widthConstraintAmount(value: -101))
		}
		lineImage.snp.makeConstraints{
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(58)
			$0.trailing.equalTo(view.safeAreaLayoutGuide).offset(0)
			$0.leading.equalTo(mainLabel.snp.trailing).offset(8)
			$0.height.equalTo(1)
			$0.width.equalTo(widthConstraintAmount(value: widthConstraintAmount(value: 93)))
		}
		presetButton1.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(lineImage.snp.bottom).offset(49)
		}
		presetButton2.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(presetButton1.snp.bottom).offset(12)
		}
		presetButton3.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(presetButton2.snp.bottom).offset(12)
		}
		presetButton4.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(presetButton3.snp.bottom).offset(12)
		}
		presetButton5.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 335))
			$0.height.equalTo(presetButton1.snp.width).multipliedBy(1/5.9821)
			$0.top.equalTo(presetButton4.snp.bottom).offset(12)
		}
		if !requestData.isPromiseNeeded {
			nextStep.setTitle("등록하기", for: .normal)
			nextStep.removeTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
			//nextStep.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
			page.numberOfPages = 3
			
		}
		nextStep.snp.makeConstraints{
			$0.centerX.equalTo(view)
			$0.width.equalTo(widthConstraintAmount(value: 255))
			$0.height.equalTo(48)
			$0.top.equalTo(presetButton5.snp.bottom).offset(60)
			
		}
		page.snp.makeConstraints{
			$0.top.equalTo(nextStep.snp.bottom).offset(24)
			$0.bottom.equalToSuperview()
			$0.height.equalTo(20)
			$0.centerX.equalToSuperview()
		}
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
			dataPreset()
			layout()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MessageViewController : UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		clearSelection()
		if textField.text == "직접 입력하기" {
			textField.text = nil
		}
		textField.setBorder(borderColor: .salmon, borderWidth: 2)
	}
	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField.text == nil {
			textField.text = "직접 입력하기"
		}
		
		requestData.editionalRequest = textField.text ?? ""
	}
}
