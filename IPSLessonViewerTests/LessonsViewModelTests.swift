//
//  LessonsTests.swift
//  IPSLessonViewerTests
//
//  Created by Azhar Islam on 18/04/2022.
//

import XCTest
import Combine
@testable import IPSLessonViewer

class LessonsViewModelTests: XCTest {
    
    private var cancellables: Set<AnyCancellable>!
    private var testViewModel: LessonsViewModel!
    private var mockLessonsService: MockLessonsService!
    
    override func setUp() {
        super.setUp()
        mockLessonsService = MockLessonsService()
        testViewModel = .init(service: mockLessonsService)
        cancellables = []
    }
    
    func testLessonsSuccess() {
        let lessonsToTest = [Lesson(id: 1, name: "L", lessonDescription: "D", thumbnail: "T", videoURL: "V")]
        let lessonsResponseToTest = LessonsResponse(lessons: lessonsToTest)
        let expectation = XCTestExpectation(description: "State is success")
        
        testViewModel.$state.dropFirst().sink { state in
            XCTAssertEqual(state, .success(content: lessonsToTest))
            expectation.fulfill()
        }.store(in: &cancellables)
        
        mockLessonsService.fetchLessonResult = Result.success(lessonsResponseToTest).publisher.eraseToAnyPublisher()
        testViewModel.getLessons()
        
        let result = XCTWaiter.wait(for: [expectation], timeout:1)
        XCTAssertTrue(result == .completed)
    }
    
    func testGetJobsEmpty() {
        let lessonsToTest: [Lesson] = []
        let lessonsResponseToTest = LessonsResponse(lessons: lessonsToTest)
        let expectation = XCTestExpectation(description: "State is failure")
        
        testViewModel.$state.dropFirst().sink { state in
            XCTAssertEqual(state, .failed(error: APIError.decodingError))
            expectation.fulfill()
        }.store(in: &cancellables)
        
        mockLessonsService.fetchLessonResult = Result.success(lessonsResponseToTest).publisher.eraseToAnyPublisher()
        testViewModel.getLessons()
        let result = XCTWaiter.wait(for: [expectation], timeout:1)
        XCTAssertTrue(result == .completed)
    }
    
}

class MockLessonsService: LessonsServiceProtocol {
    
    var fetchLessonResult: AnyPublisher<LessonsResponse, APIError>!
    
    func request(from endpoint: LessonsAPI) -> AnyPublisher<LessonsResponse, APIError> {
        fetchLessonResult = Just(LessonsResponse(lessons: []))
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
        return fetchLessonResult
    }
}
