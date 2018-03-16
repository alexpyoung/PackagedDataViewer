
import Commander
import SQLite
import TextTable

private enum SortKey: String {
    case timestamp
}

let gamesCommand = command(
    Option<String>(
        "sort-order",
        "nil",
        description: "Options: [asc, desc]; use with sort-key"
    ),
    Option<String>(
        "sort-key",
        "timestamp",
        description: "Options: [timestamp, name]; use with sort-order"
    ),
    VariadicArgument<String>(
        "files",
        description: "Variadic list of paths to database files"
    ),
    execute
)

private func execute(
    orderOrNil: String,
    keyOrNil: String,
    filePaths: [String]
) throws {
    try filePaths.forEach {
        print("Reading \($0)")
        let sort: (SortKey, SortOrder)?
        if let key = SortKey(rawValue: keyOrNil),
           let order = SortOrder(rawValue: orderOrNil) {
            sort = (key, order)
        } else {
            sort = nil
        }
        print(try Connection($0).fetchAll(), sort: sort)
    }
}

private func print(_ games: [Game], sort: (SortKey, SortOrder)?) {
    if let (key, order) = sort {
        switch key {
        case .timestamp:
            gameTable.print(games.sortedByTimestamp(order), style: Style.psql)
        }
    } else {
        gameTable.print(games, style: Style.psql)
    }
}
