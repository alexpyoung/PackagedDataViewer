//
//  Tables.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

import TextTable

let eventTable = TextTable<Event> {[
    Column(title: "Seq #", value: $0.sequence),
    Column(title: "Timestamp", value: $0.timestamp),
    Column(title: "Event ID", value: $0.id),
    Column(title: "Stream ID", value: $0.streamId)
]}

let streamTable = TextTable<Stream> {[
    Column(title: "Stream ID", value: $0.id ?? ""),
    Column(title: "Game ID", value: $0.gameId ?? ""),
    Column(title: "Home Team ID", value: $0.homeId),
    Column(title: "Away Team ID", value: $0.awayId)
]}
