//
//  StreamsCommand.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/24/17.
//
//

import Commander

let streamsCommand = command(
    Argument<String>(
        "game-id",
        description: "Game ID to filter by"
    ),
    VariadicArgument<String>(
        "files",
        description: "Variadic list of paths to database files"
    ),
    execute
)

private func execute(
    gameId: String,
    filePaths: [String]
) throws {

}
