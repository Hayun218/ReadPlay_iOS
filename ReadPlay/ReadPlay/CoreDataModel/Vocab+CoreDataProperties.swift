//
//  Vocab+CoreDataProperties.swift
//  ReadPlay
//
//  Created by yun on 11/23/23.
//
//

import Foundation
import CoreData


extension Vocab {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vocab> {
        return NSFetchRequest<Vocab>(entityName: "Vocab")
    }

    @NSManaged public var id: Int32
    @NSManaged public var meaning: String
    @NSManaged public var word: String
    @NSManaged public var category: Category

}
