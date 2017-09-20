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
    let sequence: UInt
    let timestamp: Date

    init(blob: SQLite.Blob) throws {
        let data = Data(bytes: blob.bytes, count: blob.bytes.count)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:AnyHashable] else {
            throw PackagedDataViewerError.invalidJSONObject
        }
        guard let id = json["_id"] as? String,
            let streamId = json["stream_id"] as? String,
            let sequence = json["seq"] as? UInt,
            let timestamp = json["timestamp"] as? String,
            let date = Event.dateFormatter.date(from: timestamp)
        else {
            throw PackagedDataViewerError.invalidJSONProperty
        }
        self.id = id
        self.streamId = streamId
        self.sequence = sequence
        self.timestamp = date
    }
}
