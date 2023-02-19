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

/*
extension AppDelegate {
    var testManagedContext: NSManagedObjectContext {
        let managedContext = persistentContainer.viewContext
        managedContext.automaticallyMergesChangesFromParent = true
        return managedContext
    }

    var testPersistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "Reciplease")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }
}


final class CoreDataTests: XCTestCase {
    
    let model =  FavoritesRepository()
    var managedContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        managedContext = (UIApplication.shared.delegate as! AppDelegate).testManagedContext
    }
    
    /*override func tearDown() {
        super.tearDown()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipleaseTests")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print("error when deleting data \(error)")
        }
    }*/
    

    
    func testgivnGoodDataWhnRequestThenExepctedSuccess() {
        // ma strategie :
        // creation d'une fakeData
        let data = Recipie(title: "Tartiflette",
                           ingredients: ["fromage","jambon","patates"],
                           time: 35,
                           fileName: "IMG-CF2A6DCF-7534-41F5-B0B4-642B85E1A3D1-78177-000013CCAB455459",
                           imageurl: "http://imageUrl.jpg",
                           yield: 2,
                           url: "http://soupeDuSud.com")
        
        //insertion d'une fakeData
        model.createData(data: data)
        XCTAssertNotNil(data)
        //fetch la data : si elle existe : alors test concluant !
        
        //supprimer la data en qesutinos .
 
    }
    

    
}




*/
