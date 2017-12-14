//
//  ExtensionViewController.swift
//  ManhattanChallengeTest
//
//  Created by Francesca Palese on 13/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//use self.hideKeyboardWhenTappedAround() in the viewDidLoad method to dismiss the keyboard of any textfield

