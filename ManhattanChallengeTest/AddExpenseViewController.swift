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
    @IBOutlet var buttonsCategory: [UIButton]!
    @IBOutlet weak var addPhoto: UIImageView!
    
    @IBOutlet weak var navBar: UINavigationItem!
    
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
//        for button in buttonsCategory {
//            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//            button.layer.shadowOffset = CGSize(width: 0, height: 4)
//            button.layer.shadowOpacity = 1.0
//            button.layer.shadowRadius = 2.0
//            button.layer.masksToBounds = false
//        }
//        addPhoto.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        addPhoto.layer.shadowOffset = CGSize(width: 0, height: 4)
//        addPhoto.layer.shadowOpacity = 1.0
//        addPhoto.layer.shadowRadius = 2.0
//        addPhoto.layer.masksToBounds = false
        
        designTextField(textField: insertPriceField)
        designTextField(textField: optionalNoteField)
        //Pop up price keyboard as view appears
        
        insertPriceField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    
    func designTextField(textField: UITextField){
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        textField.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    //On tap, close keyboards and update var
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        savePriceInVar()
        saveNoteInVar()

    }
   
    @IBAction func tapImagePhoto(_ sender: UITapGestureRecognizer) {
        p.sourceType = .camera
        p.cameraCaptureMode = .photo
        p.delegate = self
        present(p, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        p.dismiss(animated: true, completion: nil)
        addPhoto.image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
        notePhotoFlag = true
    }
    
        func showAlertPrice(){
            let alertView = UIAlertController(title: "Price field required", message: "", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertView, animated: true, completion: nil)
        }
    func showAlertCathegory(){
        let alertView = UIAlertController(title: "Category required", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    func showAlert(){
        let alertView = UIAlertController(title: "Please insert a expense and a category", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    //Save new Expense and go back to Home when Done pressed
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        //Close keyboards and update var
        savePriceInVar()
        saveNoteInVar()
        
        //First check if at least a category, price and note or photo was inserted
        if !categoryFlag && !priceFlag {
            showAlert()
        }
        if !categoryFlag {
            showAlertCathegory()
            
        } else if !priceFlag {
            showAlertPrice()
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
        cathegory = sender.restorationIdentifier
        setShadowButton()
        removeShadowButton(button: sender)
        categoryFlag = true
    }
    
    func setShadowButton() {
        for button in buttonsCategory {
            UIButton.animate(withDuration: 0.2,
                             animations: {
                                button.transform = CGAffineTransform(scaleX: 1, y: 1)
                                button.layer.shadowOpacity = 1
            },
                             completion: nil)
            button.layer.borderWidth = 0
        }
    }
    
    func removeShadowButton(button: UIButton) {
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                            button.layer.shadowOpacity = 0
        },
                         completion: nil)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        button.layer.borderWidth = 0.4
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
    
    @IBAction func keyboardAppear(_ sender: UITextField) {
        }
    
    @IBAction func keyboardDismiss(_ sender: UITextField) {
        self.view.frame.origin.y += 216
    }
}
