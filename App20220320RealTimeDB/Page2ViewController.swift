//
//  Page2ViewController.swift
//  App20220320RealTimeDB
//
//  Created by grace on 2022/3/27.
//

import UIKit

class Page2ViewController: UIViewController {
    var nickname = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome: \(nickname)"
    }
}
