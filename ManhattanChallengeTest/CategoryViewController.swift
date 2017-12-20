//
//  CategoryViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 13/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var categoryName: String!
    var trip: Trip!
    var total: Float = 0.0
    var expenses: [Expense] = []
    
    var selectedIndex = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.SetBannerImage()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(categoryName)
        
        //Get expenses of the category
        expenses = CoreDataController.shared.loadExpensesOfCategoryGivenTrip(trip: trip, category: categoryName)
        
        //Calculate total expenses of the category
        for expense in expenses {
            total += expense.price
        }
        
        totalPriceLabel.text = CoreDataController.shared.FloatToTwoDigitString(number: total)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let expenseInCell = expenses[indexPath.row]
        cell?.textLabel?.text = CoreDataController.shared.FloatToTwoDigitString(number: expenseInCell.price)
        cell?.detailTextLabel?.text = expenseInCell.note
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            CoreDataController.shared.currentTrip?.removeFromExpenses(expenses[indexPath.row])
            
            do {
                try CoreDataController.shared.context.save()
            } catch let error {
                print("[CDC] Error deleting expense: error \(error)")
            }
            
            total -= expenses[indexPath.row].price
            expenses.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            totalPriceLabel.setNeedsDisplay()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let nextViewController = segue.destination as? ExpenseDetailViewController {
            nextViewController.expenses = self.expenses
            nextViewController.selectedIndex = self.selectedIndex
            nextViewController.instanceOfCVC = self
        }
    }
    
    func SetBannerImage() {
        switch categoryName {
        case "Accomodation":
            bannerImage.image = #imageLiteral(resourceName: "accomodationBanner")
        case "Transport":
            bannerImage.image = #imageLiteral(resourceName: "transportBanner")
        case "Food":
            bannerImage.image = #imageLiteral(resourceName: "foodBanner")
        case "Entertainment":
            bannerImage.image = #imageLiteral(resourceName: "entertainmentBanner")
        case "Attractions":
            bannerImage.image = #imageLiteral(resourceName: "attractionsBanner")
        case "Other":
            bannerImage.image = #imageLiteral(resourceName: "otherBanner")
        default:
            break
        }
    }

}
