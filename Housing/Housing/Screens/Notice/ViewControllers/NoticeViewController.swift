//
//  NoticeViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/08.
//

import UIKit

class NoticeViewController: UIViewController {
    //MARK:- Component(Outlet)
    @IBOutlet weak var noticeCollectionView: UICollectionView!
    
    //MARK:- Property
    var noticeList: [NoticeData] = []
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        setNoticeList()
        
        noticeCollectionView.delegate = self
        noticeCollectionView.dataSource = self
    }
    
    //MARK:- Helper
    func initLayout() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    func setNoticeList() {
        noticeList.append(contentsOf: [
            NoticeData.init(title: "11월 관리비 입금 안내", context: "입금계좌 : 1002455115135(우리은행/김미정) 용돈 환영~! 카카오페이도 가능~!~!~!~! 이것도 최대 2줄~~~~~~"),
            NoticeData.init(title: "22월 관리비 입금 안내", context: "입금계좌 : 1002455115135(우리은행/김미정) 용돈 환영~! 카카오페이도 가능~!~!~!~! 이것도 최대 2줄~~~~~~"),
            NoticeData.init(title: "33월 관리비 입금 안내", context: "입금계좌 : 1002455115135(우리은행/김미정) 용돈 환영~! 카카오페이도 가능~!~!~!~! 이것도 최대 2줄~~~~~~")
        ])
    }
    
    //MARK:- Component(Action)
    @IBAction func makeVerifyCode(_ sender: Any) {
        
    }
}

//MARK:- Extension Object
extension NoticeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticeInformationCollectionViewCell", for: indexPath) as? NoticeInformationCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.FDF = noticeList[indexPath.row]
        cell.fetchData()
        
        cell.contentView.layer.cornerRadius = 16 / 2
        cell.contentView.layer.backgroundColor = UIColor.white.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.10000000149011612)
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 16 / 2
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = nil
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath

        return cell
    }
}

extension NoticeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 40, height: 116)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
}

extension NoticeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NoticeHeaderCollectionViewCell", for: indexPath) as? NoticeHeaderCollectionViewCell {
                
                headerView.contentView.layer.cornerRadius = 16 / 2
                headerView.contentView.layer.backgroundColor = UIColor.clear.cgColor
                headerView.contentView.layer.masksToBounds = true
                
                headerView.headerBackgroundView.layer.shadowColor = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.10000000149011612)
                headerView.headerBackgroundView.layer.shadowOffset = .zero
                headerView.headerBackgroundView.layer.shadowRadius = 16 / 2
                headerView.headerBackgroundView.layer.shadowOpacity = 1
                headerView.headerBackgroundView.layer.masksToBounds = false
                headerView.headerBackgroundView.layer.shadowPath = nil
                headerView.headerBackgroundView.layer.shadowPath = UIBezierPath(roundedRect:headerView.bounds, cornerRadius:headerView.contentView.layer.cornerRadius).cgPath
                
                
                headerView.headerBackgroundView.clipsToBounds = true
                headerView.headerBackgroundView.layer.cornerRadius = 16 / 2
                headerView.headerBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                
                return headerView
            }
        case UICollectionView.elementKindSectionFooter:
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NoticeFooterCollectionViewCell", for: indexPath) as? NoticeFooterCollectionViewCell {
                
                return footerView
            }
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
}
