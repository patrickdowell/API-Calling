//
//  ViewController.swift
//  API Calling
//
//  Created by Patrick Dowell on 2/22/19.
//  Copyright © 2019 Patrick Dowell. All rights reserved.
//

import UIKit

class CharactersViewController: UITableViewController {

    var characters = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = "https://rickandmortyapi.com/api/character/"
        // Do any additional setup after loading the view, typically from a nib.
    }


}

