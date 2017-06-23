import Commander
import Foundation
import SQLite
import TextTable

let cache = Table("cache")
let data = Expression<SQLite.Blob>("data")
let type = Expression<String>("_type")

let query = cache
    .select(data)
    .filter(type == "event")

command(
    Argument<String>("file", description: "Path to database file")
) { filePath in
    let db = try Connection(filePath)
    let events = try db.prepare(query).map{ try Event(blob: $0[data]) }
    eventTable.print()
}.run()
