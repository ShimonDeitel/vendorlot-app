import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [SaleItem] = []
    @Published var isPro: Bool = false

    /// Free tier allows this many entries. Seed data below is always fewer than this
    /// so a fresh install never opens straight into the paywall.
    static let freeLimit = 20

    private let fileName = "vendorlot_items.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([SaleItem].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    @discardableResult
    func add(_ item: SaleItem) -> Bool {
        guard canAddMore else { return false }
        items.append(item)
        save()
        return true
    }

    func update(_ item: SaleItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: SaleItem) {
        items.removeAll { $0.id == item.id }
        save()
    }

    static func seedData() -> [SaleItem] {
        [
        SaleItem(item: "Salad", price: 3.5, soldDate: Date().addingTimeInterval(-259200), buyerNote: "Neighbor"),
        SaleItem(item: "Chips", price: 5.75, soldDate: Date().addingTimeInterval(-518400), buyerNote: "Cash sale"),
        SaleItem(item: "Soda", price: 8.0, soldDate: Date().addingTimeInterval(-777600), buyerNote: "Neighbor"),
        SaleItem(item: "Salad", price: 10.25, soldDate: Date().addingTimeInterval(-1036800), buyerNote: "Cash sale")
        ]
    }
}
