//
//  Page2ViewController.swift
//  App20220320RealTimeDB
//
//  Created by grace on 2022/3/27.
//

import UIKit
import Firebase

class Page2ViewController: UIViewController {
    // 設定資料庫reference
    var dbRef:DatabaseReference!
    var nickname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome: \(nickname)"
        
        dbRef = Database.database().reference()
        dbRef.observeSingleEvent(of: .value) { dataSnapshot in
            print(dataSnapshot)
            for item in dataSnapshot.children {
                print("=========")
                print(item)
            }
        }
    }
}
