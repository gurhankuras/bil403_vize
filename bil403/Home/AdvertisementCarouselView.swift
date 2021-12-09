//
//  AdvertisementCarousel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import Foundation
import SwiftUI
import Combine

class AdvertisementCarouselViewModel: ObservableObject {
    @Published var ads: [Color] = [.purple, .mint, .green]
    @Published var selectedTab: Int = 0
    var timer: AnyCancellable?
    
    init() {
      start()
    }
    
    func resumeIfPaused() {
        guard timer == nil else { return }
        start()
    }

    private func start() {
        timer = Timer.publish(every: 3.0, on: .main, in: .common)
             .autoconnect()
             .sink { [weak self] _ in
                 guard let self = self else { return }
                 print("girdi")
                 self.selectedTab = self.selectedTab == self.ads.count - 1 ? 0 : self.selectedTab + 1
             }
    }
    
    
    func pause() {
        timer?.cancel()
        timer = nil
    }
}

struct AdvertisementCarouselView: View {
    @StateObject var viewModel: AdvertisementCarouselViewModel = AdvertisementCarouselViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(0..<viewModel.ads.count) { index in
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(viewModel.ads[index])
                    .tag(index)
            }
        }
        .onAppear(perform: {
            viewModel.resumeIfPaused()
        })
        .animation(.easeIn(duration: 1.0))
        .tabViewStyle(PageTabViewStyle())
        .onDisappear {
            viewModel.pause()
        }
    }
}


struct AdvertisementCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertisementCarouselView()
            .frame(width: .infinity, height: 200)
    }
}
