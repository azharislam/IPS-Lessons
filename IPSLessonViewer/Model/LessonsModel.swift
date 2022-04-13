//
//  LessonsModel.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import Combine

// MARK: - LessonResponse

struct LessonsResponse: Codable {
    let lessons: [Lesson]
}

// MARK: - Lesson

struct Lesson: Codable, Identifiable {
    let id: Int
    let name, lessonDescription: String
    let thumbnail: String
    let videoURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case lessonDescription = "description"
        case thumbnail
        case videoURL = "video_url"
    }
}
