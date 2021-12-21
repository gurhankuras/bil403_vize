//
//  MyAddressesPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct MyAddressesPage: View {
    @StateObject var vm: MyAddressesViewModel = MyAddressesViewModel(networkService: Dependencies.instance.networkService)
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(vm.addresses) { address in
                HStack {
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
                Divider()
            }
            Spacer()
        }
        .background()
        .padding(.top)
        .onAppear {
            print("\(Self.self) appearing....")
        }
        .onDisappear {
            //vm.invalidate()
            print("\(Self.self) dissappering....")
        }
    }
}

struct MyAddressesPage_Previews: PreviewProvider {
    static var previews: some View {
        MyAddressesPage()
    }
}
