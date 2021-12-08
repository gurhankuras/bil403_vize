//
//  CartProductView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI


struct CartProductView: View {
    @State var count: Int = 1
    var body: some View {
        HStack {
            ProductThumbnail()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text("Elma")
                    .font(.caption)
                    .foregroundColor(.black)
                Text("1 kg")
                    .foregroundColor(Color(UIColor(.secondary)))
                    .font(.footnote)
                    .padding(.bottom, 5)
                Text("$\(16.54.toFixedString(2))")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(appPurple)
                    .padding(.bottom, 1)
                
            }
            .padding(.leading)
            Spacer()
            IncrementDecrementProductButtonGroup(countInCart: $count)
                .scaleEffect(0.7)
            
        }
        .padding()
    }
}


struct CartProductView_Previews: PreviewProvider {
    static var previews: some View {
        CartProductView()
            .previewLayout(.sizeThatFits)
    }
}
