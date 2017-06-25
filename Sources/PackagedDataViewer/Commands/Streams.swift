//
//  StreamsCommand.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/24/17.
//
//

import Commander
import SQLite
import TextTable

let streamsCommand = command(
    Option<String>(
        "game-id",
        "nil",
        description: "Game ID to filter by"
    ),
    VariadicArgument<String>(
        "files",
        description: "Variadic list of paths to database files"
    ),
    execute
)

private func execute(
    gameIdOrNil: String,
    filePaths: [String]
) throws {
    try filePaths.forEach {
        print("Reading \($0)")
        let streams: [Stream] = try Connection($0).fetchAll()
        streamTable.print(streams, style: Style.psql)
    }
}
