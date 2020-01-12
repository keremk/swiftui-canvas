//
//  PreviewImage.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/12/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation
import UIKit

func fetchPreviewImage(imageName: String, size: ImageSizeable, fetcher: () -> CGImage?) -> CGImage? {
#if PREVIEW
    return loadPreviewImage(name: imageName, size: size)
#else
    return fetcher()
#endif
}

#if PREVIEW
func loadPreviewImage(name: String, size: ImageSizeable) -> CGImage? {
    guard
        let image = UIImage(named: name)?.cgImage
    else {
        let previewName = "PreviewPlaceholder_\(size.getSizeString())"
        return UIImage(named: previewName)?.cgImage
    }
    return image
}
#endif
