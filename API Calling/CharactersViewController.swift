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
        self.title = "Rick & Morty Characters"
        let query = "https://rickandmortyapi.com/api/character/"
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
            let character = ["id": id, "name": name, "status": status, "species": species, "gender": gender]
            characters.append(character)
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
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let character = characters[indexPath.row]
        cell.textLabel?.text = character["name"]
        cell.detailTextLabel?.text = character["species"]
        return cell
    }
 
    @IBAction func onTappedDoneButton(_ sender: UIBarButtonItem) {
        exit(0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! DetailsViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.character = characters[index!]
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
    }
}

