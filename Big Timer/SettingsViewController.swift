//
//  SettingsViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/14/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlertSound.options.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Timer Sounds"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let alertSound = AlertSound.options[indexPath.row]
        cell.textLabel?.text = alertSound.rawValue.capitalized
        
        if (alertSound == AlertSound.selectedPreference) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertSound = AlertSound.options[indexPath.row]
        AudioController.instance.updateSound(sound: alertSound)
        AudioController.instance.playSound()

        if (alertSound != AlertSound.selectedPreference) {
            AlertSound.setPreference(alertSound: alertSound)
            tableView.reloadData()
        }
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
