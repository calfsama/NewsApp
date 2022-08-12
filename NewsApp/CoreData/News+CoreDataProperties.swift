//
//  News+CoreDataProperties.swift
//  
//
//  Created by Tomiris Negmatova on 08/08/22.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var url: String?
    @NSManaged public var newsID: String?
    @NSManaged public var source: String?
    @NSManaged public var date: String?

}
extension News: Identifiable{}
