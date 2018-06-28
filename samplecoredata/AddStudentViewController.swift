//
//  AddStudentViewController.swift
//  samplecoredata
//
//  Created by Vineeth Vijayan on 6/26/18.
//  Copyright © 2018 Naico ITS. All rights reserved.
//

import UIKit
import CoreData

class AddStudentViewController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        
        let stu = Student(context: PersistanceService.context)
        stu.firstname = txtFirstName.text
        stu.lastname = txtLastName.text
        
        PersistanceService.saveContext()
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
