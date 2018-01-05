//
//  Alert.swift
//  ManhattanChallengeTest
//
//  Created by Francesca Palese on 04/01/2018.
//  Copyright © 2018 Simone Garuglieri. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alertLocation() {
        let alertView = UIAlertController(title: "Location field required", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    func alertBudget(){
        let alertView = UIAlertController(title: "Budget field required", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    func alertAllDataMissing(){
        let alertView = UIAlertController(title: "Please insert a location and a budget", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}
