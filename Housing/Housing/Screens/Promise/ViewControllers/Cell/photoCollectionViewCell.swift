//
//  photoCollectionViewCell.swift
//  Housing
//
//  Created by 김태훈 on 2021/01/04.
//

import UIKit

class photoCollectionViewCell: UICollectionViewCell {
    static let identifier = "photos"
	
	static let registerId = "\(photoCollectionViewCell.self)"
	let evidenceImages = UIImageView().then{
		$0.setRounded(radius: 15)
		$0.layer.applyShadow()
	}
	let deleteBtn = UIButton().then{
		$0.isHidden = false
		$0.setImage(UIImage(named:"btnDelete2"), for: .normal)
	}
	func bindConstraints() {
		adds([evidenceImages,
		deleteBtn])
		evidenceImages.snp.makeConstraints{
			$0.edges.equalTo(0)
		}
		deleteBtn.snp.makeConstraints{
			$0.top.equalTo(evidenceImages.snp.top)
			$0.trailing.equalTo(evidenceImages.snp.trailing)
			$0.width.height.equalTo(44)
			
		}
	}
	let cameraView = UIView().then{
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
	func cameraAsset() {
		adds([cameraView])
		cameraView.snp.makeConstraints{
			$0.edges.equalTo(0)
		}
	}
	let addbuttonView = UIView().then{
		$0.setRounded(radius: 15)
		$0.setBorder(borderColor: .systemGray6, borderWidth: 1)

		
	}
	let asset = UIImageView().then{
		$0.image = UIImage(named: "btnPlus")
	}
	 func addFromCameraRoll() {
		//self.layer.applyShadow()
		adds([addbuttonView])
		addbuttonView.snp.makeConstraints{
			$0.edges.equalTo(0)
		}
		addbuttonView.addSubview(asset)
		asset.snp.makeConstraints{
			$0.centerX.centerY.equalTo(addbuttonView)
			$0.width.height.equalTo(28)
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
	}

	
}
