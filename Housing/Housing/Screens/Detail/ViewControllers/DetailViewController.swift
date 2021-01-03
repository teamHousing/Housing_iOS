//
//  DetailViewController.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/01.
//

import UIKit

import SegementSlide
import Then
import SnapKit

class DetailViewController: SegementSlideDefaultViewController {
	
	var category : String = "고장/수리"
	var status : String = "확인 전"
	var viewTitle : String = "수도꼭지가 고장났어요ㅠ 집이 물바다"
	var context : String = "저희 집 화장실 세면대에 수도꼭지가 고장나서 물이 계속 새고 있는데 이러다 수도세가 너무 많이 나올 것 같아요ㅠ \n\n글 확인하시면 최대한 빠르게 수리 부탁드립니다..!!"
	
	override func segementSlideHeaderView() -> UIView? {
		let categoryLabel = UILabel()
		let statusLabel = UILabel()
		let titleLabel = UILabel()
		let categoryContainerView = UIView()
		let contextLabel = UILabel()
		let headerHeight : CGFloat = CGFloat(267)
		let headerView = UIView().then{
			$0.isUserInteractionEnabled = true
			$0.contentMode = .scaleAspectFill
			$0.snp.makeConstraints{
				$0.height.equalTo(headerHeight)
			}
		}
		headerView.add(categoryContainerView){
			$0.backgroundColor = .primaryBlack
			$0.layer.cornerRadius = 13
		}
		headerView.add(categoryLabel){
			$0.text = self.category
			$0.backgroundColor = UIColor.primaryBlack
			$0.textColor = UIColor.primaryWhite
			$0.textAlignment = .center
			$0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
			$0.snp.makeConstraints{
				$0.top.equalTo(headerView).offset(16)
				$0.leading.equalTo(headerView).offset(20)
			}
		}
		categoryContainerView.snp.makeConstraints{
			$0.top.equalTo(categoryLabel.snp.top).offset(-6)
			$0.bottom.equalTo(categoryLabel.snp.bottom).offset(6)
			$0.leading.equalTo(categoryLabel.snp.leading).offset(-10)
			$0.trailing.equalTo(categoryLabel.snp.trailing).offset(10)
		}
		headerView.add(statusLabel) {
			$0.text = self.status
			$0.textColor = .primaryOrange
			$0.textAlignment = .left
			$0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
			$0.snp.makeConstraints{
				$0.centerY.equalTo(categoryLabel.snp.centerY)
				$0.trailing.equalTo(headerView.snp.trailing).offset(-20)
				$0.width.equalTo(headerView.bounds.width*41/375)
				$0.height.equalTo(17)
			}
		}
		headerView.add(titleLabel) {
			$0.text = self.viewTitle
			$0.textAlignment = .left
			$0.font = UIFont.systemFont(ofSize: 21, weight: .bold)
			$0.snp.makeConstraints{
				$0.centerX.equalTo(headerView.snp.centerX)
				$0.top.equalTo(categoryLabel.snp.bottom).offset(20)
				$0.width.equalTo(headerView.frame.width*335/375)
				$0.height.equalTo(25)
			}
		}
		headerView.add(contextLabel) {
			$0.text = self.context
			$0.textAlignment = .left
			$0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
			$0.numberOfLines = 4
			$0.snp.makeConstraints{
				$0.centerX.equalTo(headerView.snp.centerX)
				$0.top.equalTo(titleLabel.snp.bottom).offset(40)
				$0.width.equalTo(titleLabel.snp.width)
			}
		}
		return headerView
	}
	
	override var titlesInSwitcher: [String] {
		return ["aaa","bbb"]
	}
	
	override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
					return ContentViewController()
			}
	
	// MARK : - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		defaultSelectedIndex = 0
		reloadData()
	}
}
