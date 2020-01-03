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

    func load(imageName: String) -> CGImage? {
        guard
            let image = UIImage(named: imageName)?.cgImage
        else {
            return UIImage(named: "PreviewPlaceholder")?.cgImage
        }
        return image
    }
}
#endif
