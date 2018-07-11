//
//  ViewController.swift
//  T02-Iterator-Bidirectional
//
//  Created by lili on 2017/12/29.
//  Copyright © 2017年 fun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numbers = [0, 1, 2, 3]
    var _numIterator: BidirectionalIterator<[Int]>?
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._numIterator = numbers.makeBidirectionalIterator()
    }

    @IBAction func didTapPrevious(_ sender: Any) {
        let previous = _numIterator?.previous()
        displayLabel.text = previous == nil ? "nil" : "\(previous!)"
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        let next = _numIterator?.next()
        displayLabel.text = next == nil ? "nil" : "\(next!)"
    }
}

