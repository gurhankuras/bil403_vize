//
//  AppAlert.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/9/21.
//

import SwiftUI

struct AppAlert: View {
    var body: some View {
        VStack {
            GifImage("spinner")
                .frame(width: 100, height: 100)
                .background(.clear)
                
            Text("Siparişiniz işleniyor...")
                .foregroundColor(Color(hex: 0x333333, alpha: 1))
                .font(.subheadline)
                
        }
        .frame(width: 200, height: 200)
        .background(.white)
        .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.purple.opacity(0.3), lineWidth: 2)
                        .shadow(radius: 5)
                )
        
    }
}

struct AppAlert_Previews: PreviewProvider {
    static var previews: some View {
        AppAlert()
            .preferredColorScheme(.light)
    }
}
