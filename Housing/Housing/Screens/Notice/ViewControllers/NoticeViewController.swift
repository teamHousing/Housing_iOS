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
            NoticeData.init(title: "11월 관리비 입금 안내", context: "입금계좌 : 1002455115135(우리은행/김미정) 용돈 환영~!  카카오페이도 가능~!~!~!~! 이것도 최대 2줄"),
            NoticeData.init(title: "11월 관리비 입금 안내", context: "입금계좌 : 1002455115135(우리은행/김미정) 용돈 환영~! \n 카카오페이도 가능~!~!~!~! 이것도 최대 2줄"),
            NoticeData.init(title: "11월 관리비 입금 안내", context: "입금계좌 : 1002455115135(우리은행/김미정) 용돈 환영~! \n 카카오페이도 가능~!~!~!~! 이것도 최대 2줄")
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
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 5
        print(cell.contextLabel.frame.width)
        
        return cell
    }
}

extension NoticeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 116)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension NoticeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NoticeHeaderCollectionViewCell", for: indexPath) as? NoticeHeaderCollectionViewCell {
                
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
