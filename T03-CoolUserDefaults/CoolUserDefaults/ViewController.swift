//
//  ViewController.swift
//  T03-CoolUserDefaults
//
//  Created by lili on 2018/1/20.
//  Copyright © 2018年 fun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var changeDataField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataLabel.text = CoolUserDefaults.data.value ?? "nil"
    }
    
    @IBAction func updateData(_ sender: Any) {
        CoolUserDefaults.data.value = changeDataField.text
        dataLabel.text = changeDataField.text
    }
}

