//
//  ExpenseDetailViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 15/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class ExpenseDetailViewController: UIViewController {

    var expenses: [Expense]!
    var selectedIndex = 0
    
    @IBOutlet var noteField: UIView!
    @IBOutlet weak var priceField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
