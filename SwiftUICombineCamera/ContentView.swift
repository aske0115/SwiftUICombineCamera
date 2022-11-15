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
        ZStack {
            FrameView(image: model.frame)
                .edgesIgnoringSafeArea(.all)
            ControlView(comicSelected: $model.comicFilter, monoSelected: $model.monoFilter, crystalSelected: $model.crystalFilter)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
