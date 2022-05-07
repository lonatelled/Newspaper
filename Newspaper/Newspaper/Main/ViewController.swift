//
//  ViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 7.05.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "Tabbar")
//        self.navigationController?.pushViewController(vc, animated: false)
    }

    @IBAction func switchLogin(_ sender: UIButton) {
    }
    
}

