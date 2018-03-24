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
        return self.reduce([:]) { (result, event) -> [String:[Event]] in
            var result = result
            var events = result[event.streamId] ?? []
            events.append(event)
            result[event.streamId] = events
            return result
        }
    }
}

extension Array where Iterator.Element == Team {

    func sortedByName(_ order: SortOrder) -> [Team] {
        switch order {
            case .ascending:
                return self.sorted{ $0.name < $1.name }
            case .descending:
                return self.sorted{ $0.name > $1.name }
        }
    }
}
