//
//  FavoritesRepository.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-07.
//

import Foundation
import CoreData
import UIKit

//FIXME: - to be rename + virer tout les fonctions inutles . 
final class FavoritesRepository {
    
    // MARK: - Properties
    
    private let entitie = "Favorites"
    var error: NSError!
    
    // MARK: - Public Methods
    
    func saveFiles(url: String, fileName: String) {
        guard let url = URL(string: url) else { return }
        getData(from: url) { data, _, _ in
            guard let imageData = data else { return }
            if let image = UIImage(data: imageData) {
                if let data = image.jpegData(compressionQuality: 0.8) {
                    let filename = self.getDocumentsDirectory().appendingPathComponent(fileName)
                    try? data.write(to: filename)
                }
            }
        }
    }
    
    func deleteFiles(_ fileToDelete: String?) {
        guard let fileToDelete else { return }
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(fileToDelete)
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            do {
                try fileManager.removeItem(atPath: yourProjectImagesPath)
            } catch {
                print("error when deleting file")
            }
            
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
