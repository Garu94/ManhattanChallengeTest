//
//  TripViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 13/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class TripMainPageViewController: UIViewController {

    @IBOutlet weak var progressBar: GradientProgressBar!
    @IBOutlet weak var moneyLeft: UILabel!
    @IBOutlet weak var totalExpenses: UILabel!
    
    var categoryName: String?
    
    var allTrips: [Trip]!
    var isFirstTrip = false
    var leftPercentage: Float = 0.0
//  Total of the expense
    var total: Float = 0.0
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                
        allTrips = CoreDataController.shared.loadAllTheTrips()
        
        print(allTrips!.isEmpty)
        
        if allTrips!.isEmpty {
            performSegue(withIdentifier: "firstTripSegue", sender: self)
        }
        
        titleNavBar.title = CoreDataController.shared.currentTrip?.location ?? ""
        
        progressBar.leftPercentage = calculatePercentage()
        
        if progressBar.leftPercentage < 0 {
            progressBar.leftPercentage = 0.0
        }
        
        progressBar.updateGradientLayer()
        
//        progressBar.animate(duration: 10)
        
    }
    
    @IBOutlet weak var titleNavBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataController.shared.currentTrip = CoreDataController.shared.loadCurrentTrip()
        
        let expenses = CoreDataController.shared.loadExpensesOfATrip(trip: CoreDataController.shared.currentTrip!)
        
        //Compute total
        for expense in expenses {
            total += expense.price
        }
        
        print("Budget: \(CoreDataController.shared.currentTrip?.budget)")
        print("Total: \(total)")
        var formatFloat = String(format: "%.2f", total)
        totalExpenses.text = "$\(formatFloat) spent"
        
        var left: Float = (CoreDataController.shared.currentTrip?.budget)! - total
        formatFloat = String(format: "%.2f", left)
        
        moneyLeft.text = "$\(formatFloat) left"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func clickOnCategoryButton(_ sender: UIButton) {
        
        categoryName = sender.restorationIdentifier!
        
        
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
    
    func calculatePercentage() -> Float {
        
        
        guard let trip = CoreDataController.shared.currentTrip else {
            return 0.0
        }
        
        let leftPercentage: Float = getCurrentBudget()/trip.budget
        
        print(leftPercentage)
        
        return leftPercentage
        
    }
}
