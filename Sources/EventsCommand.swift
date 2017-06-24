//
//  Commands.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/24/17.
//
//

import Commander
import SQLite

let eventsCommand = command(
    Option<String>(
        "s",
        "nil",
        description: "[asc, desc] - Timestamp sort order"
    ),
    Flag(
        "b",
        description: "[true, false] - Batch events by stream ID",
        default: false
    ),
    Option<String>(
        "sid",
        "nil",
        description: "Stream ID"
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
    try filePaths.forEach{
        print("Reading \($0)")
        let events: [Event]
        if streamIdOrNil != "nil" {
            let streamId = streamIdOrNil
            events = try Connection($0).fetchEvents(withStreamId: streamId)
            print(events, sorted: .ascending, shouldBatch: true)
        } else {
            events = try Connection($0).fetchAll(for: "event")
            print(events, sorted: SortOrder(rawValue: sortOrderOrNil), shouldBatch: isBatchingByStream)
        }
    }
}
