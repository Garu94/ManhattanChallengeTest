//
//  TripDetailViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 18/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class TripDetailViewController: UIViewController {
    
    //Trip passed from previous View
    var trip: Trip?
    
    //Total computed in this view
    var total: Float = 0.0
    
    
    @IBOutlet weak var totalExpenseLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let expenses = CoreDataController.shared.loadExpensesOfATrip(trip: trip!)
        
        
//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
        
        //Compute total
        for expense in expenses {
            total += expense.price
        }
        
        //Show total
        totalExpenseLabel.text = ("You spent: \(total)")
        
        //Change title of NavBar
        navigationController?.title = trip?.location
        
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
