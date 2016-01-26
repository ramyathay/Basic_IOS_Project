//
//  ViewController.swift
//  BucketList
//
//  Created by Ramyatha Yugendernath on 1/24/16.
//  Copyright © 2016 Ramyatha Yugendernath. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController,CancelButtonDelegate,MissionDetailsViewControllerDelegate {
    //var missions = ["Sky diving", "Live in Hawaii"]
    var missions:[Missions] = []
    var isEditMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        missions = Missions.all()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("MissionCell")!
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = missions[indexPath.row].objective
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missions.count
    }
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailsMission", sender: tableView.cellForRowAtIndexPath(indexPath))
        isEditMode = true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if !isEditMode {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        }
        else  {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            isEditMode = false
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.missionToEdit = missions[indexPath.row]
            }
        }    }
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishGivingDetailsMission mission: Missions) {
        dismissViewControllerAnimated(true, completion: nil)
        mission.save()
        missions = Missions.all()
        tableView.reloadData()
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        missions[indexPath.row].destroy()
        missions.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }

}

