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

struct Lesson: Codable, Identifiable, Equatable {
    let id: Int?
    let name, lessonDescription: String?
    let thumbnail: String?
    let videoURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case lessonDescription = "description"
        case thumbnail
        case videoURL = "video_url"
    }
}

extension Lesson {
    static var dummyData: Lesson {
        .init(id: 7991, name: "How To Preserve Your Memories With iPhone Live Photos", lessonDescription:  "If your iPhone has more than one lens, how do you choose which lens to use? And which lens is best for different photography genres? It turns out that you'll get dramatically different results depending on which lens you use. Watch this video from our breakthrough iPhone Photo Academy course and discover how to choose the correct iPhone camera lens.", thumbnail: "https://embed-ssl.wistia.com/deliveries/f7105de283304e0dc6fe40e5abbf778f.jpg?image_crop_resized=1000x560", videoURL: "https://embed-ssl.wistia.com/deliveries/db6cd74cf31ff8afca1f71b3c12fd820dcbde404/oazth83ovc.mp4")
    }
}

