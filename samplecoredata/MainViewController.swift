//
//  ViewController.swift
//  samplecoredata
//
//  Created by Vineeth Vijayan on 6/26/18.
//  Copyright © 2018 Naico ITS. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var studentList = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Student List"
        
        
        SubjectModel.AddSubjects()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let context = PersistanceService.context
        
        let request: NSFetchRequest<Student> = Student.fetchRequest()
        
//        request.predicate = NSPredicate(format: "firstname contains[cd] %@", "e")

//        request.predicate = NSPredicate(format: "marks > %@", "50")
        
        let sort = NSSortDescriptor(key: #keyPath(Student.firstname), ascending: true)
        request.sortDescriptors = [sort]
        
//        request.returnsObjectsAsFaults = true
        
        do {
            let result = try PersistanceService.context.fetch(request)
            
            studentList = result
            
        } catch {
            
            print("Failed")
        }
        
//        let expressionDesc = NSExpressionDescription()
//        expressionDesc.name = "sumOftotalWorkTimeInHours"
//        expressionDesc.expression = NSExpression(forFunction: "sum:",
//                                                 arguments:[NSExpression(forKeyPath: "totalWorkTimeInHours")])
//        expressionDesc.expressionResultType = .integer32AttributeType
        
        tableView.reloadData()
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = studentList[indexPath.row].firstname! + " " + studentList[indexPath.row].lastname!
        
        let stu = studentList[indexPath.row]
    
        let sum = stu.marks?.reduce(0, { (result, val) -> Int in
            let m = val as! MarkList
            return  result + Int(m.marks)
        })
        cell.detailTextLabel?.text = String(sum!)
//        cell.detailTextLabel.text  = studentList[indexPath.row].marks
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: MarkListViewController = self.storyboard?.instantiateViewController(withIdentifier: "MarksListViewController") as! MarkListViewController
        vc.student = self.studentList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete") { (_, indexPath) in
            
            let context = PersistanceService.context
            
            context.delete(self.studentList[indexPath.row])
            self.studentList.remove(at: indexPath.row)
            do {
                try context.save()
            } catch _ {
            }
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            return
        }
        
        return [delAction]
    }
    
}

