//
//  File.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/24/17.
//

import Foundation
import SQLite

struct Stream: Model {

    let id: String?
    let gameId: String?

    init(blob: SQLite.Blob) throws {
        let data = Data(bytes: blob.bytes, count: blob.bytes.count)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:AnyHashable] else {
            throw PackagedDataViewerError.invalidJSONObject
        }
        self.id = json["_id"] as? String
        self.gameId = json["game_id"] as? String
    }
}
