//
//  LessonsEntity+CoreDataProperties.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 18/04/2022.
//
//

import Foundation
import CoreData


extension LessonsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LessonsEntity> {
        return NSFetchRequest<LessonsEntity>(entityName: "LessonsEntity")
    }

    @NSManaged public var lessonsName: String?
    @NSManaged public var lessonsImage: String?
    @NSManaged public var lessonsDesc: String?
    @NSManaged public var lessonsVideo: String?
    @NSManaged public var id: Int32

}

extension LessonsEntity : Identifiable {

}
