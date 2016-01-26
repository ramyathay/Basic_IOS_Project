//
//  MissionDetailsViewController.swift
//  BucketList
//
//  Created by Ramyatha Yugendernath on 1/24/16.
//  Copyright © 2016 Ramyatha Yugendernath. All rights reserved.
//

import Foundation
import UIKit

class MissionDetailsViewController: UITableViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newMissionTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        if let isEdit = missionToEdit {
            newMissionTextField.text = isEdit.objective
            dataEdit = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var missionToEdit: Missions?
    var dataEdit : Bool = false
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: MissionDetailsViewControllerDelegate?
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
         cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        if let mission = missionToEdit {
            mission.objective = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishGivingDetailsMission: mission)
        }
        else {
            let mission = Missions(obj: newMissionTextField.text!)
            delegate?.missionDetailsViewController(self, didFinishGivingDetailsMission: mission)
        }
        
    }
    
    @IBOutlet weak var newMissionTextField: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        newMissionTextField.resignFirstResponder()
        return true
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}