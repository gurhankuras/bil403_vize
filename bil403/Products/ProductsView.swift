//
//  ProductsView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct ProductsView: View {
    let index: Int
    @State var currentIndex: Int
    @State private var isShowingSelectPage = false
    
    init(index: Int) {
        self.index = index
        currentIndex = index
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
   let categories = [
       "Meyve & Sebze",
       "Kişisel Bakım",
       "Atıştırmalık",
       "Temel Gıda"
   ]
    
    var body: some View {
        VStack {
            CategoriesSelection(categories: categories, selectedIndex: $currentIndex)
            TabView(selection: $currentIndex.animation()) {
                ForEach(0..<categories.count, id: \.self) { index in
                    CategoryProductsView()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            NavigationLink(destination: PaymentAddressSelectionPage(), isActive: $isShowingSelectPage) { EmptyView() }
            
        }
        .toolbar { // <2>
            ToolbarItem(placement: .principal) { // <3>
                Text("Ürünler")
                    .bold()
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                CartIcon(navigateToSelection: $isShowingSelectPage)
            }
        }
    }
    
    private func handleGesture(translation: DragGesture.Value) {
        print("HAHAHAHAHAH")
    }
}

struct CategoryTab: View {
    let name: String
    let index: Int
    @Binding var selected: Int
    
    var body: some View {
        Button {
            withAnimation {
                self.selected = index
            }
            print("Selected")
        } label: {
            VStack(spacing: 0) {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.bottom, 6)
                
                    Rectangle()
                        .frame(width: .infinity, height: 3)
                        .foregroundColor(selected == index ? .yellow : appPurple)
                
                    
            }
            .padding(.horizontal, 10)
        }

        
        
        
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(index: 1)
    }
}

struct CategoriesSelection: View {
    let categories: [String]
    
    var selectedIndex: Binding<Int>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<categories.count, id: \.self) { index in
                    CategoryTab(name: categories[index], index: index, selected: selectedIndex)
                }
            }
        }
        .padding(.horizontal)
        .background(appPurple)
    }
}
