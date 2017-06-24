//
//  File.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/24/17.
//

import Foundation
import SQLite

struct Stream: Model {

    let id: String
    let gameId: String

    init(blob: SQLite.Blob) throws {
        let data = Data(bytes: blob.bytes, count: blob.bytes.count)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:AnyHashable] else {
            throw PackagedDataViewerError.invalidJSONObject
        }
        guard let id = json["_id"] as? String,
            let gameId = json["game_id"] as? String
        else {
            throw PackagedDataViewerError.invalidJSONProperty
        }
        self.id = id
        self.gameId = gameId
    }
}
