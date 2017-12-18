//
//  ExpenseDetailViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 15/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class ExpenseDetailViewController: UIViewController {

    var expenses: [Expense]!
    var selectedIndex: Int!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 375, height: 2300)
        
        priceField.text = String(expenses[selectedIndex].price)
        noteField.text = expenses[selectedIndex].note
        
        if let myImageData = expenses[selectedIndex].image {
            imageView.image = UIImage(data: myImageData, scale: 1.0)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
