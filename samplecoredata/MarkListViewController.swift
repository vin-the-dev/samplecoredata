//
//  MarkListViewController.swift
//  samplecoredata
//
//  Created by Vineeth Vijayan on 6/27/18.
//  Copyright © 2018 Naico ITS. All rights reserved.
//

import UIKit
import CoreData

class MarkListViewController: UIViewController {
    
    var student: Student?
    
    fileprivate var studentMarkList = [MarkList]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mark List"
        
        if student != nil {
            self.title = student?.firstname
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        studentMarkList = student?.marks?.allObjects as! [MarkList]
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddMarksViewController {
            destination.student = self.student
        }
    }

}

extension MarkListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentMarkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = studentMarkList[indexPath.row].marksubject?.subjectname
        cell.detailTextLabel?.text = String(studentMarkList[indexPath.row].marks)
        return cell
    }
}

