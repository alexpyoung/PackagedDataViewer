//
//  File.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/24/17.
//

import Foundation
import SQLite

struct Stream: Model {

    static let typeIdentifier = "stream"

    let id: String?
    let gameId: String?
    let homeId: String
    let awayId: String
    let timestamp: Date

    init(blob: SQLite.Blob) throws {
        let data = Data(bytes: blob.bytes, count: blob.bytes.count)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:AnyHashable] else {
            throw PackagedDataViewerError.invalidJSONObject
        }
        guard let homeId = json["home_id"] as? String,
            let awayId = json["away_id"] as? String,
            let timestamp = json["timestamp"] as? String,
            let date = Stream.dateFormatter.date(from: timestamp)
        else {
            throw PackagedDataViewerError.invalidJSONProperty
        }
        self.id = json["_id"] as? String
        self.gameId = json["game_id"] as? String
        self.homeId = homeId
        self.awayId = awayId
        self.timestamp = date
    }
}
