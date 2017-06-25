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

let streamTable = TextTable<Stream> {[
    Column(title: "Stream ID", value: $0.id ?? ""),
    Column(title: "Game ID", value: $0.gameId ?? ""),
    Column(title: "Home Team ID", value: $0.homeId),
    Column(title: "Away Team ID", value: $0.awayId)
]}

func print(_ allEvents: [Event], sorted: SortOrder? = nil, shouldBatch: Bool = false) {
    let events: [Event]
    if let sortOrder = sorted {
        events = allEvents.sortedByTimestamp(sortOrder)
    } else {
        events = allEvents
    }

    if shouldBatch {
        events.batchedByStreamID().forEach { (_, events) in
            eventTable.print(events, style: Style.psql)
        }
    } else {
        eventTable.print(events, style: Style.psql)
    }
}
