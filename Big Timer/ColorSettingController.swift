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
            return firstColor
        }
    }

    fileprivate let firstColor    = UIColor(colorLiteralRed: 243/255.0, green: 79/255.0, blue: 38/255.0, alpha: 1)
    fileprivate let thirdColor = UIColor(colorLiteralRed: 24/255.0, green: 144/255.0, blue: 240/255.0, alpha: 1)
    fileprivate let fourthColor   = UIColor(colorLiteralRed: 0, green: 66/255.0, blue: 133/255.0, alpha: 1)
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    @IBAction func firstButtonTapped(_ sender: AnyObject) {
        firstButton.isEnabled = true
        setSelectedLabelOnButton(firstButton)
        setDefaultColor(firstColor)
    }
    
    @IBAction func thirdButtonTapped(_ sender: AnyObject) {
        setSelectedLabelOnButton(thirdButton)
        setDefaultColor(thirdColor)
    }
    
    @IBAction func fourthButtonTapped(_ sender: AnyObject) {
        setSelectedLabelOnButton(fourthButton)
        setDefaultColor(fourthColor)
    }
    
    func setColors() {
        firstButton.backgroundColor = firstColor
        fourthButton.backgroundColor = fourthColor
        thirdButton.backgroundColor = thirdColor
    }
    
    func setSelection() {
        let color = selectedColor()
        switch color {
        case firstColor:
            setSelectedLabelOnButton(firstButton)
            break
        case thirdColor:
            setSelectedLabelOnButton(thirdButton)
            break
        case fourthColor:
            setSelectedLabelOnButton(fourthButton)
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
        firstButton.setTitle("", for: .normal)
        fourthButton.setTitle("", for: .normal)
        thirdButton.setTitle("", for: .normal)
    }
    
    fileprivate func setDefaultColor(_ color: UIColor) {
        let data = NSKeyedArchiver.archivedData(withRootObject: color)
        UserDefaults.standard.set(data, forKey: colorKey)
        NotificationCenter.default.post(name: colorChangeNotificationKey, object: nil)
    }
}
