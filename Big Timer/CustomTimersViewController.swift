//
//  CustomTimersViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/24/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

class CustomTimersViewController: UIViewController {
    
    let textField = UITextField()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Quick Big Timers"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.addSubview(textField)
    }
    
}