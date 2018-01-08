//
//  LoginViewController.swift
//  ManhattanChallengeTest
//
//  Created by Francesca Palese on 04/01/2018.
//  Copyright © 2018 Simone Garuglieri. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var locationTextField: UITextField!
    var location: String?
    
    @IBOutlet weak var budgetTextField: UITextField!
    
    var priceFlag = false
    var locationFlag = false
    var budget: Float?
    
    @IBOutlet weak var startButton: DesignableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.design()
        budgetTextField.design()
        startButton.layer.cornerRadius = 5
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1).cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////    @IBAction func start(_ sender: UIButton) {
    ////        saveAndCloseBudget()
    ////        saveAndCloseLocation()
    ////
    ////        if !locationFlag && !priceFlag {
    ////            showAlert()
    ////        }
    ////        if !locationFlag {
    ////            showAlertLocation()
    ////
    ////        } else if !priceFlag {
    ////            showAlertBudget()
    ////        } else {
    ////
    ////            //Save first trip
    ////            CoreDataController.shared.addTrip(location: location!, budget: budget!)
    ////
    ////            //Dismiss
    ////            navigationController?.popViewController(animated: true)
    ////            dismiss(animated: true, completion: nil)
    ////        }
    //    }

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

    
    @IBAction func save(_ sender: UIButton) {
        saveAndCloseBudget()
        saveAndCloseLocation()
        
        if !locationFlag && !priceFlag {
            self.alertAllDataMissing()
        }
        if !locationFlag {
            self.alertLocation()
            
        } else if !priceFlag {
            self.alertBudget()
        } else {
            
            //Save first trip
            CoreDataController.shared.addTrip(location: location!, budget: budget!)
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
            let appDelegateTemp = UIApplication.shared.delegate as? AppDelegate
            appDelegateTemp?.window?.rootViewController = UIStoryboard(name: "Trip", bundle: Bundle.main).instantiateInitialViewController()
        }
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
