import Commander
import Foundation
import SQLite
import TextTable


let group = Group()
group.addCommand("events", eventsCommand)
group.addCommand("streams", streamsCommand)
group.run()
