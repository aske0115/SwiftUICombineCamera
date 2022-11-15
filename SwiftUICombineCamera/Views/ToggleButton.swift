//
//  ToggleButton.swift
//  SwiftUICombineCamera
//
//  Created by 1101249 on 11/15/22.
//

import SwiftUI

struct ToggleButton: View {
    @Binding var selected: Bool
    var label: String
    
    var body: some View {
        Button {
            selected.toggle()
        } label: {
            Text(label)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .foregroundColor(selected ? .white : .black)
        .background(selected ? Color.blue : Color.white)
        .animation(.easeIn, value: 0.4)
        .cornerRadius(10)
    }
}

struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButton(selected: .constant(false), label: "Toggle")
    }
}
