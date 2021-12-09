//
//  PaymentAddressSelectionPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/9/21.
//

import SwiftUI


struct Address: Identifiable {
    let id: String
    let address: String
}

struct PaymentMethod: Identifiable {
    let id: String
    let name: String
    let firstSixDigits: String
    let lastThreeDigits: String
    
    var maskedCardNumber: String {
        return "\(firstSixDigits)\(String.init(repeating: "*", count: 8))\(lastThreeDigits)"
    }
}

struct PaymentAddressSelectionPage: View {
    let addresses = [
        Address(id: "2ff",
                address: "Hürriyet, Kaya sk. No: 12, 34876 Kartal/İstanbul/İstanbul"),
        Address(id: "43f", address: "sadasdas"),
        Address(id: "5dsf", address: "sdfsdfsd")
    ]
    
    @State var selectedAddressId = "2ff"
    @State var selectedPaymentId = "6fssr"
    
    let paymentMethods = [
        PaymentMethod(id: "4ggh", name: "BKM Express", firstSixDigits: "425245", lastThreeDigits: "324"),
        PaymentMethod(id: "45fs", name: "Finans", firstSixDigits: "732537", lastThreeDigits: "234"),
        PaymentMethod(id: "6fssr", name: "Paraf", firstSixDigits: "945324", lastThreeDigits: "742"),
    ]
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Adresler")
                .font(.title3)
                .bold()
                .padding(.horizontal)
                .padding(.vertical, 10)
            AddressList(selectedId: $selectedAddressId, addresses: addresses)
                .padding(.bottom)
         
            Text("Ödeme Metodları")
                .font(.title3)
                .bold()
                .padding(.horizontal)
                .padding(.vertical, 10)
            PaymentMethodList(selectedId: $selectedPaymentId, methods: paymentMethods)
            
            Spacer()

            NavigationLink {
                ConfirmationReviewPage()
            } label: {
                ButtonUIView(text: "Devam Et")
            }
        }
    }
}



struct PaymentMethodList: View {
    @Binding var selectedId: String
    let methods: [PaymentMethod]
    
    var body: some View {
            VStack(alignment: .leading) {
                ForEach(methods) { method in
                    /*
                    AddressTile(selectedId: $selectedId, address: address)
                     */
                    PaymentMethodTile(selectedId: $selectedId, method: method)
                    Divider()
                }
            }
            .background()
    }
}

struct PaymentMethodTile: View {
    @Binding var selectedId: String
    
    let method: PaymentMethod
    
    var body: some View {
        Button {
            selectedId = method.id
        } label: {
            HStack {
                Image(systemName: selectedId == method.id ? "checkmark.circle": "circle")
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
                Image(systemName: "trash.fill")
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
    @Binding var selectedId: String
    let addresses: [Address]
    
    var body: some View {
            VStack(alignment: .leading) {
                ForEach(addresses) { address in
                    AddressTile(selectedId: $selectedId, address: address)
                    Divider()
                }
            }
            .background()
            //.shadow(radius: 6)
        
    }
}

struct AddressTile: View {
    @Binding var selectedId: String
    
    let address: Address
    
    var body: some View {
        Button {
            selectedId = address.id
        } label: {
            HStack {
                Image(systemName: selectedId == address.id ? "checkmark.circle": "circle")
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
                Image(systemName: "trash.fill")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .tint(appPurple)
    }
}
