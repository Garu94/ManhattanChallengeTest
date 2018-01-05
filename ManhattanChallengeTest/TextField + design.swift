//
//  TextField + design.swift
//  ManhattanChallengeTest
//
//  Created by Francesca Palese on 04/01/2018.
//  Copyright © 2018 Simone Garuglieri. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func design() {
        self.layer.cornerRadius = 12.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        self.layer.masksToBounds = true
    }
}
