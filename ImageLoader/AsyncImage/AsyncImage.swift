//
//  SwiftUIView.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/27/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct AsyncImage: View {
    let imageName: String
    let placeholder = UIImage(named: "placeholder.jpg")!.cgImage!
    
    @EnvironmentObject private var env: EnvironmentConfig
    @ObservedObject private var loader: ImageResolver
    
    init(imageName: String) {
        self.imageName = imageName
        self.loader = ImageResolver()
    }
    
    var image: CGImage? {
        return loader.load(imageName: imageName, mode: env.mode)
    }
    
    var body: some View {
        Image(image ?? placeholder, scale: 1.0, label: Text("")).resizable()
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        return AsyncImage(imageName: "ykIZB9dYBIKV13k5igGFncT5th6")
            .frame(width: 390.0, height: 585.0, alignment: Alignment.center)
            .environmentObject(EnvironmentConfig(mode: .PreviewMode))
    }
}
