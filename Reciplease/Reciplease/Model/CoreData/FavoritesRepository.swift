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
        favorites.yield = Int16(favorite.yield)
        favorites.ingredients = favorite.ingredients.map { $0+"\n" }.joined()
        favorites.image = favorite.image
        favorites.time = Int16(favorite.time)
        
        do {
            try AppDelegate.viewContext.save()
            print("save")
        } catch {
            print("error while saving \(favorites)")
        }
    }
    
    func getData(callback: @escaping([Favorites]) -> Void ) {
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        guard let result = try? AppDelegate.viewContext.fetch(request) else {
            callback([])
            return
        }
        callback(result)
        
    }
}
