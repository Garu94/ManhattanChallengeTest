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
    
    
    override func viewWillAppear(_ animated: Bool) {
        CoreDataController.shared.addTrip(location: "Rome", budget: 450.0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = CoreDataController.shared.loadTrip(location: "Rome").location
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func clickOnCategoryButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToCategoryView", sender: self)
        
        categoryName = sender.titleLabel?.text
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
