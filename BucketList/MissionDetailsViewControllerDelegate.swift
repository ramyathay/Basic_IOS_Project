//
//  MissionDetailsViewControllerDelegate.swift
//  BucketList
//
//  Created by Ramyatha Yugendernath on 1/24/16.
//  Copyright © 2016 Ramyatha Yugendernath. All rights reserved.
//

import Foundation
protocol MissionDetailsViewControllerDelegate: class {
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishGivingDetailsMission mission: Missions)
}