//
//  LessonsService.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 13/04/2022.
//

import Foundation
import Combine

//  Seperate concerns by using protocols and support dependency injection
//  Using Combine MVVM
//  AnyPublisher allows us to listen and subscribe to the event we want to publish

protocol LessonsServiceProtocol {
    func request(from endpoint: LessonsAPI) -> AnyPublisher<LessonsResponse, APIError>
}

struct LessonsService: LessonsServiceProtocol {
    
    func request(from endpoint: LessonsAPI) -> AnyPublisher<LessonsResponse, APIError> {
        
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in
                APIError.unknown
            }
            .flatMap { data, response -> AnyPublisher<LessonsResponse, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    
                    let jsonDecoder = JSONDecoder()
                    
                    return Just(data)
                        .decode(type: LessonsResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

