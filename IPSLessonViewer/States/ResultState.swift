//
//  ResultState.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Lesson])
    case failed(error: Error)
}
