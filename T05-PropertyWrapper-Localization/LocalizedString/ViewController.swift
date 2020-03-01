//
//  ViewController.swift
//  LocalizedString
//
//  Created by wiiale on 2020/3/1.
//  Copyright © 2020 wiiale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiLabel.text = .hi
    }
}

private extension String {
    // static let hi = NSLocalizedString("hi", comment: "")
    @LocalizedString("hi")
    static var hi: String
}
