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
