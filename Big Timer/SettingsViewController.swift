//
//  SettingsViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/14/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    let colorSettingController = ColorSettingController()
    
    fileprivate var customTimers: [CustomTimer] {
        get {
           return CustomTimerManager().getTimers()
        }
    }
    
    fileprivate var forceTouchIsEnabled: Bool {
        return view.traitCollection.forceTouchCapability == .available;
    }
    
    init() {
        super.init(style: UITableViewStyle.grouped)
        self.title = "Settings"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    fileprivate override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SettingsViewController.doneTapped))
        self.navigationItem.rightBarButtonItem = doneButton
        tableView.tableHeaderView = Bundle.main.loadNibNamed("ColorSettingView", owner: colorSettingController, options: nil)?.first as! UIView?
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100)
        tableView.tableHeaderView?.autoresizingMask = .flexibleWidth
        colorSettingController.setColors()
        colorSettingController.setSelection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Target / Action
    
    func doneTapped () {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if forceTouchIsEnabled {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if forceTouchIsEnabled {
            if section == 0 {
                return customTimers.count
            } else {
                return AlertSound.options.count
            }
        } else {
            return AlertSound.options.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if forceTouchIsEnabled {
            if section == 0 {
                return "Custom Timers (Force Touch The App Icon To Start)"
            } else {
                return "Timer Sounds (These Play When Your Timer is Done)"
            }
        } else {
            return "Timer Sounds"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if (indexPath as NSIndexPath).section == 1 || !forceTouchIsEnabled {
            let alertSound = AlertSound.options[(indexPath as NSIndexPath).row]
            cell.textLabel?.text = alertSound.rawValue.capitalized
            
            if (alertSound == AlertSound.getPreference()) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else {
            cell.textLabel?.text = getCustomTimerTitle(customTimers, index: (indexPath as NSIndexPath).row)
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if (indexPath as NSIndexPath).section == 1 || !forceTouchIsEnabled {
            let alertSound = AlertSound.options[(indexPath as NSIndexPath).row]
            AudioController.instance.updateSound(alertSound)
            AudioController.instance.playSound()
            if (alertSound != AlertSound.getPreference()) {
                AlertSound.setPreference(alertSound)
                tableView.reloadData()
            }
        } else {
            let customTimerViewController = CustomTimerViewController()
            customTimerViewController.timerValue = getCustomTimerTime(timers: customTimers, index: (indexPath as NSIndexPath).row)
            customTimerViewController.timer = customTimers[(indexPath as NSIndexPath).row]
            navigationController?.pushViewController(customTimerViewController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func getCustomTimerTime(timers:Array<CustomTimer>, index: Int) -> Double {
        let timer: CustomTimer = timers[index]
        switch timer {
        case .first(let time):
            return Double(time)
        case .second(let time):
            return Double(time)
        case .third(let time):
            return Double(time)
        }
    }
    
    fileprivate func getCustomTimerTitle(_ timers:Array<CustomTimer>, index: Int) -> String {
        let timer: CustomTimer = timers[index]
        return timer.title()
    }
    
}
