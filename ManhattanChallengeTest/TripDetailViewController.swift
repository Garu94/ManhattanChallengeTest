//
//  TripDetailViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 18/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class TripDetailViewController: UIViewController {
    
    var trip: Trip?
    var total: Float = 0.0
    
    
    @IBOutlet weak var totalExpenseLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let expenses = CoreDataController.shared.loadExpensesOfATrip(trip: trip!)
        
        for expense in expenses {
            total += expense.price
        }
        
        totalExpenseLabel.text = ("You spent: \(total)")
        
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
