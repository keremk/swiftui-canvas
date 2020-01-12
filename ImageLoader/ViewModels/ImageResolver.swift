//
//  ImageLoaderConfig.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI
import Combine
import os.log

protocol ImageSizeable {
    func getSizeString() -> String
}

protocol ImageFetchable {
    func fetchImage(name: String, size: ImageSizeable) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

final class ImageResolver: ObservableObject {
    @Published var image: CGImage? = nil
    private let name: String
    private let size: ImageSizeable
    private let imageFetchable: ImageFetchable

    init(name: String, size: ImageSizeable, service: ImageFetchable = TMDBImageService()) {
        self.name = name
        self.size = size
        self.imageFetchable = service
    }
    
    private var disposables = Set<AnyCancellable>()
    
    func fetchImage() -> CGImage? {
        return fetchPreviewImage(imageName: name, size: size, fetcher: fetch)
    }

    private func fetch() -> CGImage? {
        if image != nil {
            return image
        }
        imageFetchable.fetchImage(name: name, size: size)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        os_log("Error loading image %{PUBLIC}@", log: .default, type: .error, self?.name ?? "")
                        break
                    }
                },
                receiveValue:  { [weak self] (data, _) in
                    self?.image = self?.imageFromData(data: data)
                })
            .store(in: &disposables)
        return image
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
}
