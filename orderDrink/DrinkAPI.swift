//
//  DrinkAPI.swift
//  orderDrink
//
//  Created by Yolanda H. on 2019/9/5.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import Foundation

struct Drink: Codable {
    var brand: String
    var drink: String
    var size: String?
    var price: String?
    var drinkID: String?
}

struct Order: Codable {
    var orderDrink: String
    var orderPrice: Int
}
//
struct List: Codable {
    var date:String
    var name:String
    var mediumID:String
    var drink:String
    var sugar:String
    var ice:String
    var price:Int
}
struct DownLoad: Codable {
    var date:String
    var name:String
    var mediumID:String
    var drink:String
    var price:String
}

func fecth (urlStr:String, complation:@escaping ([DownLoad]?) -> Void) {
    if let url = URL(string: urlStr){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data, let drinkData = try? decoder.decode([DownLoad].self, from: data){
                complation(drinkData)
            }else {
                complation(nil)
            }
        }
        task.resume()
    }else{
        complation(nil)
    }
}

struct NewList:Codable {
    var drinkName:String
    var cupCount:Int
}
