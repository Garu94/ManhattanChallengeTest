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
    
    var allTrips: [Trip]?
    var isFirstTrip = false
    var currentTrip: Trip?
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        CoreDataController.shared.addTrip(location: "Rome", budget: 450.0)
//        self.title = CoreDataController.shared.loadTrip(location: "Rome").location
        
        allTrips = CoreDataController.shared.loadAllTheTrips()
        
        if !allTrips!.isEmpty {
            self.performSegue(withIdentifier: "firstTripSegue", sender: self)
        }
        
        currentTrip = CoreDataController.shared.currentTrip
        
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
        let tripName = navigationController?.title
        
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
