//
//  ContentView.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/27/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        withAnimation { AsyncImage(name: "ykIZB9dYBIKV13k5igGFncT5th6")
            .frame(width: 320.0, height: 480.0, alignment: Alignment.center) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ImageLoaderConfig(loader: PreviewLoader()))
    }
}
