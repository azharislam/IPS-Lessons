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

    @NSManaged public var id: Int32
    @NSManaged public var lessonName: String?
    @NSManaged public var lessonDescription: String?
    @NSManaged public var lessonImage: String?
    @NSManaged public var lessonVideo: String?

}

extension LessonsEntity : Identifiable {

}
