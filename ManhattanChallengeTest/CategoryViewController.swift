//
//  CategoryViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 13/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    var categoryName: String!
    var trip: Trip!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = categoryName
        
        let expenses = CoreDataController.shared.loadExpensesOfCategoryGivenTrip(trip: trip, category: categoryName)
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
