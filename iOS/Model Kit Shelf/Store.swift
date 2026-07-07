import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [Kit] = []
    @Published var isPro: Bool = false

    static let freeLimit = 20

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("modelkitshelf_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Kit) {
        items.append(item)
        save()
    }

    func update(_ item: Kit) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Kit) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Kit].self, from: data) {
            items = decoded
        } else {
            items = [
        Kit(name: "F-14 Tomcat", scale: "1/48", status: "Unbuilt", notes: "Tamiya kit"),
        Kit(name: "USS Enterprise", scale: "1/350", status: "In Progress", notes: "Revell"),
        Kit(name: "Ferrari 250 GTO", scale: "1/24", status: "Finished", notes: "Weathered finish"),
        Kit(name: "Gundam RX-78", scale: "1/144", status: "Unbuilt", notes: "Bandai HG"),
        Kit(name: "Sherman Tank", scale: "1/35", status: "In Progress", notes: "Diorama base")
            ]
            save()
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }
}
