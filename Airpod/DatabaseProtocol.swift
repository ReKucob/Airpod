//
//  DatabaseProtocol.swift
//  Airpod
//
//  Created by Burns on 3/11/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import Foundation

enum DatabaseChange{
    case add
    case remove
    case update
}

enum ListenerType{
    case all
    case officer1
    case officer2
    case warehouse1
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onOfficer1Change(change: DatabaseChange, OfficerDatas: [officerData])
    func onOfficer2Change(change: DatabaseChange, OfficerDatas: [officerData])
    func onwarehouse1Change(change: DatabaseChange, OfficerDatas: [officerData])
}

protocol DatabaseProtocol: AnyObject {
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
