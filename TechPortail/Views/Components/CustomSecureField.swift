//
//  CustomSecureField.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-08-27.
//

import SwiftUI

struct CustomSecureField: View {
    //MARK:- PROPERTIES
    var placeholder: Text
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    
    @Binding var password: String
    @State var isEmpty: Bool
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if isEmpty { placeholder.modifier(CustomTextM(fontName: fontName, fontSize: fontSize, fontColor: fontColor)) }
            SecureField("", text: $password, onCommit: commit)
                .foregroundColor(Color.primary)
                .onAppear{
                    isEmptyField()
                }
        }
    }
    func isEmptyField() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isEmpty = password.isEmpty
            isEmptyField()
        }
    }
}

