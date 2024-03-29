//
//  DrinkTableViewController.swift
//  orderDrink
//
//  Created by Yolanda H. on 2019/9/5.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class DrinkTableViewController: UITableViewController {

    var orders:[List] = []
    var newList:[NewList] = []
    func download(url:String){
        orders = []
        newList = []
        let urlStr = url
        fecth(urlStr: urlStr) { (drinkData) in
            if let drinkData = drinkData, drinkData.count >= 1 {
                for i in 0...drinkData.count - 1 {
                    let date = drinkData[i].date
                    let name = drinkData[i].name
                    let medium = drinkData[i].mediumID
                    let drinks = drinkData[i].drink.components(separatedBy: ".")
                    let price = drinkData[i].price
                    let oneOrder = List(date: date, name: name, mediumID: medium, drink: drinks[0],sugar:drinks[1],ice: drinks[2], price:Int(price)!)
                    let list = NewList(drinkName: drinkData[i].drink, cupCount: 1)
                    self.orders.append(oneOrder)
                    self.newList.append(list)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                self.orders.reverse()
            }
        }
    }
    @objc func handleRefresh(refreshControl:UIRefreshControl){
        download(url: "https://sheetdb.io/api/v1/2bnkitnsc8xzd")
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        download(url: "https://sheetdb.io/api/v1/2bnkitnsc8xzd")
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count+1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if orders.count - indexPath.row != 0 {
            let mediumString = "https://medium.com/\(orders[indexPath.row].mediumID)"
            let orderDrink = orders[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! AllpersonTableViewCell
            DispatchQueue.main.async {
                cell.nameLabel.text = orderDrink.name
                cell.mediumIDLabel.text = orderDrink.mediumID
                cell.drinkLabel.text = orderDrink.drink
                cell.priceLabel.text = String(orderDrink.price)
                cell.sugarLabel.text = orderDrink.sugar
                cell.iceLabel.text = orderDrink.ice
                cell.timeLabel.text = orderDrink.date
                cell.mediumUrlTextView.text = mediumString
                cell.mediumUrlTextView.textColor = UIColor.white
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as! SumTableViewCell
            if orders.count != 0 {
                var total = 0
                for orders in orders {
                total += orders.price
                //print(total)
                }
                cell.sumLabel.isHidden = false
                cell.sumLabel.text = "總金額\(total)"
                cell.cupXLabel.text = "總杯數\(orders.count)杯"
                cell.sumButton.isHidden = false
            }else{
                cell.sumLabel.isHidden = true
                cell.cupXLabel.text = "目前沒有訂單"
                cell.sumButton.isHidden = true
            }
                return cell
            
        }
    }
    
        

    
    @IBSegueAction func sumSegue(_ coder: NSCoder) -> UITableViewController? {
        let controller = SumTableViewController(coder: coder)
        
        var list2:[NewList] = []
        list2.append(newList[0])
        
        for i in 1...newList.count-1 {
            var a = 0
            for j in 0...list2.count-1 {
                if newList[i].drinkName != list2[j].drinkName {
                    a += 1
                    if a == list2.count {
                        list2.append(newList[i])
                    }
                }else{
                    list2[j].cupCount += 1
                    a = 100
                }
            }
            
        }
        var b = 0
        for z in 0...list2.count-1 {
            b += list2[z].cupCount
        }
        list2.sort { (a, b) -> Bool in
            a.drinkName > b.drinkName
        }
        controller?.list2 = list2
        controller?.cupCount = b
        return controller
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
