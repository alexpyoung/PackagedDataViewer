
import Commander
import SQLite
import TextTable

private enum SortKey: String {
    case name
    case timestamp
}

let teamsCommand = command(
    Option<String>(
        "sort-order",
        "nil",
        description: "Options: [asc, desc]; use with sort-key"
    ),
    Option<String>(
        "sort-key",
        "nil",
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

private func print(_ teams: [Team], sort: (SortKey, SortOrder)?) {
    if let (key, order) = sort {
        switch key {
            case .name:
                teamTable.print(teams.sortedByName(order), style: Style.psql)
            case .timestamp:
                teamTable.print(teams.sortedByTimestamp(order), style: Style.psql)
        }
    } else {
        teamTable.print(teams, style: Style.psql)
    }
}
