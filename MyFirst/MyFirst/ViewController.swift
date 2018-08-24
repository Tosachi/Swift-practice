//
//  ViewController.swift
//  MyFirst
//
//  Created by 西上　知里 on 2018/08/12.
//  Copyright © 2018年 tsc-343. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        outputLabel.text = "Hello, Swift!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var outputLabel: UILabel!
    
}

