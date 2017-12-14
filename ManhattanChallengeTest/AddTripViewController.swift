//
//  AddTripViewController.swift
//  ManhattanChallengeTest
//
//  Created by Francesca Palese on 13/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit


class AddTripViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBAction func saveNewTrip(_ sender: UIBarButtonItem) {
        if let loc = locationTextField.text {
        location = loc
        }
        if let budgetString = budgetTextField.text {
            budget = Float(budgetString)
        }
        
        if location != nil && budget != nil {
            CoreDataController.shared.addTrip(location: location!, budget: budget!)
        }
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet weak var locationTextField: UITextField!{
        didSet {
                locationTextField.delegate = self
        }
    }
    
    @IBOutlet weak var budgetTextField: UITextField!{
        didSet {
            budgetTextField.delegate = self
        }
    }
    
    var location: String?
    var budget: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

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
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
