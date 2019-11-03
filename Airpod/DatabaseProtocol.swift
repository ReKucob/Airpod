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
    case officer
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onOfficerChange(change: DatabaseChange, OfficerDatas: [officerData])
}

protocol DatabaseProtocol: AnyObject {
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
