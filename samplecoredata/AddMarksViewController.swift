//
//  AddMarksViewController.swift
//  samplecoredata
//
//  Created by Vineeth Vijayan on 6/27/18.
//  Copyright © 2018 Naico ITS. All rights reserved.
//

import UIKit
import CoreData

class AddMarksViewController: UIViewController {
    
    var student: Student?
    
    @IBOutlet weak var pickerSubject: UIPickerView!
    @IBOutlet weak var txtMarks: UITextField!
    
    fileprivate var subjects = [Subject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerSubject.delegate = self
        
        let request: NSFetchRequest<Subject> = Subject.fetchRequest()
        do {
            subjects = try PersistanceService.context.fetch(request)
        } catch {
            print("Fetch Failed")
        }
        
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        let subMark = MarkList(context: PersistanceService.context)
        
        subMark.marks = Int32(txtMarks.text!)!
        subMark.marksubject = subjects[pickerSubject.selectedRow(inComponent: 0)]
        subMark.stu = student
        
        PersistanceService.saveContext()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension AddMarksViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row].subjectname
    }
    
    
}
