//
//  SuperHerosTableViewController.swift
//  superheroesandlaureates
//
//  Created by Student on 4/13/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class SuperHerosTableViewController: UITableViewController {
    
    var superpowers : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        SuperHeros.shared.fetchSuperHero()
        NotificationCenter.default.addObserver(self, selector: #selector(herosRetrieved), name: Notification.Name("Heros Retrieved"), object: nil)
    }
    
    @objc func herosRetrieved(){
        DispatchQueue.main.sync {
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SuperHeros"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SuperHeros.shared.members.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superheroidentifier", for: indexPath)
        let heroesvalue = SuperHeros.shared[indexPath.row]
        superpowers = heroesvalue.powers
        var Datavalue:String = ""
        for value in 0..<superpowers.count{
            if value == superpowers.count-1{
                Datavalue = Datavalue + "\(superpowers[value])"
            }else{
                Datavalue = Datavalue + "\(superpowers[value]), "
            }
        }
        cell.textLabel?.text = "\(heroesvalue.name) (AKA: \(heroesvalue.secretIdentity))"
        cell.detailTextLabel?.text = Datavalue
        return cell
    }
    
}

