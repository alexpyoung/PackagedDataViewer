//
//  Model.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

import SQLite

protocol Model {

    var id: String { get }

    init(blob: SQLite.Blob) throws
}
