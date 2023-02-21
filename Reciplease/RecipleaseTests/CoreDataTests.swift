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
    let model = FavoritesRepository()
    // MARK: - Overrides
    override func setUp() {
        super.setUp()
        persistentContainer = NSPersistentContainer(name: "Reciplease")
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
        flushData()
        super.tearDown()
        // persistentContainer.viewContext.rollback()
        // persistentContainer = nil
    }
    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        // swiftlint: disable force_try
        let objs = try! persistentContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            persistentContainer.viewContext.delete(obj)
        }
        // swiftlint: disable force_try
        try! persistentContainer.viewContext.save()

    }

    // MARK: - Tests CoreData
    func testMyEntityFunctionality() {
        let context = persistentContainer.viewContext
        let myEntity = Favorites(context: context)
        myEntity.title = "Test object"
        do {
            try context.save()
        } catch {
            print("error")
        }
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", "Test object")
        do {
            let results = try context.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1)
            XCTAssertEqual(results.first?.title, "Test object")
        } catch {
            XCTFail("expected a result")
        }
    }
    func testWhenCreateDataThenExpectDataInCoreData() {
        let managedContext = persistentContainer.newBackgroundContext()
        managedContext.performAndWait {
            model.createData(data: FakeDataCoreData.recipie)
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do {
            let results = try managedContext.fetch(fetchRequest)
            guard let result = results.first as? NSManagedObject else { return }
            XCTAssertEqual(result.value(forKey: ConstantKey.title) as? String, "Test")
            XCTAssertEqual(result.value(forKey: ConstantKey.yield) as? Int16, 2)
            XCTAssertEqual(result.value(forKey: ConstantKey.ingredients) as? String, "salade\ntomate\n")
            XCTAssertEqual(result.value(forKey: ConstantKey.fileName) as? String, "test.jpg")
            XCTAssertEqual(result.value(forKey: ConstantKey.time) as? Int16, 30)
            XCTAssertEqual(result.value(forKey: ConstantKey.url) as? String, "https://example.com")
        } catch {
            XCTFail("error not expected")
        }
    }
    func testWhenCreateDataThenExpectFetchingData() {
        let managedContext = persistentContainer.newBackgroundContext()
        managedContext.performAndWait {
            model.createData(data: FakeDataCoreData.recipie)
        }
        model.getData { results in
            guard let result = results.first else { return }
            XCTAssertEqual(result.value(forKey: ConstantKey.title) as? String, "Test")
            XCTAssertEqual(result.value(forKey: ConstantKey.time) as? Int16, 2)
            XCTAssertEqual(result.value(forKey: ConstantKey.ingredients) as? String, "salade\ntomate\n")
            XCTAssertEqual(result.value(forKey: ConstantKey.fileName) as? String, "test.jpg")
            XCTAssertEqual(result.value(forKey: ConstantKey.yield) as? Int16, 30)
            XCTAssertEqual(result.value(forKey: ConstantKey.url) as? String, "https://example.com")
        }
    }
    func testWhenCreateDataThenWithInvalidDataShouldThrowError() {
        let invalidData = FakeDataCoreData.recipeKO
            model.createData(data: invalidData)
            XCTAssertNotNil(model.error)
    }
    func testGetData() {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context)!
        let object1 = NSManagedObject(entity: entity, insertInto: context)
        object1.setValue("test1", forKeyPath: "title")
        let object2 = NSManagedObject(entity: entity, insertInto: context)
        object2.setValue("test2", forKeyPath: "title")
        //swiftlint: disable force_try
        try! context.save()
        let expectation = self.expectation(description: "callback")
        model.getData(callback: { (result) in
            XCTAssertEqual(result.count, 2)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 1, handler: nil)
    }

}
