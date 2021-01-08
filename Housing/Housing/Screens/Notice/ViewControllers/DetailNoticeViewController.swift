//
//  DetailNoticeViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/08.
//

import UIKit

class DetailNoticeViewController: UIViewController {
    
    //MARK:- Property
    var titleData: String?
    var contextData: String?
    
    //MARK:- Component(Outlet)
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailContext: UILabel!
    
    //캘린더 추가 공지 컴포넌트를 담은 뷰
    @IBOutlet weak var entireComponents: UIView!
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var addedNoticeView: UIView!
    
    //날짜 시간 방법
    @IBOutlet weak var dateOfNotice: UILabel!
    @IBOutlet weak var timeOfNotice: UILabel!
    @IBOutlet weak var wayOfNotice: UILabel!
    
    //캘린더에 추가된 공지인지
    @IBOutlet weak var isAddedToCalendar: UILabel!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        initData()
    }
    
    //MARK:- Helper
    func initLayout() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(toNotice))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        circleView.cornerRadius = circleView.frame.height / 2
        
        addedNoticeView.layer.cornerRadius = 12
    }
    func initData() {
        detailTitle.text = titleData
        detailContext.text = contextData
    }
    @objc func toNotice() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Component(Action)
}
