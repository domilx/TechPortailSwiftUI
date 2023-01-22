//
//  NewsCardView.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-11-27.
//
import SwiftUI

struct NewsCardView: View {
    var title: String
    var description: String
    var dateRaw: String
    
    var body: some View {
        let date: Date? = returnDate(date: dateRaw)

        VStack{
            HStack( spacing: 6) {
                Text(title)
                    .fontWeight(.bold)
                Spacer()
            }
            Divider()
            HStack{
                Text(description)
                Spacer()
            }
        }
        .font(.body.weight(.medium))
        .foregroundColor(Color(.displayP3, red: 28/255, green: 131/255, blue: 119/255)
        )
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .clipped()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("primary"))
                .addBorder(Color(.displayP3, red: 136/255, green: 184/255, blue: 177/255), width: 5, cornerRadius: 15)
                //.stroke(Color(.displayP3, red: 136/255, green: 184/255, blue: 177/255), lineWidth: 4)
            
        }
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}

struct NewsCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewsCardView(title: "FRC: Téléchargez d'avance le manuel de jeu", description: "Afin d'être plus efficace lors du kick-off ce Samedi, nous vous recommandons de télécharger d'avance le manuel de jeu disponible sur le lien ci-bas. En effet, dû à un grand achalandage sur le site Internet de FIRST durant le kick-off, il risque d'être plus compliqué d'y avoir accès (le site va peut-être crash). Pour l'instant, le manuel est chiffré et nous aurons une clé permettant d'avoir accès à son contenu durant la diffusion en direct.\n\nLien: https://www.firstinspires.org/resource-library/frc/competition-manual-qa-system\n", dateRaw: "2022-01-06T21:45:44.988Z")
    }
}
