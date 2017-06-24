//
//  Model.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

import SQLite

protocol Model {

    init(blob: SQLite.Blob) throws
}
