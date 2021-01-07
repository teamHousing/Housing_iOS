//
//  CalendarCollectionViewCell.swift
//  Housing
//
//  Created by 오준현 on 2021/01/03.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
	
	private let containerView = UIView().then {
		$0.backgroundColor = .white
		$0.layer.cornerRadius = 10
	}
	private let pointView = UIView().then {
		$0.backgroundColor = .primaryOrange
		$0.layer.cornerRadius = 5.5
	}
	private let categoryContainerView = UIView().then {
		$0.backgroundColor = .primaryBlack
		$0.layer.cornerRadius = 9.5
	}
	private let categoryLabel = UILabel().then {
		$0.text = "고정/수리"
		$0.textColor = .primaryWhite
		$0.font = .systemFont(ofSize: 9, weight: .semibold)
	}
	private let categoryGuideLabel = UILabel().then {
		$0.text = "에 대한 약속"
		$0.textColor = .primaryBlack
		$0.font = .systemFont(ofSize: 11, weight: .regular)
	}
	private let titleLabel = UILabel().then {
		$0.text = "수도꼭지가 고장났어요"
		$0.textColor = .primaryBlack
		$0.font = .systemFont(ofSize: 15, weight: .bold)
	}
	private let homeLabel = UILabel().then {
		$0.text = "202호"
		$0.textColor = .gray02
		$0.font = .systemFont(ofSize: 12, weight: .regular)
	}
	private let promiseLabel = UILabel().then {
		$0.text = "집 방문"
		$0.textColor = .gray02
		$0.font = .systemFont(ofSize: 12, weight: .regular)
	}
	private let timeLabel = UILabel().then {
		$0.text = "오후 12:00~14:00"
		$0.textColor = .gray02
		$0.font = .systemFont(ofSize: 12, weight: .regular)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func layout() {
		contentView.backgroundColor = .primaryGray
		contentView.adds([
			containerView,
			pointView,
			categoryContainerView,
			categoryLabel,
			categoryGuideLabel,
			titleLabel,
			homeLabel,
			promiseLabel,
			timeLabel
		])
		
		containerView.snp.makeConstraints {
			$0.leading.equalTo(contentView).offset(20)
			$0.trailing.equalTo(contentView).offset(-20)
			$0.top.equalTo(contentView)
			$0.height.equalTo(96)
		}
		pointView.snp.makeConstraints {
			$0.width.height.equalTo(11)
			$0.leading.equalTo(containerView.snp.leading).offset(24)
			$0.centerY.equalTo(containerView.snp.centerY)
		}
		categoryLabel.snp.makeConstraints {
			$0.leading.equalTo(pointView.snp.trailing).offset(34)
			$0.top.equalTo(containerView.snp.top).offset(18)
		}
		categoryContainerView.snp.makeConstraints {
			$0.leading.equalTo(categoryLabel.snp.leading).offset(-8)
			$0.top.equalTo(categoryLabel.snp.top).offset(-4)
			$0.bottom.equalTo(categoryLabel.snp.bottom).offset(4)
			$0.trailing.equalTo(categoryLabel.snp.trailing).offset(8)
		}
		categoryGuideLabel.snp.makeConstraints {
			$0.leading.equalTo(categoryContainerView.snp.trailing).offset(4)
			$0.centerY.equalTo(categoryLabel)
		}
		titleLabel.snp.makeConstraints {
			$0.leading.equalTo(categoryContainerView)
			$0.centerY.equalTo(pointView)
		}
		homeLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(8)
			$0.leading.equalTo(titleLabel.snp.leading)
		}
		promiseLabel.snp.makeConstraints {
			$0.leading.equalTo(homeLabel.snp.trailing).offset(8)
			$0.centerY.equalTo(homeLabel)
		}
		timeLabel.snp.makeConstraints {
			$0.leading.equalTo(promiseLabel.snp.trailing).offset(8)
			$0.centerY.equalTo(homeLabel)
		}
	}
}
