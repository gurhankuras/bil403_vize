//
//  MyPaymentMethodsPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct MyPaymentMethodsPage: View {
    @StateObject var vm: MyPaymentMethodsViewModel = MyPaymentMethodsViewModel(networkService: Dependencies.instance.networkService)
    var body: some View {
        
        VStack(alignment: .leading) {
            ForEach(vm.paymentMethods) { method in
                HStack {
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
            Spacer()
        }
        .background()
        .padding(.top)
        
       
    }
}

struct MyPaymentMethodsPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPaymentMethodsPage()
    }
}
