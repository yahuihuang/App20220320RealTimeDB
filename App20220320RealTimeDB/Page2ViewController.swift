//
//  Page2ViewController.swift
//  App20220320RealTimeDB
//
//  Created by grace on 2022/3/27.
//

import UIKit
import Firebase

class Page2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // 設定資料庫reference
    var dbRef:DatabaseReference!
    var nickname = ""
    var subjectArray: [String] = []
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome: \(nickname)"
        
        // MARK: TableView
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // MARK: RealTime DataBase
        dbRef = Database.database().reference().child("for/subs")
        dbRef.observeSingleEvent(of: .value) { dataSnapshot in
            self.subjectArray.removeAll()
            
            for item in dataSnapshot.children {
                if let mySubject = item as? DataSnapshot {
                    let subject = mySubject.childSnapshot(forPath: "subject").value as? String ?? ""
                    self.subjectArray.append(subject)
                }
            }
            
            print(self.subjectArray)
            
            // 讀完資料要重Load TableView
            self.myTableView.reloadData()
        }
    }
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = subjectArray[indexPath.row]
        return cell
    }
    
}
