//
//  Event.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

import Foundation
import SQLite

struct Event: Model {
    let id: String
    let streamId: String
    let timestamp: String

    init(blob: SQLite.Blob) throws {
        let data = Data(bytes: blob.bytes, count: blob.bytes.count)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:AnyHashable] else {
            throw PackagedDataViewerError.invalidJSONObject
        }
        guard let id = json["_id"] as? String,
            let streamId = json["stream_id"] as? String,
            let timestamp = json["timestamp"] as? String
        else {
            throw PackagedDataViewerError.invalidJSONProperty
        }
        self.id = id
        self.streamId = streamId
        self.timestamp = timestamp
    }
}