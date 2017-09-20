//
//  Model.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

import Foundation
import SQLite

protocol Model {

    static var typeIdentifier: String { get }
    static var dateFormatter: DateFormatter { get }

    init(blob: SQLite.Blob) throws
}

extension Model {

    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }
}
