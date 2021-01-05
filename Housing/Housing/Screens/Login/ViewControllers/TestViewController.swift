//
//  TestViewController.swift
//  Housing
//
//  Created by 곽기곤's Mac on 2021/01/06.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        idTextField.borderWidth = 1
        idTextField.borderColor = .white
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
