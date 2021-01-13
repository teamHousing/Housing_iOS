//
//  EmptyCalendarCollectionViewCell.swift
//  Housing
//
//  Created by 오준현 on 2021/01/13.
//

import UIKit

class EmptyCalendarCollectionViewCell: UICollectionViewCell {
	
	let noticeLabel = UILabel().then {
		$0.text = "일정이 없습니다"
		$0.font = .systemFont(ofSize: 13, weight: .regular)
		$0.textColor = .textGrayBlank
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
		contentView.add(noticeLabel) {
			$0.snp.makeConstraints {
				$0.centerY.centerX.equalTo(self.contentView)
			}
		}
	}
}
