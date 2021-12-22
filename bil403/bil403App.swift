//
//  bil403App.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

@main
struct bil403App: App {
   @UIApplicationDelegateAdaptor var delegate: FSAppDelegate

    var body: some Scene {
        WindowGroup {
            SplashView()
                // added for closing keyboard when clicked outside of field
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                .environmentObject(NavigationHelper())
        }
    }
}



class FSAppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    setupDependencies()

    return true
  }
}


func setupDependencies() {
    let session = URLSession.shared
    let networkService = NetworkService(session: session)
    let productService = LazyProductService(networkService: networkService)
    
    Dependencies.initiliase(networkService: networkService, productService: productService)
}
