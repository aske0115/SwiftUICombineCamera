//
//  ControlView.swift
//  SwiftUICombineCamera
//
//  Created by 1101249 on 11/15/22.
//

import SwiftUI

struct ControlView: View {
    @Binding var comicSelected: Bool
    @Binding var lineOverlaySelected: Bool
    @Binding var crystalSelected: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 12) {
                ToggleButton(selected: $comicSelected, label: "Comic")
                ToggleButton(selected: $lineOverlaySelected, label: "LineOverlay")
                ToggleButton(selected: $crystalSelected, label: "Crystal")
            }
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView(comicSelected: .constant(false), lineOverlaySelected: .constant(false), crystalSelected: .constant(false))
    }
}
