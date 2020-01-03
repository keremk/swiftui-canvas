//
//  MovieDetails.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/3/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation
import Combine

final class MovieDetails: ObservableObject {
    @Published var movie:Movie? = nil
    
    func fetchMovie(mode: EnvironmentConfig.Mode) -> Movie? {
        return nil
    }
    
}
