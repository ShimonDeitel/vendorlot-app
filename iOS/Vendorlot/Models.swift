import Foundation

struct SaleItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var item: String
    var price: Double
    var soldDate: Date
    var buyerNote: String

    init(id: UUID = UUID(), item: String = "", price: Double = 0.0, soldDate: Date = Date(), buyerNote: String = "") {
        self.id = id
        self.item = item
        self.price = price
        self.soldDate = soldDate
        self.buyerNote = buyerNote
    }
}
