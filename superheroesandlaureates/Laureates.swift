//
//  Laureates.swift
//  superheroesandlaureates
//
//  Created by Student on 4/13/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
class Laureates{
    
    struct LaureatesModel {
        var firstName:String
        var surName:String
        var bornDate:String
        var diedDate:String
    }
    
    private init(){}
    
    static let shared = Laureates()
    static var finalLaureatesDetails:[LaureatesModel] = []
    //Function fetch
    func fetchLaureates() -> Void {
        guard let url = Bundle.main.url(forResource: "laureates", withExtension: "json")
            else{
                print("No File is found")
                return
        }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url, completionHandler: displaylaureates).resume()
    }
    
    //Function displaylaureates
    func displaylaureates(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        var laureates:[[String:Any]]!
        do {
            try laureates = JSONSerialization.jsonObject(with: data!, options: .allowFragments)  as?  [[String:Any]]
            if laureates != nil {
                for values in 0..<laureates.count{
                    let laureatesArrayList = laureates[values]
                    let firstName = laureatesArrayList["firstname"] as? String
                    let surName = laureatesArrayList["surname"] as? String
                    let bornDate = (laureatesArrayList["born"] as? String)!
                    let diedDate = (laureatesArrayList["died"] as? String)!
                    Laureates.finalLaureatesDetails.append(LaureatesModel.init(firstName: firstName ?? "", surName: surName ?? "", bornDate: bornDate, diedDate: diedDate))
                }
                NotificationCenter.default.post(name: Notification.Name("Laureates Retrieved"), object: nil)
            }
            
        } catch {
            print(error)
        }
    }
    //Function laureats
    func laureats(index:Int) -> LaureatesModel{
        return Laureates.finalLaureatesDetails[index]
    }
    //Function subscript
    subscript(index:Int) -> LaureatesModel{
        return Laureates.finalLaureatesDetails[index]
    }
    //Function numofLas
    func numofLas() -> Int{
        return Laureates.finalLaureatesDetails.count
    }
}
