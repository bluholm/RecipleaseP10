//
//  Favorites+CoreDataProperties.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//
//

import Foundation
import CoreData

extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var fileName: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var time: Int16
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var yield: Int16

}

extension Favorites: Identifiable {

}
