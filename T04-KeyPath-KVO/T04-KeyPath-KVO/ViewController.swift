//
//  ViewController.swift
//  T04-KeyPath-KVO
//
//  Created by lili on 2018/4/29.
//  Copyright © 2018年 fun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var user = User(name: "Gua Li")
    
    /// Just Display current user props
    @IBOutlet weak var displayLabel: UILabel!
    
    var observation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observation = user.observe(\User.name, writeTo: displayLabel, \UILabel.text!)
        
        getUserName { [weak self] in self?.user.name = $0 }
    }
    
    deinit {
        observation?.invalidate()
    }
    
    func getUserName(completionHandler: ((String) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler?("Peter Parker")
        }
    }
}

