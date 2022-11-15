//
//  ContentView.swift
//  SwiftUICombineCamera
//
//  Created by 1101249 on 11/15/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = ContentViewModel()
    var body: some View {
        FrameView(image: model.frame)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
