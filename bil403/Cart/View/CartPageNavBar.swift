//
//  CartPageNavBar.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI


struct CartPageNavBar: View {
    @Environment(\.presentationMode) var presentationMode;
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .tint(.white)
                    .font(.subheadline)
            }
            Spacer()
            Text("Sepetim")
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            Button {
                cart.clear()
            } label: {
                Image(systemName: "trash.fill")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .opacity(cart.isEmpty ? 0.5 : 1)
            .disabled(cart.isEmpty)
            
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(appPurple)
    }
}


struct CartPageNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CartPageNavBar()
            .previewLayout(.sizeThatFits)
    }
}
