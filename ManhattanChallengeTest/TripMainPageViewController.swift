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
    
    var allTrips: [Trip]!
    var isFirstTrip = false
    
    @IBOutlet weak var budgeLeftLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        budgeLeftLabel.text = String(getCurrentBudget())
        titleNavBar.title = CoreDataController.shared.currentTrip?.location ?? ""

        print("view will appear")
    }
    
    @IBOutlet weak var titleNavBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allTrips = CoreDataController.shared.loadAllTheTrips()
        
        print(allTrips.isEmpty)
        
        if !allTrips.isEmpty {print(CoreDataController.shared.currentTrip)}
        
        if allTrips!.isEmpty {
            performSegue(withIdentifier: "firstTripSegue", sender: self)
        }
        
        
        budgeLeftLabel.text = String(getCurrentBudget())
        titleNavBar.title = CoreDataController.shared.currentTrip?.location ?? ""
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
    
    func getCurrentBudget() -> Float {
        var sum: Float = 0.0
        
        guard let currentTrip = CoreDataController.shared.currentTrip else {
            return sum
        }
        
        if CoreDataController.shared.loadExpensesOfATrip(trip: currentTrip).count != 0 {
            for expense in CoreDataController.shared.loadExpensesOfATrip(trip: CoreDataController.shared.currentTrip!) {
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
}
