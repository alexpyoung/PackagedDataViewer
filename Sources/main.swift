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
    VariadicArgument<String>("files", description: "Variadic list of paths to database files")
) { modelType, sortOrderOrNil, isBatchingByStream, streamIdOrNil, filePaths in
    try filePaths.forEach{
        print("Reading \($0)")
        let events: [Event]
        // FIXME: Type safety!!!
        if streamIdOrNil != "nil" {
            let streamId = streamIdOrNil
            events = try Connection($0).fetchEvents(withStreamId: streamId)
            print(events, sorted: .ascending, shouldBatch: true)
        } else {
            events = try Connection($0).fetchAll(for: modelType)
            print(events, sorted: SortOrder(rawValue: sortOrderOrNil), shouldBatch: isBatchingByStream == "true")
        }
    }
}.run()
