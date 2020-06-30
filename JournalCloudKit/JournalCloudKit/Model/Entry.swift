//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Kristin Samuels  on 6/29/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import Foundation
import CloudKit

struct EntryConstants{
    static let TitleKey = "title"
    static let BodyKey = "body"
    static let TimestampKey = "timestamp"
    static  let recordTypeKey = "Entry"
}

class Entry {
    var title: String
    var body: String
    var timestamp: Date
    let ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.recordTypeKey, recordID: entry.ckRecordID)
        
        self.setValuesForKeys([
            EntryConstants.TitleKey: entry.title,
            EntryConstants.BodyKey: entry.body,
            EntryConstants.TimestampKey: entry.timestamp
        ])
    }
}

extension Entry {
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.TitleKey] as? String,
            let body = ckRecord[EntryConstants.BodyKey] as? String,
            let timestamp = ckRecord[EntryConstants.TimestampKey] as? Date
            else {return nil}
        
        self.init(title: title,body: body, timestamp: timestamp, ckRecordID:ckRecord.recordID)
    }
}


extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp && lhs.ckRecordID == rhs.ckRecordID
    }
}
