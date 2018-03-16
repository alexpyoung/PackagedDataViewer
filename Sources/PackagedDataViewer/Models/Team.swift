
import Foundation
import SQLite

struct Team: Model {

    static let typeIdentifier = "team"

    let id: String
    let name: String
    let status: String
    let timestamp: Date

    init(blob: SQLite.Blob) throws {
        let data = Data(bytes: blob.bytes, count: blob.bytes.count)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:AnyHashable]
        else {
            throw PackagedDataViewerError.invalidJSONObject
        }
        guard let timestamp = json["save_date"] as? String,
              let date = Team.dateFormatter.date(from: timestamp)
        else {
            throw PackagedDataViewerError.invalidJSONProperty
        }
        self.id = json["_id"] as? String ?? ""
        self.timestamp = date
        self.name = json["name"] as? String ?? ""
        self.status = json["status"] as? String ?? ""
    }
}
