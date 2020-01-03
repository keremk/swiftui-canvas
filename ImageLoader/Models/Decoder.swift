//
//  Decoder.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/3/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation

func useDecoder() -> JSONDecoder {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
}
