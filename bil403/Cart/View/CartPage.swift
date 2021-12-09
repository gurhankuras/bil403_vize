//
//  CartPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI

struct CartPage: View {
   // @Binding var navigateToSelection: Bool
    var body: some View {
            VStack {
                CartPageNavBar()
                ScrollView {
                    VStack {
                        ForEach(0..<6) { index in
                            CartProductView()
                        }
                    }
                    .background(.white)
                }
                
                //NavigationLink {
                    //PaymentAddressSelectionPage()
                //} label: {
                CartPageBottomButton(
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

            Text("$5.65")
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
