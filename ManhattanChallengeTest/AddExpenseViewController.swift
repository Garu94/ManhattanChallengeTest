//
//  TripViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 12/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var insertPriceField: UITextField!
    @IBOutlet weak var addPhoto: UIImageView!
    
    @IBOutlet weak var warningText: UITextView!
    
    @IBOutlet weak var optionalNoteField: UITextField!
    
    var price: Float?
    var cathegory: String?
    var note: String?
    var trip: Trip!
    
    var categoryFlag = false
    var priceFlag = false
    var notePhotoFlag = false
    
    
    let p = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertPriceField.keyboardType = .decimalPad
        
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
        
        if warningText.alpha == 1 {
            warningText.alpha = 0
        }
    }
   
    @IBAction func tapImagePhoto(_ sender: UITapGestureRecognizer) {
        p.sourceType = .camera
        p.cameraCaptureMode = .photo
        p.delegate = self
        present(p, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        p.dismiss(animated: true, completion: nil)
        addPhoto.image = info[UIImagePickerControllerOriginalImage] as! UIImage
        notePhotoFlag = true
    }
    
    
    //Save new Expense and go back to Home when Done pressed
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        //Close keyboards and update var
        savePriceInVar()
        saveNoteInVar()
        
        //First check if at least a category, price and note or photo was inserted
        if !categoryFlag || !priceFlag || !notePhotoFlag{
            warningText.alpha = 1
        } else {
            //Save new Expense, given the Trip
            CoreDataController.shared.addExpenseToATrip(cathegory: cathegory, note: note, price: price, photo: addPhoto.image!, trip: trip)
            
            //Animation Dismiss
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    //When cathegory button is pressed, hide the keyboards and save datas into var
    @IBAction func cathgeoryButtonPressed(_ sender: UIButton) {
        savePriceInVar()
        saveNoteInVar()
        cathegory = sender.titleLabel!.text
        categoryFlag = true
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //Clean the code, isolating savePrice and saveNote procedure
    func savePriceInVar() {
        if insertPriceField.isEditing {
            if let insertedPrice = insertPriceField.text {
                var pointCounter = 0
                priceFlag = true
                var convertedPrice: String = ""
                
                //Convert "," to "." for foreigners number pads
                for char in insertedPrice {
                    if char != "," {
                        convertedPrice.append(char)
                    } else {
                        convertedPrice.append(".")
                    }
                }
                
                print(insertedPrice)
                print(convertedPrice)
                
                // Error if too many "." are inserted
                for char in convertedPrice {
                    if char == "." {
                        pointCounter += 1
                    }
                    if pointCounter > 1 {
                        priceFlag = false
                    }
                }
                
                //Error if Price Field is empty
                if convertedPrice == "" {
                    priceFlag = false
                }
                
                price = Float(convertedPrice)
                
                
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
        notePhotoFlag = true
    }
    
}
