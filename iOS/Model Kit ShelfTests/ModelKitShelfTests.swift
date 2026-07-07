import XCTest
@testable import ModelKitShelf

@MainActor
final class ModelKitShelfTests: XCTestCase {
    func testSeedDataLoadsBelowFreeLimit() {
        let store = Store()
        XCTAssertLessThan(store.items.count, Store.freeLimit)
    }

    func testAddIncreasesCount() {
        let store = Store()
        let before = store.items.count
        store.add(Kit(name: "Test Item", scale: "x", status: "x", notes: "x"))
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testDeleteRemovesItem() {
        let store = Store()
        let item = Kit(name: "Deletable", scale: "x", status: "x", notes: "x")
        store.add(item)
        store.delete(item)
        XCTAssertFalse(store.items.contains(where: { $0.id == item.id }))
    }

    func testCanAddMoreWhenBelowLimitAndNotPro() {
        let store = Store()
        store.isPro = false
        XCTAssertTrue(store.items.count < Store.freeLimit)
        XCTAssertTrue(store.canAddMore)
    }

    func testCannotAddMoreAtLimitWhenNotPro() {
        let store = Store()
        store.isPro = false
        while store.items.count < Store.freeLimit {
            store.add(Kit(name: "Filler", scale: "x", status: "x", notes: "x"))
        }
        XCTAssertFalse(store.canAddMore)
    }

    func testCanAddMoreWhenProEvenAtLimit() {
        let store = Store()
        store.isPro = true
        while store.items.count < Store.freeLimit {
            store.add(Kit(name: "Filler", scale: "x", status: "x", notes: "x"))
        }
        XCTAssertTrue(store.canAddMore)
    }

    func testUpdateModifiesExistingItem() {
        let store = Store()
        var item = Kit(name: "Original", scale: "x", status: "x", notes: "x")
        store.add(item)
        item.name = "Renamed"
        store.update(item)
        XCTAssertEqual(store.items.first(where: { $0.id == item.id })?.name, "Renamed")
    }
}
