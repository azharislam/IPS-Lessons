//
//  ResultState.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import Foundation

enum ResultState: Equatable {
    static func == (lhs: ResultState, rhs: ResultState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success, .success): return true
        case (.failed, .failed): return true
        default: return false
        }
    }
    
    case loading
    case success(content: [Lesson])
    case failed(error: Error)
}
