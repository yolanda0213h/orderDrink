//
//  FirstViewController.swift
//  orderDrink
//
//  Created by Yolanda H. on 2019/8/27.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var orderIceButton: UIButton!
    @IBOutlet weak var orderSugarButton: UIButton!
    @IBOutlet weak var orderDrinkButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mediumTextField: UITextField!
    let sugarStyle = ["多糖","正常糖","少糖","半糖","微糖","二分糖","一分糖","無糖"]
    let iceStyle = ["多冰","正常冰","少冰","微冰","去冰","完全去冰"]
    var orders:[Order] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://sheetdb.io/api/v1/7vd0ylfezf9zg"){
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let drinkData = try decoder.decode([Drink].self, from: data)
                        print(drinkData.count)
                        for i in 0...drinkData.count - 1 {
                            let brand = drinkData[i].brand
                            let drink = drinkData[i].drink
                            let size = drinkData[i].size
                            let priceInt:Int = Int(drinkData[i].price!)!
                            if brand == "可不可熟成紅茶" {
                                let drinkName = "\(drink)\(size!)"+"杯"
                                let oneOrder = Order(orderDrink: "\(drinkName)$\(priceInt)", orderPrice: priceInt)
                                self.orders.append(oneOrder)
                                //print(drinkName)
                            }
                        }
                    }
                    catch{
                        print(error)
                    }
                }
                print(self.orders.count)
            }
            task.resume()
        }
    }
    @IBAction func drinkButton(_ sender: UIButton) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for drink in orders {
            let action = UIAlertAction(title: drink.orderDrink, style: .default) { (_) in
            sender.setTitleColor(UIColor.black, for: .normal)
                sender.setTitle(drink.orderDrink, for: .normal)
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
            


    }
    @IBAction func sugarButton(_ sender: UIButton) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for sugar in sugarStyle {
            let action = UIAlertAction(title: sugar, style: .default) { (_) in
                sender.setTitle(sugar, for: .normal)
                sender.setTitleColor(UIColor.black, for: .normal)
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    @IBAction func iceButton(_ sender: UIButton) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for ice in iceStyle {
            let action = UIAlertAction(title: ice, style: .default) { (_) in
                sender.setTitle(ice, for: .normal)
                sender.setTitleColor(UIColor.black, for: .normal)
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    @IBAction func mediumDidEndOnExit(_ sender: Any) {
    }
    @IBAction func nameDidEndOnExit(_ sender: Any) {
    }
    @IBAction func sentButton(_ sender: UIButton) {
        if nameTextField.text?.isEmpty == false, mediumTextField.textColor == UIColor.black, orderIceButton.titleColor(for: .normal) == UIColor.black, orderSugarButton.titleColor(for: .normal) == UIColor.black, orderIceButton.titleColor(for: .normal) == UIColor.black{
            keepData()
            
            tabBarController?.selectedIndex = 1
            /*
            let urlStr = "https://sheetdb.io/api/v1/2bnkitnsc8xzd"
            fecth(urlStr: urlStr) { (drinkData) in
                print(drinkData?.count)
                if let drinkData = drinkData {
                if drinkData.count >= 1 {
                    
                    DispatchQueue.main.async {
                        
                        controller?.tableView.reloadData()
                    }
                }
                    
                }
            }
            */
        }else if nameTextField.text?.isEmpty == true {
            let controller = UIAlertController(title: "請填入名字稱呼", message: nil, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(controller, animated: true, completion: nil)
            return
        }
        
    }
    func keepData(){
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateData = formatter.string(from: time)
        print(dateData)
        //now date
        let nameData = nameTextField.text!
        let mediumData = mediumTextField.text!
        //orderDrink & price
        let order = orderDrinkButton.title(for: .normal)!.components(separatedBy: "$")
        let priceData:Int = Int(order[1])!
        let orderData = "\(order[0]).\(orderSugarButton.title(for: .normal)!).\(orderIceButton.title(for: .normal)!)"
        print(priceData)
        
        let newData = UploadData(date: dateData, name: nameData, mediumID: mediumData, drink: orderData, price: priceData)
        post(orderData: newData)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        segue.destination.preferredContentSize = CGSize(width: 320, height: 240)
        segue.destination.popoverPresentationController?.delegate = self
        
        

    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
       return .none
    }

    

}

