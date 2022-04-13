//
//  LessonsEndpoint.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum LessonsAPI {
    case getLessons
}

extension LessonsAPI: APIBuilder {
    
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        
    }
    
    var baseUrl: URL {
        switch self {
        case .getLessons:
            return URL(string: "https://iphonephotographyschool.com/test-api")!
        }
    }
    
    var path: String {
        return "/lessons"
    }
}
