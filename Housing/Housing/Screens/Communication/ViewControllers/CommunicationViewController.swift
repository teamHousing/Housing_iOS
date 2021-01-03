//
//  CommunicationViewController.swift
//  Housing
//
//  Created by 김주은 on 2021/01/01.
//

import UIKit

class CommunicationViewController: UIViewController {
	
	//MARK: COMPONENT
	@IBOutlet var communicationTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		communicationTableView.delegate = self
		communicationTableView.dataSource = self
	}
	
}
extension CommunicationViewController: UITableViewDelegate{
	
	
}

extension CommunicationViewController: UITableViewDataSource{
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return 4
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
		return cell
	}
	
	
	
}
