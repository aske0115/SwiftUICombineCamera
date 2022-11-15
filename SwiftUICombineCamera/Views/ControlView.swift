//
//  ControlView.swift
//  SwiftUICombineCamera
//
//  Created by 1101249 on 11/15/22.
//

import SwiftUI

struct ControlView: View {
    @Binding var comicSelected: Bool
    @Binding var monoSelected: Bool
    @Binding var crystalSelected: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 12) {
                ToggleButton(selected: $comicSelected, label: "Comic")
                ToggleButton(selected: $monoSelected, label: "Mono")
                ToggleButton(selected: $crystalSelected, label: "Crystal")
            }
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView(comicSelected: .constant(false), monoSelected: .constant(false), crystalSelected: .constant(false))
    }
}
