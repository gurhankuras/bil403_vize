//
//  AdvertisementCarousel.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import Foundation
import SwiftUI
import Combine

final class AdvertisementCarouselViewModel: ObservableObject {
    @Published var ads: [Advertisement] = []
    @Published var selectedTab: Int = 0
    @Published var loading = false
    @Published var error: String?
    
    var cancellables = Set<AnyCancellable>()
    
    var timer: AnyCancellable?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        //start()
        loadAds()
    }
    
    
    func loadAds() {
        guard let url = Endpoint.ads().url else {
            return
        }
        
        loading = true
        networkService.publisher(for: url, responseType: [Advertisement].self)
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
                    self?.error = "Hata oldu"
                }
                self?.loading = false
                print("COMPLETION: \(completion)")
    
            } receiveValue: {[weak self] ads in
                print(ads)
                self?.ads = ads
            }
            .store(in: &cancellables)
        
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        let (data, response) = output;
        guard let response = response as? HTTPURLResponse,
              response.isGoodStatusCode else {
                  throw URLError(.badServerResponse)
              }
        return data
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
    @StateObject var viewModel: AdvertisementCarouselViewModel = AdvertisementCarouselViewModel(networkService: Dependencies.instance.networkService)
    
    var body: some View {
        if viewModel.loading {
            ProgressView()
        }
        else if (viewModel.error != nil) {
            Rectangle()
        }
        else {
            TabView(selection: $viewModel.selectedTab) {
                ForEach(0..<viewModel.ads.count) { index in
                    AsyncImage(url: URL(string: viewModel.ads[index].image)) { image in
                        image
                            .resizable()
                            .scaledToFill()

                    } placeholder: {
                        ProgressView()
                    }
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
}


struct AdvertisementCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertisementCarouselView()
            .frame(width: .infinity, height: 200)
    }
}
