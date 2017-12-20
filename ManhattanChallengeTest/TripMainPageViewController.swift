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
    @IBOutlet weak var totalBudget: UILabel!
    
    @IBOutlet var categoryPriceLabels: [UILabel]!
    let categoryNames = ["Accomodation", "Transport", "Entertainment", "Attractions", "Food", "Other"]
    
    
    var categoryName: String?
    
    var allTrips: [Trip]!
    var isFirstTrip = false
    var leftPercentage: Float = 0.0
//  Total of the expense
    var total: Float = 0.0
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                
        allTrips = CoreDataController.shared.loadAllTheTrips()
        
        if allTrips!.isEmpty {
            performSegue(withIdentifier: "firstTripSegue", sender: self)
        }
        
        titleNavBar.title = CoreDataController.shared.currentTrip?.location ?? ""
        
        let expenses = CoreDataController.shared.loadExpensesOfATrip(trip: CoreDataController.shared.currentTrip!)
        
        
        //Compute total
        for expense in expenses {
            total += expense.price
        }
        
        // Change text of category Labels
        
        for category in categoryNames {
            for label in categoryPriceLabels {
                if label.restorationIdentifier == (category + "Price") {
                    label.text = calculateCategoryPriceAndConvertToString(category: category)
                }
            }
        }
        
        
//        print("Budget: \(CoreDataController.shared.currentTrip?.budget)")
        totalBudget.text = CoreDataController.shared.FloatToTwoDigitString(number: (CoreDataController.shared.currentTrip?.budget)!)
        print("Total: \(total)")
        totalExpenses.text = "$\(CoreDataController.shared.FloatToTwoDigitString(number: total)) spent"
        
        let left: Float = (CoreDataController.shared.currentTrip?.budget)! - total
        
        moneyLeft.text = "$\(CoreDataController.shared.FloatToTwoDigitString(number: left)) left"
        
        progressBar.leftPercentage = calculatePercentage()
        
        totalBudget.text = "$ \(CoreDataController.shared.FloatToTwoDigitString(number: (CoreDataController.shared.currentTrip?.budget)!))"
        
        if progressBar.leftPercentage < 0 {
            progressBar.leftPercentage = 0.0
        }
        
        progressBar.updateGradientLayer()

    }
    
    @IBOutlet weak var titleNavBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataController.shared.currentTrip = CoreDataController.shared.loadCurrentTrip()
        
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
    
    func calculateCategoryPriceAndConvertToString(category: String) -> String {
        
        var categoryTotal: Float = 0.0
        
        let categoryExpenses = CoreDataController.shared.loadExpensesOfCategoryGivenTrip(trip: CoreDataController.shared.currentTrip!, category: category)
        
        for expense in categoryExpenses {
            categoryTotal += expense.price
        }
        
        let returnString = "$" + String(format: "%.2f", categoryTotal)
        
        return returnString
    }
}
