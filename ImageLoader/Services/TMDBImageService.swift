//
//  TMDBImageFetcher.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/6/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation
import Combine

final class TMDBImageService: ImageFetchable {
    struct TMDBEndpoint {
        static let scheme = "https"
        static let host = "image.tmdb.org"
        static let basePath = "/t/p/"

        static func components(with path:String) -> URLComponents {
         var urlComponents = URLComponents()
         urlComponents.host = host
         urlComponents.scheme = scheme
         urlComponents.path = path
         return urlComponents
        }
    }

    private var session:URLSession {
        return URLSession(configuration: URLSessionConfiguration.ephemeral)
    }

    func fetchImage(name: String, size: ImageSizeable) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        guard let url = buildImageEndpoint(name: name, size: size) else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    private func buildImageEndpoint(name: String, size: ImageSizeable) -> URL? {
        let sizeDesc = size.getSizeString()
        let path = "\(TMDBEndpoint.basePath)\(sizeDesc)/\(name)"
        return TMDBEndpoint.components(with:path).url
    }

}
