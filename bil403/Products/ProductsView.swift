//
//  ProductsView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct ProductsView: View {
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
   let categories = [
       "Meyve & Sebze",
       "Kişisel Bakım",
       "Atıştırmalık",
       "Temel Gıda"
   ]
    
    @State var currentIndex: Int = 0
    var body: some View {
        VStack {
            
                    CategoriesSelection(categories: categories, selectedIndex: $currentIndex)
                
            //Spacer()
            TabView(selection: $currentIndex.animation()) {
                ForEach(0..<categories.count, id: \.self) { index in
                    CategoryProductsView()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
        }
        .toolbar { // <2>
            ToolbarItem(placement: .principal) { // <3>
                Text("Ürünler")
                    .bold()
                    .foregroundColor(.white)
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
    var selected: Binding<Int>
    
    var body: some View {
        Button {
            withAnimation {
                self.selected.wrappedValue = index
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
                        .foregroundColor(selected.wrappedValue == index ? .yellow : .purple)
                
                    
            }
            .padding(.horizontal, 10)
        }

        
        
        
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
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
        .background(.purple)
    }
}
