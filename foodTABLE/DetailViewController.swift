//
//  DetailViewController.swift
//  foodTABLE
//
//  Created by sun on 27/4/2562 BE.
//  Copyright © 2562 sun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var DetailLabel: UILabel!
    
    var detail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailLabel?.text = detail

        // Do any additional setup after loading the view.
    }
    

   

}
