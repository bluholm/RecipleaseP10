//
//  Favorites.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-07.
//

import Foundation
import CoreData

@objc(Person)
class Favorites: NSManagedObject {
    
    static func createFavorites(with data: Recipie, context: NSManagedObjectContext) {
        let favori = Favorites(context: context)
        
        let ingredient = data.ingredients.map { $0+"\n" }.joined()
        favori.title = data.title
        favori.yield = Int16(data.yield)
        favori.ingredients = ingredient
        favori.time = Int16(data.time)
        favori.url = data.url
        favori.fileName = data.fileName
        
         FavoritesRepository().saveFiles(url: data.imageurl, fileName: data.fileName)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func fetchFavorites(context: NSManagedObjectContext) -> [Favorites]? {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    static func deleteFavorites(element: String, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", element)
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                context.delete(result)
            }
            
            try context.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    static func isExistFavorite(element: String, context: NSManagedObjectContext) -> Bool {
        
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", element)
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                return false
            }
            return true
            
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
            return false
        }
    }
    
}
