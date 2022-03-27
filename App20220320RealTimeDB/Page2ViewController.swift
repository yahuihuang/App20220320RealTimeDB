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
    var subjectArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome: \(nickname)"
        
        dbRef = Database.database().reference().child("for/subs")
        dbRef.observeSingleEvent(of: .value) { dataSnapshot in
//            print(dataSnapshot)
            self.subjectArray.removeAll()
            
            for item in dataSnapshot.children {
                if let mySubject = item as? DataSnapshot {
                    let subject = mySubject.childSnapshot(forPath: "subject").value as? String ?? ""
                    self.subjectArray.append(subject)
                }
            }
            
            print(self.subjectArray)
        }
    }
}
