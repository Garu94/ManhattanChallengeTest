//
//  TripViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 12/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit



class AddExpenseViewController: UIViewController {
    @IBOutlet weak var insertPriceField: UITextField!
    
    @IBOutlet weak var optionalNoteField: UITextField!
        
    
    var newExpense = Expense(context: CoreDataController.shared.context)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newExpense.price = 0.0
        newExpense.cathegory = ""
        newExpense.note = ""
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        print("\(newExpense.price)\n\(newExpense.cathegory)\n\(newExpense.note!)")

        
        if insertPriceField.isEditing {
            newExpense.price = Float(insertPriceField.text!)!
            insertPriceField.endEditing(true)
        }
        
        if optionalNoteField.isEditing {
            newExpense.note = optionalNoteField.text
            optionalNoteField.endEditing(true)
        }
    }
    
    @IBAction func foodButtonPressed(_ sender: UIButton) {
        newExpense.cathegory = sender.titleLabel!.text
    }
    
    
}
