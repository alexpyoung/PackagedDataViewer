//
//  Array+Extension.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

extension Array where Iterator.Element == Event {

    func sortedByTimestamp(_ order: SortOrder) -> [Event] {
        return self.sorted {
            switch order {
                case .ascending:
                    return $0.timestamp < $1.timestamp
                case .descending:
                    return $0.timestamp > $1.timestamp
            }
        }
    }

    func batchedByStreamID() -> [String:[Event]] {
        var batchedEvents = [String:[Event]]()
        self.forEach {
            var events = batchedEvents[$0.streamId] ?? []
            events.append($0)
            batchedEvents[$0.streamId] = events
        }
        return batchedEvents
    }
}
