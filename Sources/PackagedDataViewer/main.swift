import Commander
import Foundation
import SQLite
import TextTable

let group = Group()
group.addCommand("events", eventsCommand)
group.addCommand("games", gamesCommand)
group.addCommand("streams", streamsCommand)
group.addCommand("teams", teamsCommand)
group.run()
