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
    
    
    @IBOutlet var cathegoryButtons: [UIButton]!
    
    var price: Float!
    var cathegory: String!
    var note: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        
        if insertPriceField.isEditing {
            price = Float(textField.text)
            insertPriceField.endEditing(true)
        }
        
        if optionalNoteField.isEditing {
            note = optionalNoteField.text
            optionalNoteField.endEditing(true)
        }
        
        
    }
    
}
