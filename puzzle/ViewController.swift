//
//  ViewController.swift
//  puzzle
//
//  Created by user on 12/20/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func startBtnClick(_ sender: Any) {
        self.navigationController?.pushViewController(mainViewController(), animated: true)
    }
}

