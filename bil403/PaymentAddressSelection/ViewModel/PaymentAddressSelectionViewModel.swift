//
//  PaymentAddressSelectionViewModel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation

final class PaymentAddressSelectionViewModel: ObservableObject {
    let addresses = [
        Address(id: 2,
                address: "Hürriyet, Kaya sk. No: 12, 34876 Kartal/İstanbul/İstanbul"),
        Address(id: 3, address: "sadasdas"),
        Address(id: 4, address: "sdfsdfsd")
    ]
    
    @Published var selectedAddress: Address
    @Published var selectedMethod: PaymentMethod
    
    let paymentMethods = [
        PaymentMethod(id: 1, name: "BKM Express", lastThreeDigits: "324"),
        PaymentMethod(id: 2, name: "Finans", lastThreeDigits: "234"),
        PaymentMethod(id: 3, name: "Paraf", lastThreeDigits: "742"),
    ]
    
    init() {
        _selectedAddress = Published(initialValue: addresses[0])
        _selectedMethod = Published(initialValue: paymentMethods[0])
    }
}
