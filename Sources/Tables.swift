//
//  Tables.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

import TextTable

let eventTable = TextTable<Event> {[
    Column(title: "Timestamp", value: $0.timestamp),
    Column(title: "Event ID", value: $0.id),
    Column(title: "Stream ID", value: $0.streamId)
]}
