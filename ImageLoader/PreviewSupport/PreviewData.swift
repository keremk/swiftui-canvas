//
//  PreviewMovies.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/1/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation

func fetchPreviewData<T: Decodable>(previewFile: String, fetcher: () -> T) -> T {
#if PREVIEW
    return loadPreviewData(previewFile)
#else
    return fetcher()
#endif
}

#if PREVIEW
// Below is directly "borrowed" from https://developer.apple.com/tutorials/swiftui/composing-complex-interfaces
func loadPreviewData<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = useDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
#endif
