//
//  ViewController.swift
//  App20220320RealTimeDB
//
//  Created by grace on 2022/3/26.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    // 設定資料庫reference
    var dbRef:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference()
        
        Auth.auth().signInAnonymously { (user, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showHint(title: "FireBase Auth fail", message: error?.localizedDescription ?? "")
            } else {
                // 0.有變化時印出
                self.dbRef.child("appStatus").observe(.childChanged) { dataSnapshot in
                    print("dataSnapshot change: \(dataSnapshot)")
                    print()
                }
                self.dbRef.child("appStatus").observe(.childAdded) { dataSnapshot in
                    print("dataSnapshot add: \(dataSnapshot)")
                    print()
                }
                self.dbRef.child("appStatus").observe(.childMoved) { dataSnapshot in
                    print("dataSnapshot moved: \(dataSnapshot)")
                    print()
                }
                self.dbRef.child("appStatus").observe(.childRemoved) { dataSnapshot in
                    print("dataSnapshot remove: \(dataSnapshot)")
                    print()
                }
                
                // 1.讀取資料
                self.dbRef.child("appStatus/ver").observeSingleEvent(of: .value) { (snapshot) in
                    print("App Codename:\(snapshot.value as! Int)")
                }
                
                // 2.寫入資料
                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = df.string(from: date)
                
                self.dbRef.child("appStatus/description").setValue("這是測試的資料 in \(dateString)")
                
                // 3.Add auto id
                self.dbRef.child("appStatus/setting/time").childByAutoId().setValue(ServerValue.timestamp())
            }
        }
    }

    func showHint(title: String, message: String) {
        // 建立一個提示框
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)

        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
            (action: UIAlertAction!) -> Void in
              print("按下確認後，閉包裡的動作")
        })
        alertController.addAction(okAction)

        // 顯示提示框
        self.present(
          alertController,
          animated: true,
          completion: nil)
    }

}

