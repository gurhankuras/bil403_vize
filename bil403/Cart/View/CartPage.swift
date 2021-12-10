//
//  CartPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var cart: Cart
   // @Binding var navigateToSelection: Bool
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
                
                //NavigationLink {
                    //PaymentAddressSelectionPage()
                //} label: {
                CartPageBottomButton(totalAmount: $cart.totalAmount
                    /*navigateToSelection: $navigateToSelection
                     */
                     )
                //}
                
                // CartPage
                
                
            }
           .background(offWhite)
    }
}

struct CartPageBottomButton: View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var totalAmount: Double
    // @Binding var navigateToSelection: Bool
    @Environment(\.presentationMode) var presentationMode;

    // @Environment(\.rootPresentationMode) var rootPresentationMode;
    var body: some View {
        HStack(spacing: 0) {
            Button {
                presentationMode.wrappedValue.dismiss()
                // navigateToSelection = true
                navigationHelper.open(route: NavigationRoutes.addressPaymentSelection.rawValue)
               // rootPresentationMode.wrappedValue.open()
            } label: {
                Text("Devam")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(appPurple)
            }

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
