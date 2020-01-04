//
//  AsyncLoader.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI
import Combine
import os.log

final class AsyncLoader: ImageLoadable {
    weak var delegate: ImageResolverDelegate?
    var cancelable: AnyCancellable? = nil

    func load(name: String, size: ImageSizeable) -> CGImage? {
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        let sizeDesc = size.getSizeString()
        if let url = URL(string: "https://image.tmdb.org/t/p/\(sizeDesc)/\(name)") {
            cancelable = session.dataTaskPublisher(for: url)
                .receive(on: RunLoop.main)
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(_):
                            os_log("Error loading image %{PUBLIC}@", log: .default, type: .error, name)
                            break
                        }
                    },
                    receiveValue:  { (data, response) in
                        self.delegate?.didLoad(image: self.imageFromData(data: data))
                })
        }
        return nil
    }
    
    private func imageFromData(data: Data?) -> CGImage? {
        guard
            let data = data,
            let imageSource = CGImageSourceCreateWithData(data as CFData, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            return nil
        }
        return image
    }
    deinit {
        cancelable?.cancel()
    }
}
