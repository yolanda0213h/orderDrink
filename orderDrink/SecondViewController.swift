//
//  SecondViewController.swift
//  orderDrink
//
//  Created by Yolanda H. on 2019/8/27.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var imageName:String?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let imageName = imageName {
        imageView.image = UIImage(named: imageName)
        }
    }


}

