//
//  DrinkTypeTableViewController.swift
//  orderDrink
//
//  Created by Yolanda H. on 2019/10/4.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class DrinkTypeTableViewController: UITableViewController {
    var menu:[Menu] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://sheetdb.io/api/v1/7vd0ylfezf9zg"){
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let drinkData = try decoder.decode([Drink].self, from: data)
                        for i in 0...drinkData.count - 1 {
                            let brand = drinkData[i].brand
                            let drinkID = drinkData[i].drinkID
                            let drink = drinkData[i].drink
                            let detail = drinkData[i].detail
                            let priceInt:Int = Int(drinkData[i].price!)!
                            if brand == "可不可熟成紅茶" {
                                let drinkMenu = Menu(drinkName: drink, detail: detail!, drinkID: drinkID!)
                                self.menu.append(drinkMenu)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                    catch{
                        print(error)
                    }
                }
                print(self.menu.count)
                print(self.menu[self.menu.count-1].detail)
            }
            task.resume()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let drinkMenu = menu[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTableViewCell", for: indexPath) as! TypeTableViewCell
        
        cell.drinkImage.image = UIImage(named: drinkMenu.drinkID)
        cell.drinkLabel.text = "\(drinkMenu.drinkName)\n----------\n\(drinkMenu.detail)"

        return cell
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
