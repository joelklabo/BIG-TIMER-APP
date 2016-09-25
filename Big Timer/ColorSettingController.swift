//
//  ColorSettingController.swift
//  Big Timer
//
//  Created by Joel Klabo on 9/24/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

protocol ColorChangeDelegate {
    func colorChangeDidOccur()
}

class ColorSettingController: NSObject {
    
    public let colorChangeNotificationKey = Notification.Name("colorChangeNotificationKey")
    
    fileprivate let colorKey = "appThemeColor"
    
    func selectedColor() -> UIColor {
        if let userSelectedColorData = UserDefaults.standard.object(forKey: colorKey) as? Data,
            let userSelectedColor = NSKeyedUnarchiver.unarchiveObject(with: userSelectedColorData) as? UIColor {
            return userSelectedColor
        } else {
            return redColor
        }
    }

    fileprivate let redColor    = UIColor(colorLiteralRed: 243/255.0, green: 79/255.0, blue: 38/255.0, alpha: 1)
    fileprivate let greenColor  = UIColor(colorLiteralRed: 2/255.0, green: 237/255.0, blue: 94/255.0, alpha: 1)
    fileprivate let yellowColor = UIColor(colorLiteralRed: 237/255.0, green: 236/255.0, blue: 0, alpha: 1)
    fileprivate let blueColor   = UIColor(colorLiteralRed: 22/255.0, green: 96/255.0, blue: 237/255.0, alpha: 1)
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    
    @IBAction func redTapped(_ sender: AnyObject) {
        redButton.isEnabled = true
        setSelectedLabelOnButton(redButton)
        setDefaultColor(redColor)
    }
    
    @IBAction func greenTapped(_ sender: AnyObject) {
        setSelectedLabelOnButton(greenButton)
        setDefaultColor(greenColor)
    }
    
    @IBAction func yellowTapped(_ sender: AnyObject) {
        setSelectedLabelOnButton(yellowButton)
        setDefaultColor(yellowColor)
    }
    
    @IBAction func blueTapped(_ sender: AnyObject) {
        setSelectedLabelOnButton(blueButton)
        setDefaultColor(blueColor)
    }
    
    func setSelection() {
        let color = selectedColor()
        switch color {
        case redColor:
            setSelectedLabelOnButton(redButton)
            break
        case greenColor:
            setSelectedLabelOnButton(greenButton)
            break
        case yellowColor:
            setSelectedLabelOnButton(yellowButton)
            break
        case blueColor:
            setSelectedLabelOnButton(blueButton)
            break
        default:
            fatalError("unsupported color")
        }
    }
    
    fileprivate func setSelectedLabelOnButton(_ button: UIButton) {
        clearSelectedState()
        button.setTitle("👍", for: .normal)
    }
    
    fileprivate func clearSelectedState() {
        redButton.setTitle("", for: .normal)
        greenButton.setTitle("", for: .normal)
        blueButton.setTitle("", for: .normal)
        yellowButton.setTitle("", for: .normal)
    }
    
    fileprivate func setDefaultColor(_ color: UIColor) {
        let data = NSKeyedArchiver.archivedData(withRootObject: color)
        UserDefaults.standard.set(data, forKey: colorKey)
        NotificationCenter.default.post(name: colorChangeNotificationKey, object: nil)
    }
}
