//
//  CustomCheckBox.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2023-01-10.
//

import SwiftUI

struct CustomCheckBox: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
            .font(.title)
    }
}

struct CustomCheckBox_Previews: PreviewProvider {
    struct CheckBoxViewHolder: View {
        @State var checked = false

        var body: some View {
            CustomCheckBox(checked: $checked)
        }
    }

    static var previews: some View {
        CheckBoxViewHolder()
    }
}
