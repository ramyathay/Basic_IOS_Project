//
//  Missions.swift
//  BucketList
//
//  Created by Ramyatha Yugendernath on 1/24/16.
//  Copyright © 2016 Ramyatha Yugendernath. All rights reserved.
//

import Foundation

class Missions: NSObject, NSCoding {
    static var key: String = "Missions"
    static var schema: String = "MissionList"
    var objective: String
    var createdAt: NSDate
    // use this init for creating a new Missions
    init(obj: String) {
        objective = obj
        createdAt = NSDate()
    }
    // MARK: - NSCoding protocol
    // used for encoding (saving) objects
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objective, forKey: "objective")
        aCoder.encodeObject(createdAt, forKey: "createdAt")
    }
    // used for decoding (loading) objects
    required init?(coder aDecoder: NSCoder) {
        objective = aDecoder.decodeObjectForKey("objective") as! String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        super.init()
    }
    // MARK: - Queries
    static func all() -> [Missions] {
        var Missionss = [Missions]()
        let path = Database.dataFilePath(Missions.schema)
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                Missionss = unarchiver.decodeObjectForKey(Missions.key) as! [Missions]
                unarchiver.finishDecoding()
            }
        }
        return Missionss
    }
    func save() {
        var MissionssFromStorage = Missions.all()
        var exists = false
        print("Value of self is \(self.objective) \(self.createdAt)")
        for var i = 0; i < MissionssFromStorage.count; ++i {
            if MissionssFromStorage[i].createdAt == self.createdAt {
                MissionssFromStorage[i] = self
                exists = true
            }
        }
        if !exists {
            MissionssFromStorage.append(self)
        }
        Database.save(MissionssFromStorage, toSchema: Missions.schema, forKey: Missions.key)
    }
    func destroy() {
        var missionsFromStorage = Missions.all()
        for var i = 0; i < missionsFromStorage.count; ++i {
            if missionsFromStorage[i].createdAt == self.createdAt {
                missionsFromStorage.removeAtIndex(i)
            }
        }
        Database.save(missionsFromStorage, toSchema: Missions.schema, forKey: Missions.key)
    }
}