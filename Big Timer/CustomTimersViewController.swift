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
    
    let storage: Storage
    let textField: UITextField
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        storage = NSUserDefaults.standardUserDefaults()
        textField = UITextField()
        super.init(nibName: "CustomTimerView", bundle: NSBundle.mainBundle())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}