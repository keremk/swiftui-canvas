//
//  TMDBImages.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/3/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation

protocol ImageSizeable {
    func getSizeString() -> String
}

enum TMDBPosterSize: String, ImageSizeable {
    case original
    case small = "w154"
    case medium = "w500"
    case large = "w780"

    func getSizeString() -> String {
        rawValue
    }
}

enum TMDBActorSize: String, ImageSizeable {
    case original
    case small = "w45"
    case medium = "w185"
    case large = "h632"

    func getSizeString() -> String {
        rawValue
    }
}

enum TMDBBackdropSize: String, ImageSizeable {
    case original
    case small = "w300"
    case medium = "w780"
    case large = "w1280"

    func getSizeString() -> String {
        rawValue
    }
}
