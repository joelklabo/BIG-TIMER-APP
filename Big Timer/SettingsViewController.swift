//
//  SettingsViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/14/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    private var audioPlayer: AudioController?
    private let customTimers = CustomTimerManager().getTimers()
    
    private var forceTouchIsEnabled: Bool {
        return view.traitCollection.forceTouchCapability == .Available;
    }
    
    init() {
        super.init(style: UITableViewStyle.Grouped)
        self.title = "Settings"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(SettingsViewController.doneTapped))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: Target / Action
    
    func doneTapped () {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if forceTouchIsEnabled {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if indexPath.section == 1 || !forceTouchIsEnabled {
            let alertSound = AlertSound.options[indexPath.row]
            cell.textLabel?.text = alertSound.rawValue.capitalizedString
            
            if (alertSound == AlertSound.getPreference()) {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        } else {
            cell.textLabel?.text = getCustomTimerTitle(customTimers, index: indexPath.row)
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        if indexPath.section == 1 || !forceTouchIsEnabled {
            let alertSound = AlertSound.options[indexPath.row]
            audioPlayer = AudioController(alertSound: alertSound)
            audioPlayer!.playSound()
            
            if (alertSound != AlertSound.getPreference()) {
                AlertSound.setPreference(alertSound)
                tableView.reloadData()
            }
        } else {
            let customTimerViewController = CustomTimerViewController()
            customTimerViewController.timerInfo = getCustomTimerTime(customTimers, index: indexPath.row)
            navigationController?.pushViewController(customTimerViewController, animated: true)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    private func getCustomTimerTime(timers:Array<CustomTimer>, index: Int) -> Int {
        let timer: CustomTimer = timers[index]
        switch timer {
        case .First(let time):
            return time
        case .Second(let time):
            return time
        case .Third(let time):
            return time
        }
    }
    
    private func getCustomTimerTitle(timers:Array<CustomTimer>, index: Int) -> String {
        let timer: CustomTimer = timers[index]
        return timer.title()
    }
    
}
