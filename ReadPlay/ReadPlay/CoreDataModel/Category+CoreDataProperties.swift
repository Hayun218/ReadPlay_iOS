//
//  Category+CoreDataProperties.swift
//  ReadPlay
//
//  Created by yun on 11/24/23.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var categoryId: Int32
    @NSManaged public var progress: Int32
    @NSManaged public var title: String
    @NSManaged public var totalNum: Int32
    @NSManaged public var studyDate: String?
    @NSManaged public var vocabs: NSSet

}

// MARK: Generated accessors for vocabs
extension Category {

    @objc(addVocabsObject:)
    @NSManaged public func addToVocabs(_ value: Vocab)

    @objc(removeVocabsObject:)
    @NSManaged public func removeFromVocabs(_ value: Vocab)

    @objc(addVocabs:)
    @NSManaged public func addToVocabs(_ values: NSSet)

    @objc(removeVocabs:)
    @NSManaged public func removeFromVocabs(_ values: NSSet)

}

extension Category : Identifiable {

}
