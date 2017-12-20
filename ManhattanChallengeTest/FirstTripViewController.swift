//
//  FirstTripViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 18/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class FirstTripViewController: UIViewController {

    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var locationTextField: UITextField!
    var location: String?
    
    var priceFlag = false
    var locationFlag = false
    
    @IBOutlet weak var budgetTextField: UITextField!
    var budget: Float?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func designTextField(textField: UITextField){
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        textField.layer.masksToBounds = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designTextField(textField: locationTextField)
        designTextField(textField: budgetTextField)
        startButton.layer.cornerRadius = 5
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1).cgColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func start(_ sender: UIButton) {
        saveAndCloseBudget()
        saveAndCloseLocation()
        
        if !locationFlag && !priceFlag {
            showAlert()
        }
        if !locationFlag {
            showAlertLocation()
            
        } else if !priceFlag {
            showAlertBudget()
        } else {
            
            //Save first trip
            CoreDataController.shared.addTrip(location: location!, budget: budget!)
            
            //Dismiss
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func doOnTap(_ sender: UITapGestureRecognizer) {
        saveAndCloseBudget()
        saveAndCloseLocation()
        
    }
    
    func saveAndCloseBudget() {
        if budgetTextField.isEditing {
            budgetTextField.endEditing(true)
        }
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
        }
        
    }
    
    func saveAndCloseLocation() {
        if locationTextField.isEditing {
            locationTextField.endEditing(true)
        }
        
        if let insertedLocation = locationTextField.text {
            location = insertedLocation
            locationFlag = true
        }
        
        if location?.trimmingCharacters(in: .whitespaces) == "" {
            locationFlag = false
        }
        
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
    
    @IBOutlet weak var firstTripLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
