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

    @NSManaged public var thumbnail: URL?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var lessonDescription: String?
    @NSManaged public var videoUrl: String?

}

extension LessonsEntity : Identifiable {

}
