//
//  SplashView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/20/21.
//

/// https://stackoverflow.com/questions/57730074/transition-animation-not-working-in-swiftui

import SwiftUI

struct SplashView: View {
    
    let size: Double = 100
    @State var hasScaled: Bool = false
    @State var navigateToNextPage: Bool = false
     
    var body: some View {
    
      ZStack {
            ContentView()
                .zIndex(0)
    
            if !navigateToNextPage {
                ZStack {
                    Image("splashBackground")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                        .overlay(.white.opacity(0.9))
                        .ignoresSafeArea()
                        .zIndex(0)
                    
                    Circle()
                        .fill(appPurple)
                        .frame(width: size, height: size)
                        .scaleEffect(hasScaled ? 1 : 0)
                        
                        .zIndex(1)
                     
                }
                .environment(\.colorScheme, .light)
                .transition(AnyTransition.opacity.animation(.easeIn))
                .zIndex(1)
                
            }
        }
        .onAppear {
            withAnimation {
                hasScaled = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                navigateToNextPage = true
            }
        }
        
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
