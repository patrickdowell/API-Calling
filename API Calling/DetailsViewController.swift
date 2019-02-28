//
//  ViewController.swift
//  API Calling
//
//  Created by Patrick Dowell on 2/27/19.
//  Copyright © 2019 Patrick Dowell. All rights reserved.
//

import UIKit

class DetailsViewController: UITableViewController {
    
    var details = [[String: String]]()
    var character = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Character Details"
        let query = "https://rickandmortyapi.com/api/character/" + "\(character["id"]!)"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    
    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let id = result["id"].stringValue
            let name = result["name"].stringValue
            let status = result["status"].stringValue
            let species = result["species"].stringValue
            let gender = result["gender"].stringValue
            let detail = ["id": id, "name": name, "status": status, "species": species, "gender": gender]
            details.append(character)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the news feed.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let character = details[indexPath.row]
        cell.textLabel?.text = character["name"]
        cell.detailTextLabel?.text = character["species"]
        return cell
    }
    
}

