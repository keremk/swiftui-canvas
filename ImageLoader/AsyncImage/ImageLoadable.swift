//
//  ImageLoadable.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

protocol ImageLoadable {
    func load(name: String, size: ImageSizeable) -> CGImage?
    var delegate: ImageResolverDelegate? { get set }
}
