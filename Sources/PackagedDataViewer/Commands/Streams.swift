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
        if gameIdOrNil != "nil" {
            streamTable.print(
                try Connection($0).fetchStreams(withGameId: gameIdOrNil),
                style: Style.psql
            )
        } else {
            streamTable.print(
                try Connection($0).fetchAll(),
                style: Style.psql
            )
        }
    }
}
