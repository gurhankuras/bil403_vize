//
//  ConfirmationReviewPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/9/21.
//

import SwiftUI

struct ConfirmationReviewPage: View {
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var navigationHelper: NavigationHelper
    @EnvironmentObject var cart: Cart
    @StateObject var vm: OrderConfirmationViewModel = OrderConfirmationViewModel(networkService: Dependencies.instance.networkService)
    
    let address: Address
    let paymentMethod: PaymentMethod
    
  
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(cart.toList()) { cartItem in
                        CartProductView(cartItem: cartItem, immutable: true)
                    }
                }
                AddressTile2(address: address)
                PaymentMethodTile2(method: paymentMethod)
                Button {
                    vm.order(order: cart.toOrder(addressId: address.id, paymentMethod: paymentMethod.id))
                } label: {
                    ButtonUIView(text: "Onayla".uppercased())
                }

            }
            .navigationTitle("Doğrulama")
            /*
            if vm.loading {
                AppAlert()
            }
             */
        }
        .alert(vm.operationResultMessage ?? "", isPresented: $vm.showMessage) {
            Button {
                dismiss()
                dismiss()
            } label: {
                Text("Tamam")
            }

                
        }
        .onAppear {
            vm.setCart(cart: cart)
        }
        .onDisappear {
            vm.invalidate()
        }
    }
}

struct ConfirmationReviewPage_Previews: PreviewProvider {
    
    static let address =
        Address(id: 5,
                address: "Hürriyet, Kaya sk. No: 12, 34876 Kartal/İstanbul/İstanbul")
     static let paymentMethod =
            PaymentMethod(id: 1, name: "BKM Express", lastThreeDigits: "324")
    
    static var previews: some View {
        ConfirmationReviewPage(address: address, paymentMethod: paymentMethod)
    }
}

struct PaymentMethodTile2: View {
    
    let method: PaymentMethod
    
    var body: some View {
        HStack {
            Image(systemName: "creditcard.fill")
                .padding(.horizontal, 5)
            Divider()
                .frame(height: 50)
            VStack(alignment: .leading, spacing: 3) {
                Text(method.name)
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(method.maskedCardNumber)
                    .font(.caption)
                    .foregroundColor(
                        Color(.systemGray))
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}


struct AddressTile2: View {
    let address: Address
    
    var body: some View {
        HStack {
            Image(systemName: "house.fill")
                .padding(.horizontal, 5)
            Divider()
                .frame(height: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Ev")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.black)
                    
                Text(address.address)
                    .font(.footnote)
                    .foregroundColor(
                        Color(.systemGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
         
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
