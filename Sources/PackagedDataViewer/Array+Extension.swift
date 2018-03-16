//
//  Array+Extension.swift
//  PackagedDataViewer
//
//  Created by Alex Young on 6/23/17.
//

extension Array where Iterator.Element: Model {

    func sortedByTimestamp(_ order: SortOrder) -> [Element] {
        switch order {
            case .ascending:
                return self.sorted{ $0.timestamp < $1.timestamp }
            case .descending:
                return self.sorted{ $0.timestamp > $1.timestamp }
        }
    }
}

extension Array where Iterator.Element == Event {

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
