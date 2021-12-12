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
    @Published var ads: [Advertisement] = []
    @Published var selectedTab: Int = 0
    @Published var loading = false
    
    var cancellables = Set<AnyCancellable>()
    
    var timer: AnyCancellable?
    
    init() {
        start()
        loadAds()
    }
    
    
    func loadAds() {
        guard let request = makeGetRequest(urlStr: ApiURL.ads()) else {
            return
        }
        
        loading = true
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: [Advertisement].self, decoder: JSONDecoder())
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                   
                    print("finished")
                    
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
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
    

    private func makeGetRequest(urlStr: String) -> URLRequest? {
        guard let url = URL(string: urlStr) else {
            print("Error: cannot create URL")
            return nil
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the request
        return request
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
        if viewModel.loading {
            ProgressView()
        }
        else {
            TabView(selection: $viewModel.selectedTab) {
                ForEach(0..<viewModel.ads.count) { index in
                    AsyncImage(url: URL(string: viewModel.ads[index].image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            //.clipShape(RoundedRectangle(cornerRadius: 5))
                            //.shadow(radius: 2)
                    } placeholder: {
                        ProgressView()
                    }
                    .tag(index)
                    /*
                     Rectangle()
                     .foregroundColor(viewModel.ads[index])
                     .tag(index)
                     */
                    
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
