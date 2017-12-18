//
//  FirstTripViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 18/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class FirstTripViewController: UIViewController {

    
    
    @IBOutlet weak var locationTextField: UITextField!
    var location: String?
    
    var priceFlag = false
    
    @IBOutlet weak var budgetTextField: UITextField!
    var price: Float?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actionOnDoneButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    
    @IBAction func doOnTap(_ sender: UITapGestureRecognizer) {
    }
    
    func saveAndCloseBudget() {
        if budgetTextField.isEditing {
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
                if convertedPrice == "" {
                    priceFlag = false
                }
                
                price = Float(convertedPrice)
                
                
            }
            budgetTextField.endEditing(true)
        }
    }
    
    func saveAndCloseLocation() {
        if locationTextField.isEditing {
            location = locationTextField.text
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
