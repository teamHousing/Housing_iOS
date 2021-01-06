//
//  AppointmentViewController.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/06.
//

import UIKit

class AppointmentViewController: UIViewController {

	var requestData = RequestDataModel.shared
	private let totalScroll = UIScrollView()
	private let contentView = UIView()
	private let backgroundLabel = UILabel().then{
		$0.text = "무슨 일이 생겼나요?"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private let lineImage = UIView().then {
		$0.backgroundColor = UIColor.primaryBlack
		$0.tintColor = UIColor.primaryBlack
	}
	private let solutionLabel = UILabel().then{
		$0.text = "해결을 위해서는"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black
		$0.textAlignment = .left
	}
	private let promiseRequiredView = UIView().then{
		$0.backgroundColor = .white
		$0.setRounded(radius: 16)
		$0.setBorder(borderColor: .salmon, borderWidth: 2)
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		let icon = UIImageView()
		let description = UILabel().then {
			$0.text = """
				집주인과
				약속이 필요한 문의에요!
				"""
			$0.textColor = .black
			$0.numberOfLines = 2
			$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		}
		$0.adds([icon,description])
		icon.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-8)
			$0.top.equalToSuperview().offset(4)
			$0.leading.equalToSuperview().offset(74)
			$0.bottom.equalToSuperview().offset(-60)
		}
		description.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-23)
			$0.top.equalToSuperview().offset(88)
			$0.leading.equalToSuperview().offset(16)
			$0.bottom.equalToSuperview().offset(-24)
		}
		
	}
	private let promiseNotRequiredView = UIView().then{
		$0.backgroundColor = .white
		$0.setRounded(radius: 16)
		$0.setBorder(borderColor: .systemGray6, borderWidth: 1)
		let icon = UIImageView()
		let description = UILabel().then {
			$0.text = """
				약속이 필요없는
				문의에요!
				"""
			$0.numberOfLines = 2
			$0.textColor = .black

			$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
		}
		$0.adds([icon,description])
		icon.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-8)
			$0.top.equalToSuperview().offset(4)
			$0.leading.equalToSuperview().offset(74)
			$0.bottom.equalToSuperview().offset(-60)
		}
		description.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-23)
			$0.top.equalToSuperview().offset(88)
			$0.leading.equalToSuperview().offset(16)
			$0.bottom.equalToSuperview().offset(-24)
		}
		
	}

	private let requestTypeLabel = UILabel().then{
		$0.text = "어떤 종류의 문제인가요?"
		$0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
		$0.textColor = .black

	}
	
	
	
	private func layout() {
		self.navigationController?.navigationBar.backgroundColor = .white
		self.view.backgroundColor = .white
		self.view.addSubview(totalScroll)
		totalScroll.snp.makeConstraints{
			$0.edges.equalToSuperview()
		}
		self.totalScroll.addSubview(contentView)
		contentView.snp.makeConstraints{
			$0.width.equalToSuperview().priority(1000)
			$0.centerX.top.bottom.equalToSuperview()
		}
		
	}
    override func viewDidLoad() {
        super.viewDidLoad()

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
