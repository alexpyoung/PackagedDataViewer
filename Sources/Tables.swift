//
//  Tables.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

import TextTable

enum SortOrder: String {
    case ascending = "asc"
    case descending = "desc"
}

let eventTable = TextTable<Event> {[
    Column(title: "Seq #", value: $0.sequence),
    Column(title: "Timestamp", value: $0.timestamp),
    Column(title: "Event ID", value: $0.id),
    Column(title: "Stream ID", value: $0.streamId)
]}
