//
//  SettingsViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/14/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var audioPlayer: AudioController?
    
    init() {
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init(coder aDecoder: NSCoder!) {
        fatalError("NSCoding not supported")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneTapped"))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: Target / Action
    
    func doneTapped () {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Table View Data Source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlertSound.options.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Alert Sounds"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let alertSound = AlertSound.options[indexPath.row]
        var cell = UITableViewCell()
        cell.textLabel?.text = alertSound.rawValue.capitalizedString
        
        if (alertSound == AlertSound.getPreference()) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        let alertSound = AlertSound.options[indexPath.row]
        audioPlayer = AudioController(alertSound: alertSound)
        audioPlayer!.playSound()
        
        if (alertSound != AlertSound.getPreference()) {
            AlertSound.setPreference(alertSound)
            tableView.reloadData()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
