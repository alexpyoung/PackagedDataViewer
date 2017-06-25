//
//  Connection+Extension.swift
//  Spectre
//
//  Created by Alex Young on 6/23/17.
//

import SQLite

extension Connection {

    func fetchAll<T: Model>() throws -> [T] {
        let cache = Table("cache")
        let data = Expression<SQLite.Blob>("data")
        let type = Expression<String>("_type")

        let query = cache
            .select(data)
            .filter(type == T.typeIdentifier)
        return try self.prepare(query).map{ try T(blob: $0[data]) }
    }

    func fetchEvents(withStreamId streamId: String) throws -> [Event] {
        return try self.fetchAll().filter{ $0.streamId == streamId }
    }
}
