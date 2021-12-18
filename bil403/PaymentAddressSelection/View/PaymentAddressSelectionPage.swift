//
//  PaymentAddressSelectionPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/9/21.
//

import SwiftUI

struct PaymentAddressSelectionPage: View {
    @StateObject var vm: PaymentAddressSelectionViewModel = PaymentAddressSelectionViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Adresler")
                .font(.title3)
                .bold()
                .padding(.horizontal)
                .padding(.vertical, 10)
            AddressList(selected: $vm.selectedAddress, addresses: vm.addresses)
                .padding(.bottom)
         
            Text("Ödeme Metodları")
                .font(.title3)
                .bold()
                .padding(.horizontal)
                .padding(.vertical, 10)
            PaymentMethodList(selected: $vm.selectedMethod, methods: vm.paymentMethods)
            
            Spacer()

            NavigationLink {
                ConfirmationReviewPage(address: vm.selectedAddress, paymentMethod: vm.selectedMethod)
            } label: {
                ButtonUIView(text: "Devam Et")
            }
        }
    }
}



struct PaymentMethodList: View {
    @Binding var selected: PaymentMethod
    let methods: [PaymentMethod]
    
    var body: some View {
            VStack(alignment: .leading) {
                ForEach(methods) { method in
                    PaymentMethodTile(selected: $selected, method: method)
                    Divider()
                }
            }
            .background()
    }
}

struct PaymentMethodTile: View {
    @Binding var selected: PaymentMethod
    
    let method: PaymentMethod
    
    var body: some View {
        Button {
            selected = method
        } label: {
            HStack {
                Image(systemName: selected.id == method.id ? "checkmark.circle": "circle")
                Image(systemName: "creditcard.fill")
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
                // Image(systemName: "trash.fill")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .tint(appPurple)
    }
}


struct PaymentAddressSelectionPage_Previews: PreviewProvider {
    static var previews: some View {
        PaymentAddressSelectionPage()
    }
}

struct AddressList: View {
    @Binding var selected: Address
    let addresses: [Address]
    
    var body: some View {
            VStack(alignment: .leading) {
                ForEach(addresses) { address in
                    AddressTile(selected: $selected, address: address)
                    Divider()
                }
            }
            .background()
            //.shadow(radius: 6)
        
    }
}

struct AddressTile: View {
    @Binding var selected: Address
    
    let address: Address
    
    var body: some View {
        Button {
            selected = address
        } label: {
            HStack {
                Image(systemName: selected.id == address.id ? "checkmark.circle": "circle")
                Image(systemName: "house.fill")
                Divider()
                    .frame(height: 30)
                Text("Ev")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(address.address)
                    .font(.footnote)
                    .foregroundColor(
                        Color(.systemGray))
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Spacer()
              //  Image(systemName: "trash.fill")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .tint(appPurple)
    }
}
