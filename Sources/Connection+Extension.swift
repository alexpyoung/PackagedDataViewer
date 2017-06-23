//
//  Connection+Extension.swift
//  Spectre
//
//  Created by Alex Young on 6/23/17.
//

import SQLite

extension Connection {

    // FIXME: Implement some generics wizardry that can grab an identifier from Model
    func fetchAll<T: Model>(for typeIdentifier: String) throws -> [T] {
        let cache = Table("cache")
        let data = Expression<SQLite.Blob>("data")
        let type = Expression<String>("_type")

        let query = cache
            .select(data)
            .filter(type == typeIdentifier)
        return try self.prepare(query).map{ try T(blob: $0[data]) }
    }
}
