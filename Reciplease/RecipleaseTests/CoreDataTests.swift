//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//
//
import XCTest
import CoreData
@testable import Reciplease

class MyEntityTests: XCTestCase {

    // MARK: - Properties
    var persistentContainer: NSPersistentContainer!
    var context: NSManagedObjectContext!

    // MARK: - Overrides
    override func setUp() {
        super.setUp()
        persistentContainer = NSPersistentContainer(name: "Reciplease")
        // swiftlint:disable line_length
        persistentContainer.persistentStoreDescriptions = [NSPersistentStoreDescription(url: URL(fileURLWithPath: "/dev/null"))]
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        context = persistentContainer.viewContext
    }
    override func tearDown() {
            persistentContainer = nil
            context = nil
            super.tearDown()
        }

    // MARK: - Tests CoreData
    func testGivenNewFavorite_WhenCreateFavorite_ThenOneMoreDataInCoreData() {
        Favorites.createFavorites(with: FakeDataCoreData.recipie, context: context)
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", FakeDataCoreData.recipie.title)
        do {
            let persons = try context.fetch(fetchRequest)
            XCTAssertEqual(persons.count, 1, "Unexpected number of persons")
            XCTAssertEqual(persons.first?.title, FakeDataCoreData.recipie.title, "Unexpected person name")
            XCTAssertEqual(persons.first?.time, Int16(FakeDataCoreData.recipie.time), "Unexpected person age")
        } catch {
            XCTFail("Failed to fetch person: \(error)")
        }
    }

    func testGivenMultipleFavorites_WhenFetchFavorite_ThenSuccess() {
        Favorites.createFavorites(with: FakeDataCoreData.recipie, context: context)
        Favorites.createFavorites(with: FakeDataCoreData.recipie2, context: context)

        let fetchedData = Favorites.fetchFavorites(context: context)
        XCTAssertEqual(fetchedData!.count, 2)
    }

    func testGivenExistingFavorite_WhenDeleteFavorite_ThenDeleteIsSuccess() {
        Favorites.createFavorites(with: FakeDataCoreData.recipie, context: context)
        // swiftlint:disable force_try
        try! context.save()
        Favorites.deleteFavorites(element: FakeDataCoreData.recipie.title, context: context)
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", FakeDataCoreData.recipie.title)
        // swiftlint:disable force_try
        let results = try! context.fetch(fetchRequest)
        XCTAssert(results.isEmpty)
    }

    func testGivenExistingDataInFavorite_WhenIsExistFavorite_ThenReturnTrue() {
        Favorites.createFavorites(with: FakeDataCoreData.recipie, context: context)
        // swiftlint:disable force_try
        try! context.save()
        let favori = Favorites.isExistFavorite(element: FakeDataCoreData.recipie.title, context: context)
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", FakeDataCoreData.recipie.title)
        // swiftlint:disable force_try
        let results = try! context.fetch(fetchRequest)
        let bool = results.count == 1 ? true : false
        XCTAssertEqual(favori, bool)
    }

    func testGivenNonExistingDataInFavorite_WhenIsExistFavorite_ThenReturnFalse() {
        Favorites.createFavorites(with: FakeDataCoreData.recipie, context: context)
        // swiftlint:disable force_try
        try! context.save()
        let favori = Favorites.isExistFavorite(element: FakeDataCoreData.recipie2.title, context: context)
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", FakeDataCoreData.recipie2.title)
        // swiftlint:disable force_try
        let results = try! context.fetch(fetchRequest)
        let bool = results.count == 1 ? true : false
        XCTAssertEqual(favori, bool)
    }
}
