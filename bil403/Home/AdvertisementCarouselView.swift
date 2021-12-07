//
//  AdvertisementCarousel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import Foundation
import SwiftUI

struct AdvertisementCarouselView: View {
    var body: some View {
        TabView {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.black)
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.black)
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.black)
        }
        .tabViewStyle(PageTabViewStyle())
    }
}


struct AdvertisementCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertisementCarouselView()
            .frame(width: .infinity, height: 200)
    }
}
