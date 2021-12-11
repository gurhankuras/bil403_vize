//
//  AppNavBar.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/11/21.
//

import SwiftUI

struct AppNavBar: View {
    let title: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.vertical, 15)
        .background(appPurple)
    }
}

struct AppNavBar_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBar(title: "Profil")
    }
}
