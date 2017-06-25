//
//  Commands.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/24/17.
//
//

import Commander
import SQLite
import TextTable

enum SortOrder: String {
    case ascending = "asc"
    case descending = "desc"
}

let eventsCommand = command(
    Option<String>(
        "sort",
        "nil",
        description: "[asc, desc] - Timestamp sort order"
    ),
    Flag(
        "batch",
        description: "[true, false] - Batch events by stream ID",
        default: false
    ),
    Option<String>(
        "stream-id",
        "nil",
        description: "Stream ID to filter by"
    ),
    VariadicArgument<String>(
        "files",
        description: "Variadic list of paths to database files"
    ),
    execute
)

private func execute(
    sortOrderOrNil: String,
    isBatchingByStream: Bool,
    streamIdOrNil: String,
    filePaths: [String]
) throws {
    try filePaths.forEach {
        print("Reading \($0)")
        let events: [Event]
        if streamIdOrNil != "nil" {
            let streamId = streamIdOrNil
            events = try Connection($0).fetchEvents(withStreamId: streamId)
            print(events, sorted: .ascending, shouldBatch: true)
        } else {
            events = try Connection($0).fetchAll()
            print(events, sorted: SortOrder(rawValue: sortOrderOrNil), shouldBatch: isBatchingByStream)
        }
    }
}

private func print(_ allEvents: [Event], sorted: SortOrder? = nil, shouldBatch: Bool = false) {
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
