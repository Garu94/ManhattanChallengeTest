//
//  ExpenseDetailViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 15/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//


import UIKit


class ExpenseDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    var instanceOfCVC: CategoryViewController!
    
    var expenses: [Expense]!
    var selectedIndex: Int!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var noteField: UITextField! {
        didSet {
            noteField.autocorrectionType = .no
            if #available(iOS 11, *) {
                // Disables the password autoFill accessory view.
                noteField.textContentType = UITextContentType("")
            }
        }
    }
    
    @IBOutlet weak var priceField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var buttonsCategory: [DesignableButton]!
    
    
    var price: Float?
    var cathegory: String?
    var note: String?
    var trip: Trip!
    
    var categoryFlag = true
    var priceFlag = true
    var photoFlag = false
    
    
    let p = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
            return
        }
        
        statusBar.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        
//        if expenses[selectedIndex].image != nil {
//            scrollView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
//        } else {
//            scrollView.bottomAnchor.constraint(equalTo: noteField.bottomAnchor, constant: 100).isActive = true
//        }
        
//        scrollView.contentSize = CGSize(width: 375, height: 1000)
        
//        priceField.text = String(expenses[selectedIndex].price)
        
        priceField.text = CoreDataController.shared.FloatToTwoDigitString(number: expenses[selectedIndex].price)
        price = expenses[selectedIndex].price

        
        noteField.text = expenses[selectedIndex].note
        cathegory = expenses[selectedIndex].cathegory
        price = expenses[selectedIndex].price
        note = expenses[selectedIndex].note
        
        if let myImageData = expenses[selectedIndex].image {
            imageView.image = UIImage(data: myImageData)
            imageView.transform = imageView.transform.rotated(by: .pi/2)
        }
        
        setShadowButton()
        removeShadowButton(category: expenses[selectedIndex].cathegory!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        imageView.image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
        photoFlag = true
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
        } else if photoFlag {
            
            CoreDataController.shared.editExpense(date: expenses[selectedIndex].date!, cathegory: cathegory, note: note, price: priceField.text?.floatValue, photo: imageView.image!)
        } else {
           
            CoreDataController.shared.editExpense(date: expenses[selectedIndex].date!, cathegory: cathegory, note: note, price: priceField.text?.floatValue, photo: nil)
        }
            
//            do {
//                try CoreDataController.shared.context.save()
//            } catch let error {
//                print("[CDC] Error saving modified trip: error \(error)")
//            }
            
            //Animation Dismiss
            navigationController?.popViewController(animated: true)
            instanceOfCVC.tableView.reloadData()
            dismiss(animated: true, completion: nil)
        
    }
    
    
    //When cathegory button is pressed, hide the keyboards and save datas into var
    @IBAction func cathgeoryButtonPressed(_ sender: UIButton) {
        savePriceInVar()
        saveNoteInVar()
        cathegory = sender.restorationIdentifier
        setShadowButton()
        removeShadowButton(category: cathegory!)
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
    
    func removeShadowButton(category: String) {
        var button = UIButton()
        switch category {
        case "Accomodation":
            button = buttonsCategory[0]
        case "Transport":
            button = buttonsCategory[1]
        case "Food":
            button = buttonsCategory[4]
        case "Entertainment":
            button = buttonsCategory[2]
        case "Attractions":
            button = buttonsCategory[3]
        case "Other":
            button = buttonsCategory[5]
        default:
            break
        }
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

    
    //Clean the code, isolating savePrice and saveNote procedure
    func savePriceInVar() {
        if priceField.isEditing {
            
            if let insertedPrice = priceField.text {
                priceFlag = true
                price = insertedPrice.floatValue
                
                if price == 0.0 {
                    priceFlag = false
                }
            }
//
//            if let insertedPrice = priceField.text {
//                var pointCounter = 0
//                priceFlag = true
//                var convertedPrice: String = ""
//
//                //Convert "," to "." for foreigners number pads
//                for char in insertedPrice {
//                    if char != "," {
//                        convertedPrice.append(char)
//                    } else {
//                        convertedPrice.append(".")
//                    }
//                }
//
//                print(insertedPrice)
//                print(convertedPrice)
//
//                // Error if too many "." are inserted
//                for char in convertedPrice {
//                    if char == "." {
//                        pointCounter += 1
//                    }
//                    if pointCounter > 1 {
//                        priceFlag = false
//                    }
//                }
//
//                //Error if Price Field is empty
//                if convertedPrice == "" {
//                    priceFlag = false
//                }
//
//                price = Float(convertedPrice)
//
//
//            }
            priceField.endEditing(true)
        }
    }
    
    func saveNoteInVar() {
        if noteField.isEditing {
            if let insertedNote = noteField.text {
                note = insertedNote
            }
            noteField.endEditing(true)
        }
    }
    
    @IBAction func keyboardAppear(_ sender: UITextField) {
        self.view.frame.origin.y -= 70
    }

    @IBAction func keyboardDismiss(_ sender: UITextField) {
        self.view.frame.origin.y += 70
    }

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



