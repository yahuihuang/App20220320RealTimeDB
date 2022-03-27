//
//  Page3ViewController.swift
//  App20220320RealTimeDB
//
//  Created by grace on 2022/3/27.
//

import UIKit
import Firebase

class Page3ViewController: UIViewController {
    // 設定資料庫reference
    var dbRef: DatabaseReference!
    var key = ""
    var subject = ""
    
    @IBOutlet weak var ctf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = key + ": " + subject
        
        // MARK: RealTime DataBase
        dbRef = Database.database().reference().child("disc").child(key)
    }

    @IBAction func newMessageAction(_ sender: Any) {
        let newMsg = ctf.text ?? ""
        if newMsg.count < 1{
            let alert = UIAlertController(title: "請至少輸入一個字", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        dbRef.childByAutoId().child("content").setValue(newMsg)
        ctf.text = ""
    }
}
