import Commander
import Foundation
import SQLite
import TextTable


// FIXME: Type safety!!!
command(
    Option<String>("type", "event", description: "[event] - Domain model type to query"),
    Option<String>("s", "nil", description: "[asc, desc] - Timestamp sort order"),
    Option<String>("b", "false", description: "[true, false] - Batch events by stream ID"),
    Option<String>("sid", "nil", description: "Stream ID"),
    Argument<String>("file", description: "Path to database file")
) { modelType, sortOrderOrNil, isBatchingByStream, streamIdOrNil, filePath in
    let events: [Event]
    // FIXME: Type safety!!!
    if streamIdOrNil != "nil" {
        let streamId = streamIdOrNil
        events = try Connection(filePath).fetchEvents(withStreamId: streamId)
        print(events, sorted: .ascending, shouldBatch: true)
    } else {
        events = try Connection(filePath).fetchAll(for: modelType)
        print(events, sorted: SortOrder(rawValue: sortOrderOrNil), shouldBatch: isBatchingByStream == "true")
    }
}.run()
