//
//  EnvironmentConfig.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/31/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import Foundation

final class EnvironmentConfig: ObservableObject {
    enum Mode {
        case PreviewMode
        case RuntimeMode
    }

    let mode: Mode
    
    init(mode: Mode) {
        self.mode = mode
    }
}
