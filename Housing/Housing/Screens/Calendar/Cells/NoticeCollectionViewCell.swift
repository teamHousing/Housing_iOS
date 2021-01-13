//
//  NoticeCollectionViewCell.swift
//  Housing
//
//  Created by 오준현 on 2021/01/03.
//

import UIKit

final class NoticeCollectionViewCell: UICollectionViewCell {
	private let containerView = UIView().then {
		$0.backgroundColor = .white
		$0.layer.cornerRadius = 10
		$0.layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 8)
	}
	private let pointView = UIView().then {
		$0.backgroundColor = .periwinkleBlue
		$0.layer.cornerRadius = 5.5
	}
	private let titleLabel = UILabel().then {
		$0.text = "엘리베이터 점검예정"
		$0.textColor = .primaryBlack
		$0.font = .systemFont(ofSize: 15, weight: .bold)
	}
	private let timeLabel = UILabel().then {
		$0.text = "오후 12:00~14:00"
		$0.textColor = .gray02
		$0.font = .systemFont(ofSize: 12, weight: .regular)
	}
	private let shadowView = UIView()
	
	var calendar: FSCalendarModel?
	
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
			titleLabel,
			timeLabel
		])

		containerView.add(shadowView) {
			$0.snp.makeConstraints {
				$0.edges.equalTo(self.containerView)
			}
		}
		
		containerView.snp.makeConstraints {
			$0.leading.equalTo(contentView).offset(20)
			$0.trailing.equalTo(contentView).offset(-20)
			$0.top.equalTo(contentView)
			$0.height.equalTo(78)
		}
		pointView.snp.makeConstraints {
			$0.width.height.equalTo(11)
			$0.leading.equalTo(containerView.snp.leading).offset(24)
			$0.centerY.equalTo(containerView.snp.centerY)
		}
		titleLabel.snp.makeConstraints {
			$0.leading.equalTo(pointView.snp.trailing).offset(26)
			$0.top.equalTo(contentView).offset(18)
		}
		timeLabel.snp.makeConstraints {
			$0.leading.equalTo(titleLabel)
			$0.top.equalTo(titleLabel.snp.bottom).offset(7)
		}
	}
	func fetchCalendar() {
		titleLabel.text = calendar?.title
	}
	func fetchTime() {
		let times = calendar?.time.split(separator: "-")
		guard let startTime = Int(times?[0] ?? "0") else {return}
		guard let endTime = Int(times?[1] ?? "0") else {return}
		if startTime > 12 && endTime > 12 {
			timeLabel.text = "오후 \(startTime-12):00 ~ 오후 \(endTime-12):00"
		} else if startTime > 12 && endTime <= 12 {
			timeLabel.text = "오후 \(startTime-12):00 ~ 오전 \(endTime):00"
		} else if startTime <= 12 && endTime > 12 {
			timeLabel.text = "오전 \(startTime):00 ~ 오후 \(endTime-12):00"
		} else {
			timeLabel.text = "오전 \(startTime):00 ~ 오전 \(endTime):00"
		}
	}

}
