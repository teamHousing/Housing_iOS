//
//  CameraRollCollectionViewCell.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/09.
//

import UIKit

class CameraRollCollectionViewCell: UICollectionViewCell {
	static let registerId = "\(CameraRollCollectionViewCell.self)"

	
	private let cameraView = UIView().then{
		$0.backgroundColor = .white
		$0.setRounded(radius: 16)
		$0.setBorder(borderColor: .systemGray6, borderWidth: 1)
		$0.isUserInteractionEnabled = true
		$0.isMultipleTouchEnabled = true
		let icon = UIImageView()
		let description = UILabel().then {
			$0.text = "이미지 첨부하기"
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
		icon.image = UIImage(named: "img3")
		description.snp.makeConstraints{
			$0.trailing.equalToSuperview().offset(-23)
			$0.top.equalToSuperview().offset(88)
			$0.leading.equalToSuperview().offset(16)
			$0.bottom.equalToSuperview().offset(-24)
		}
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		bindConstraints()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		bindConstraints()
	}
	private func bindConstraints() {
		adds([cameraView])
		cameraView.snp.makeConstraints{
			$0.edges.equalTo(0)
		}
	}
}
