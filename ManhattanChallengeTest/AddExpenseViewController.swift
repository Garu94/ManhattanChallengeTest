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
    
    var price: Float?
    var cathegory: String?
    var note: String?
    var trip: Trip!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pop up price keyboard as view appears
        insertPriceField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    //On tap, close keyboards and update var
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        savePriceInVar()
        saveNoteInVar()
        
    }
   
    
    //Save new Expense and go back to Home when Done pressed
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        //Close keyboards and update var
        savePriceInVar()
        saveNoteInVar()
        
        //Save new Expense, given the Trip
        CoreDataController.shared.addExpenseToATrip(cathegory: cathegory, note: note, price: price, trip: CoreDataController.shared.loadTrip(location: trip.location!))
        
        //Animation Dismiss
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    //When cathegory button is pressed, hide the keyboards and save datas into var
    @IBAction func cathgeoryButtonPressed(_ sender: UIButton) {
        savePriceInVar()
        saveNoteInVar()
        cathegory = sender.titleLabel!.text
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //Clean the code, isolating savePrice and saveNote procedure
    func savePriceInVar() {
        if insertPriceField.isEditing {
            if let insertedPrice = insertPriceField.text {
                price = Float(insertedPrice)
            }
            insertPriceField.endEditing(true)
        }
    }
    
    func saveNoteInVar() {
        if optionalNoteField.isEditing {
            if let insertedNote = optionalNoteField.text {
                note = insertedNote
            }
            optionalNoteField.endEditing(true)
        }
    }
    
}
