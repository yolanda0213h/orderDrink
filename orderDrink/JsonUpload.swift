//
//  JsonUpload.swift
//  orderDrink
//
//  Created by Yolanda H. on 2019/9/9.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import Foundation

struct UploadData: Codable {
    var date:String
    var name:String
    var mediumID:String
    var drink:String
    var price:Int
}

struct Data:Encodable {
    var data:UploadData
}

func post(orderData:UploadData){
    let url = URL(string: "https://sheetdb.io/api/v1/2bnkitnsc8xzd")
    var urlRequest = URLRequest(url: url!)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let order = Data(data: orderData)
    let jsonEncoder = JSONEncoder()
    if let encoderData = try? jsonEncoder.encode(order){
        
        let task = URLSession.shared.uploadTask(with: urlRequest, from: encoderData) { (retData, res, err) in
            let decoder = JSONDecoder()
            if let retData = retData, let dic = try? decoder.decode([String:Int].self, from: retData), dic["created"] == 1 {
                print("ok")
            }else{
                print("error")
                
            }
        }
        task.resume()
    }
}

