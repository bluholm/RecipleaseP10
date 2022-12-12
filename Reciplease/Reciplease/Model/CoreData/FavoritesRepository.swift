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
    
    //MARK: - Public Methods CoreData
    
    func createData(data: Recipie) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let userEntity = NSEntityDescription.entity(forEntityName: entitie, in: managedContext) else { return }
        let user =  NSManagedObject(entity: userEntity, insertInto: managedContext)
        let ingredient = data.ingredients.map { $0+"\n" }.joined()
        user.setValue(data.title, forKey: ConstantKey.title)
        user.setValue(Int16(data.yield), forKey: ConstantKey.yield)
        user.setValue(ingredient, forKey: ConstantKey.ingredients)
        user.setValue(data.fileName, forKey: ConstantKey.fileName)
        user.setValue(Int16(data.time), forKey: ConstantKey.time)
        user.setValue(data.url, forKey: ConstantKey.url)
        
        saveFiles(url: data.imageurl, fileName: data.fileName)
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("error when in CoreData \(error)")
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
            print("error when fetching data with coreData \(error)")
        }
    }
    
    func deleteData(data: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(data)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("error when deleting data \(error)")
        }
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
            print("error checking if data Exists \(error)")
            return false
        }
    }
    
    //MARK:  - Public Methods  Document Directory
    
    func saveFiles(url: String, fileName: String) {
                guard let url = URL(string: url) else { return }
                getData(from: url) { data, response, error in
                    guard let imageData = data else { return }
                    if let image = UIImage(data: imageData) {
                        if let data = image.jpegData(compressionQuality: 0.8) {
                            let filename = self.getDocumentsDirectory().appendingPathComponent(fileName)
                            try? data.write(to: filename)
                        }
                    }
                }
            }
    
    func deleteFiles(_ fileToDelete: String) {
            let fileManager = FileManager.default
            let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(fileToDelete)
            if fileManager.fileExists(atPath: yourProjectImagesPath) {
                try! fileManager.removeItem(atPath: yourProjectImagesPath)
            }
        }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getDocumentsDirectory() -> URL {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                return paths[0]
    }
    
    
}

//MARK: - Extension UIImage loadFiles

extension UIImageView {
    func loadFiles(from nameFile: String) {
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nameFile)
        self.image = UIImage(contentsOfFile: yourProjectImagesPath)
    }
}

