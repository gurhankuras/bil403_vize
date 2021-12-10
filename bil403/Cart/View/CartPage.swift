//
//  CartPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var cart: Cart

    var body: some View {
            VStack {
                CartPageNavBar()
                ScrollView {
                    VStack {
                        // TODO: Find another way
                        ForEach(cart.toList()) { cartItem in
                            CartProductView(cartItem: cartItem)
                        }
                    }
                    .background(.white)
                }
                CartPageBottomButton(totalAmount: $cart.totalAmount)
            }
           .background(offWhite)
    }
}

struct CartPageBottomButton: View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    @EnvironmentObject var cart: Cart
    @Binding var totalAmount: Double
    @Environment(\.presentationMode) var presentationMode;

    var body: some View {
        HStack(spacing: 0) {
            Button {
                presentationMode.wrappedValue.dismiss()
                navigationHelper.open(route: NavigationRoutes.addressPaymentSelection.rawValue)
            } label: {
                Text("Devam")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(appPurple.opacity(cart.isEmpty ? 0.5 : 1))
            }
            .disabled(cart.isEmpty)

            Text("$\(totalAmount.toFixedString(2))")
                .foregroundColor(appPurple)
                .bold()
                .padding()
                //.frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
        .padding(10)
        .background(offWhite)
    }
}

/*
struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}
*/
