//
//  CartPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI

struct CartPage: View {
    
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
                
                // CartPage
                HStack(spacing: 0) {
                    Button {
                        
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
           .background(offWhite)
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}

