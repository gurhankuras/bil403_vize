//
//  CartIcon.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI

struct CartIcon: View {
    @State var cartIsOpen: Bool = false
    @EnvironmentObject var cart: Cart
    // @Binding var navigateToSelection: Bool
    
    var body: some View {
      
        //ZStack {
           // Color.black
        Button {
            cartIsOpen = true
        } label: {
            HStack(spacing: 0) {
                Image(systemName: "cart.fill")
                    .font(.caption)
                    .foregroundColor(appPurple)
                    .padding(.horizontal, 5)
                    .frame(maxHeight: 40)
                    .padding(.vertical, 5)
                    .background(.white)
                ZStack {
                    Text("$\(cart.totalAmount.toFixedString(2))")
                        .font(.caption)
                        .bold()
                        .foregroundColor(appPurple)
                        .padding(.horizontal, 5)
                        .frame(maxHeight: 40)
                        .padding(.vertical, 5)
                        .background(lightAppPurple)
                    
                }
            }
            .frame(maxHeight: 40)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .fullScreenCover(isPresented: $cartIsOpen) {
            
        } content: {
            CartPage(
                /*navigateToSelection: $navigateToSelection
                 */)
        }

    }
}

/*
struct CartIcon_Previews: PreviewProvider {
    static var previews: some View {
        CartIcon()
    }
}
*/
