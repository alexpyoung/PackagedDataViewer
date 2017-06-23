import Commander
import Foundation
import SQLite
import TextTable


command(
    Argument<String>("file", description: "Path to database file"),
    Option<String>("type", "event", description: "[event] - Domain model type to query"),
    Option<String>("s", "nil", description: "[asc, desc] - Timestamp sort order"),
    Option<String>("b", "false", description: "[true, false] - Batch events by stream ID")
) { filePath, modelType, sortOrderOrNil, isBatchingByStream in

    let events: [Event] = try Connection(filePath).fetchAll(for: modelType)
    print(events, sorted: SortOrder(rawValue: sortOrderOrNil), shouldBatch: isBatchingByStream == "true")
}.run()
