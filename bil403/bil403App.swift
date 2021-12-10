//
//  bil403App.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

@main
struct bil403App: App {
   // @UIApplicationDelegateAdaptor var delegate: FSAppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NavigationHelper())
        }
    }
}

/*

class FSAppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    // ...
    return true
  }
}
*/
