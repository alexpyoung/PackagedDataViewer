//
//  Event.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

import Foundation
import SQLite

struct Event: Model {

    static let typeIdentifier = "event"

    let id: String
    let streamId: String
    let sequence: Int
    let timestamp: Date

    init(blob: SQLite.Blob) throws {
        let data = Data(bytes: blob.bytes, count: blob.bytes.count)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:AnyHashable] else {
            throw PackagedDataViewerError.invalidJSONObject
        }
        guard let timestamp = json["timestamp"] as? String,
              let date = Event.dateFormatter.date(from: timestamp)
        else {
            throw PackagedDataViewerError.invalidJSONProperty
        }
        self.id = json["_id"] as? String ?? ""
        self.streamId = json["stream_id"] as? String ?? ""
        self.sequence = json["seq"] as? Int ?? -1
        self.timestamp = date
    }
}
