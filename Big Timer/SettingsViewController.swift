//
//  SettingsViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/14/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    private var customTimers: [CustomTimer] {
        get {
           return CustomTimerManager().getTimers()
        }
    }
    
    private var forceTouchIsEnabled: Bool {
        return view.traitCollection.forceTouchCapability == .available;
    }
    
    init() {
        super.init(style: UITableView.Style.grouped)
        self.title = "Settings"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(SettingsViewController.doneTapped))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Target / Action
    
    @objc func doneTapped () {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
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
        
        if indexPath.section == 1 || !forceTouchIsEnabled {
            let alertSound = AlertSound.options[indexPath.row]
            cell.textLabel?.text = alertSound.rawValue.capitalized
            
            if (alertSound == AlertSound.selectedPreference) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else {
            cell.textLabel?.text = getCustomTimerTitle(timers: customTimers, index: indexPath.row)
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 || !forceTouchIsEnabled {
            let alertSound = AlertSound.options[indexPath.row]
            AudioController.instance.updateSound(sound: alertSound)
            AudioController.instance.playSound()
            if (alertSound != AlertSound.selectedPreference) {
                AlertSound.setPreference(alertSound: alertSound)
                tableView.reloadData()
            }
        } else {
            let customTimerViewController = CustomTimerViewController()
            customTimerViewController.timerValue.update(getCustomTimerTime(timers: customTimers, index: indexPath.row))
            customTimerViewController.timer = customTimers[indexPath.row]
            navigationController?.pushViewController(customTimerViewController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    private func getCustomTimerTime(timers:Array<CustomTimer>, index: Int) -> Double {
        let timer: CustomTimer = timers[index]
        switch timer {
        case .First(let time):
            return Double(time)
        case .Second(let time):
            return Double(time)
        case .Third(let time):
            return Double(time)
        }
    }
    
    private func getCustomTimerTitle(timers:Array<CustomTimer>, index: Int) -> String {
        let timer: CustomTimer = timers[index]
        return timer.title()
    }
    
}
