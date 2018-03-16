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
    Column(title: "Event Id", value: $0.id),
    Column(title: "Stream Id", value: $0.streamId)
]}

let streamTable = TextTable<Stream> {[
    Column(title: "Stream Id", value: $0.id),
    Column(title: "Timestamp", value: $0.timestamp),
    Column(title: "Game Id", value: $0.gameId),
    Column(title: "Home Team Id", value: $0.homeId),
    Column(title: "Away Team Id", value: $0.awayId)
]}

let teamTable = TextTable<Team> {[
    Column(title: "Team Id", value: $0.id),
    Column(title: "Timestamp", value: $0.timestamp),
    Column(title: "Name", value: $0.name),
    Column(title: "Status", value: $0.status),
]}

let gameTable = TextTable<Game> {[
    Column(title: "Game Id", value: $0.id),
    Column(title: "Start time", value: $0.timestamp),
    Column(title: "Stream Id", value: $0.streamId),
    Column(title: "Status", value: $0.status),
]}
