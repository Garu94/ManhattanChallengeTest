//
//  TripViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 13/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class TripMainPageViewController: UIViewController {

    var categoryName: String?
    
    
    @IBOutlet weak var budgeLeftLabel: UILabel!
    
    var currentTrip = CoreDataController.shared.loadCurrentTrip()
    var currentExpenses = CoreDataController.shared.loadExpensesOfCurrentTrip()
    
    
    func getCurrentBudget() -> Float {
        var sum: Float = 0.0
        if currentTrip.expenses?.count != 0 {
            for expense in currentExpenses {
                sum += expense.price
                print("sum is: \(sum)")
            }
        }
        print(sum)
        print(currentTrip.budget - sum)
        return currentTrip.budget - sum
    }
//    var currentBudget: Float {
//        get {
//            print("current budget is: \(currentTrip.budget)")
//            var sum: Float = 0.0
//            if currentTrip.expenses?.count != 0 {
//                for expense in currentExpenses {
//                    sum += expense.price
//                    print("sum is: \(sum)")
//                }
//            }
//            print(sum)
//            print(currentTrip.budget - sum)
//            return currentTrip.budget - sum
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        currentTrip = CoreDataController.shared.loadCurrentTrip()
        currentExpenses = CoreDataController.shared.loadExpensesOfCurrentTrip()
        budgeLeftLabel.text = String(getCurrentBudget())
        titleNavBar.title = currentTrip.location

        print("view will appear")
    }
    
    @IBOutlet weak var titleNavBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        CoreDataController.shared.addTrip(location: "Rome", budget: 450.0)
//        self.title = CoreDataController.shared.loadTrip(location: "Rome").location
        budgeLeftLabel.text = String(getCurrentBudget())
        titleNavBar.title = currentTrip.location
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func clickOnCategoryButton(_ sender: UIButton) {
        categoryName = sender.titleLabel!.text
        
        self.performSegue(withIdentifier: "segueToCategoryView", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tripName = titleNavBar.title
        
        if let nextViewController = segue.destination as? CategoryViewController {
            if let name = self.categoryName {
                nextViewController.categoryName = name
                nextViewController.trip = CoreDataController.shared.loadTrip(location: tripName!)
            }
        }
        
        if let nextViewController = segue.destination as? AddExpenseViewController {
            nextViewController.trip = CoreDataController.shared.loadTrip(location: tripName!)
        }
    }
}
