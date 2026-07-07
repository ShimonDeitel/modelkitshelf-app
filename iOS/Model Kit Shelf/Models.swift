import Foundation

struct Kit: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var scale: String
    var status: String
    var notes: String
    var dateAdded: Date = Date()
}
