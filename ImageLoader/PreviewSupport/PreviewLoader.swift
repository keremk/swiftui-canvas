//
//  PreviewLoader.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

#if DEBUG
final class PreviewLoader: ImageLoadable {
    weak var delegate: ImageResolverDelegate?

     func load(name: String, size: ImageSizeable) -> CGImage? {
        guard
            let image = UIImage(named: name)?.cgImage
        else {
            let previewName = "PreviewPlaceholder_\(size.getSizeString())"
            return UIImage(named: previewName)?.cgImage
        }
        return image
    }
}
#endif
