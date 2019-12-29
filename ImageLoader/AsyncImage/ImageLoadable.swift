//
//  ImageLoadable.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

protocol ImageLoadable {
    func load(imageName: String) -> CGImage?
    var delegate: ImageLoaded? { get set }
}

protocol ImageLoaded: class {
    func didLoad(image: CGImage?)
}
