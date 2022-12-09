//
//  FavoritesRepository.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-07.
//

import Foundation
import CoreData
import UIKit


final class FavoritesRepository {
    
    //MARK: - Properties
    
    private let entitie = "Favorites"
    
    //MARK: - Public Methods
    
    func createData(data: Recipie) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let userEntity = NSEntityDescription.entity(forEntityName: entitie, in: managedContext) else { return }
        let user =  NSManagedObject(entity: userEntity, insertInto: managedContext)
        let ingredient = data.ingredients.map { $0+"\n" }.joined()
        user.setValue(data.title, forKey: ConstantKey.title)
        user.setValue(Int16(data.yield), forKey: ConstantKey.yield)
        user.setValue(ingredient, forKey: ConstantKey.ingredients)
        user.setValue(data.image, forKey: ConstantKey.image)
        user.setValue(Int16(data.time), forKey: ConstantKey.time)
        user.setValue(data.url, forKey: ConstantKey.url)
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func getData(callback: @escaping([NSManagedObject]) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let  fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entitie)
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else {
                callback([])
                return
            }
            callback(result)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func deleteData(data: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(data)
        try? managedContext.save()
    }
    
    func isDataExist(title: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let  fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entitie)
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else {
                return false
            }
            if result.isEmpty {
                return false
            } else {
                return true
            }
        } catch let error as NSError {
            debugPrint(error)
            return false
        }
    }
    
}
