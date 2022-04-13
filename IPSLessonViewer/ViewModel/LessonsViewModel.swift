//
//  LessonsViewModel.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import Foundation
import Combine

//  Seperate concerns using protocols
//  Implement dependency injection using the LessonsService
//  Make network call to fetch results

protocol LessonsViewModelProtocol {
    func getLessons()
}

class LessonsViewModel: ObservableObject, LessonsViewModelProtocol {
    
    private let service: LessonsService
    private(set) var lessons = [Lesson]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: LessonsService) {
        self.service = service
    }
    
    func getLessons() {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .getLessons)
            .sink { res in
                switch res {
                case .finished:
                    self.state = .success(content: self.lessons)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.lessons = response.lessons
            }
        
        self.cancellables.insert(cancellable)
    }
}
