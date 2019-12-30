//
//  Movie.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import Foundation

struct Movie: Hashable, Codable, Identifiable {
    let id: Int
    let title: String
    let posterName: String
}
