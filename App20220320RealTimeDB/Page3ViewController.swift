//
//  Page3ViewController.swift
//  App20220320RealTimeDB
//
//  Created by grace on 2022/3/27.
//

import UIKit
import Firebase

class Page3ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var page3TableView: UITableView!
    // 設定資料庫reference
    var dbRef: DatabaseReference!
    var key = ""
    var subject = ""
    var nickName = ""
    var contentArray: [String] = []
    
    @IBOutlet weak var ctf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = key + ": " + subject
        
        // MARK: RealTime DataBase
        dbRef = Database.database().reference().child("disc").child(key)
        
        // MARK: TableView
        page3TableView.delegate = self
        page3TableView.dataSource = self
        
        dbRef.observe(.value) { dataSnapshot in
            self.contentArray.removeAll()
            for item in dataSnapshot.children {
                if let content = item as? DataSnapshot {
                    print(content)
                    
                    let contentData = content.childSnapshot(forPath: "content").value as? String ?? ""
                    self.contentArray.append(contentData)
                }
                
                self.page3TableView.reloadData()
            }
        }
    }


    @IBAction func newMessageAction(_ sender: Any) {
        let newMsg = ctf.text ?? ""
        if newMsg.count < 1{
            let alert = UIAlertController(title: "請至少輸入一個字", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        dbRef.childByAutoId().child("content").setValue("[\(nickName)] \(newMsg)")
        ctf.text = ""
    }
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = contentArray[indexPath.row]
        return cell
    }
    
}
