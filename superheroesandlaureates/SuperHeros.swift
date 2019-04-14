//
//  SuperHeros.swift
//  superheroesandlaureates
//
//  Created by Student on 4/13/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
class SuperHeros{
    
    static let shared = SuperHeros()
    var members:[Members] = []
    //Function fetchSuperhero
    func fetchSuperHero() -> Void {
        guard let url = Bundle.main.url(forResource: "squad", withExtension: "json")
            else{
                print("No File is  Found")
                return
        }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url, completionHandler: superHeroDetails).resume()
    }
    

    //Function superHeroDetails
    func superHeroDetails(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        do {
            let decoder = JSONDecoder()
            let superhero = try decoder.decode(SuperHero.self, from: data!)
            members = superhero.members
            NotificationCenter.default.post(name: Notification.Name("Heros Retrieved"), object: nil)
        }
            
        catch {
            print(error)
        }
    }
    //Function heros
    func heros(index:Int) -> Members{
        return members[index]
    }
    //Function subscript
    subscript(index:Int) -> Members{
        return members[index]
    }
    //Function numoflas
    func numofLas() -> Int{
        return members.count
    }
}

class SuperHero: Codable {
    var members:[Members]
}

class Members: Codable{
    var name:String
    var secretIdentity:String
    var powers:[String]
}
