//
//  DetailsViewController.swift
//  API Calling
//
//  Created by Patrick Dowell on 2/28/19.
//  Copyright © 2019 Patrick Dowell. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var detailsLabel: UILabel!
    
    var character = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsLabel.text = "Name: \(character["name"]!) \nStatus: \(character["status"]!) \nSpecies: \(character["species"]!) \nGender: \(character["gender"]!)"
        // Do any additional setup after loading the view.
    }
}
