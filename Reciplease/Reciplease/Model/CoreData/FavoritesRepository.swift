//
//  FavoritesRepository.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-07.
//

import Foundation
import CoreData


final class FavoritesRepository {
    
    //MARK: - Public
    
    func saveData(favorite: Recipie) {
        let favorites = Favorites(context: AppDelegate.viewContext)
        
        //convertir l'image d'abord ; car l'url est limité dans le temps ! 
        
        favorites.title = favorite.title
        favorites.yield = favorite.yield
        favorites.ingredients = favorite.ingredients.map { $0+"\n" }.joined()
        favorites.image = favorite.image
        favorites.time = favorite.time
        
        do {
            try AppDelegate.viewContext.save()
            print("save")
        } catch {
            print("error while saving \(favorites)")
        }
    }
    
    func getData() throws -> [Favorites] {
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()

        do {
            guard let result = try? AppDelegate.viewContext.fetch(request) else {
                return []
            }
        return result
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}
