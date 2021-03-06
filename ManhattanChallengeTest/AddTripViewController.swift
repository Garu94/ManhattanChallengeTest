//
//  AddTripViewController.swift
//  ManhattanChallengeTest
//
//  Created by Francesca Palese on 13/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit


class AddTripViewController: UIViewController, UITextFieldDelegate {
    
    var isDonePressed = false
    
    @IBOutlet weak var locationTextField: UITextField!{
        didSet {
            locationTextField.delegate = self
            locationTextField.autocorrectionType = .no
            if #available(iOS 11, *) {
                // Disables the password autoFill accessory view.
                locationTextField.textContentType = UITextContentType("")
            }
        }
    }
    
    @IBOutlet weak var budgetTextField: UITextField!{
        didSet {
            budgetTextField.delegate = self
        }
    }
    
    var location: String?
    var budget: Float?
    
    var priceFlag = false
    var locationFlag = false
    
    
    @IBAction func saveNewTrip(_ sender: UIBarButtonItem) {
        
        saveAndCloseBudget()
        saveAndCloseLocation()
        
        if !locationFlag && !priceFlag {
            showAlert()
        }
        if !locationFlag {
            showAlertLocation()
            
        } else if !priceFlag {
            showAlertBudget()
        } else if !isAlreadyPresent(location: location!) {
            alertDoubleLocation()
        } else {
            
            //Save first trip
            CoreDataController.shared.addTrip(location: location!, budget: budget!)
            
            navigationController?.popToRootViewController(animated: true)    
        }
    }
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        designTextField(textField: locationTextField)
        designTextField(textField: budgetTextField)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func saveAndCloseLocation() {
        if let insertedLocation = locationTextField.text {
            location = insertedLocation
            locationFlag = true
        }
        
        if location?.trimmingCharacters(in: .whitespaces) == "" {
            locationFlag = false
            
        }
    }
    
    func isAlreadyPresent(location: String) -> Bool {
        let trips = CoreDataController.shared.loadAllTheTrips()
        
        for trip in trips {
            if trip.location == location {
                return false
            }
        }
        
        return true
    }
    
    
    
    
    func saveAndCloseBudget() {
        
            if let insertedPrice = budgetTextField.text {
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
                if convertedPrice.trimmingCharacters(in: .whitespaces) == "" {
                    priceFlag = false
                }
                
                budget = Float(convertedPrice)
                
                if budget == Float(0) {
                    priceFlag = false
                }
                
            }
    }
    
    func alertDoubleLocation() {
        let alertView = UIAlertController(title: "You already have a location with this name, please modify this one", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    func showAlertLocation(){
        let alertView = UIAlertController(title: "Location field required", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    func showAlertBudget(){
        let alertView = UIAlertController(title: "Budget field required", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    func showAlert(){
        let alertView = UIAlertController(title: "Please insert a location and a budget", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    func designTextField(textField: UITextField){
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        textField.layer.masksToBounds = true
        
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
