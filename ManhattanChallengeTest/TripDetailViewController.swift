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
    
    
    @IBOutlet weak var budgetTrip: UILabel!
    @IBOutlet weak var totalExpenseLabel: UILabel!
    @IBOutlet weak var budgetResult: UILabel!
    @IBOutlet weak var saveSpentLabel: UILabel!
    
    @IBOutlet weak var progressBarAccomodation: UIProgressView!
    @IBOutlet weak var progressBarTransport: UIProgressView!
    @IBOutlet var progressBarEntertainment: UIProgressView!
    @IBOutlet var progressBarAttractions: UIProgressView!
    @IBOutlet weak var progressBarFood: UIProgressView!
    @IBOutlet var progressBarOther: UIProgressView!
    
    @IBOutlet var progressBars: [UIProgressView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for bar in progressBars {
            bar.transform = bar.transform.scaledBy(x: 1, y: 4)
        }
        
        
        let expenses = CoreDataController.shared.loadExpensesOfATrip(trip: trip!)
        
        
//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
        
        //Compute total
        for expense in expenses {
            total += expense.price
        }
        
        //Set all the label
        budgetTrip.text = String(trip!.budget)
        totalExpenseLabel.text = String(total)
        
        let sub = trip!.budget - total
        if sub < 0 {
            saveSpentLabel.text = "You go over budget of:"
            budgetResult.text = String(-1*sub)
        } else {
            budgetResult.text = String(sub)
        }
        
        // Set the value of the progress bars
        progressBarAccomodation.setProgress(setProgressBars(category: "Accomodation"), animated: true)
        progressBarTransport.setProgress(setProgressBars(category: "Transport"), animated: true)
        progressBarEntertainment.setProgress(setProgressBars(category: "Entertainment"), animated: true)
        progressBarFood.setProgress(setProgressBars(category: "Food"), animated: true)
        progressBarOther.setProgress(setProgressBars(category: "Other"), animated: true)
        progressBarAttractions.setProgress(setProgressBars(category: "Attractions"), animated: true)
        
        //Change title of NavBar
        self.navigationItem.title = trip!.location
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        // Set the progress bar of the category passing the category name
    func setProgressBars(category: String) -> Float{
        let categoryExpenses = CoreDataController.shared.loadExpensesOfCategoryGivenTrip(trip: trip!, category: category)
        // Sum all the total expenses of the given category of the current trip
        var sumTotal:Float = 0
        for expense in categoryExpenses {
            sumTotal += expense.price
        }
        let result = sumTotal/total
        return result
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
