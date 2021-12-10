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
    @EnvironmentObject var navigationHelper: NavigationHelper
    let productService: ProductServiceProtocol = MockProductService()
    
    // @State private var isShowingSelectPage = false
    
    init(indexP: Int) {
        self.index = indexP
        _currentIndex = State(initialValue: self.index)
        // self.currentIndex = indexP
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        // print(" INIT \(self.isShowingSelectPage)")
    }
    
   let categories = [
        ProductCategory(name: "Meyve & Sebze", id: ProductCategories.meyveSebze.rawValue),
        ProductCategory(name: "Kişisel Bakım", id: ProductCategories.kisiselBakim.rawValue),
        ProductCategory(name: "Atıştırmalık", id: ProductCategories.atistirmalik.rawValue),
        ProductCategory(name: "Temel Gıda", id: ProductCategories.temelGida.rawValue)
   ]
    
    var body: some View {
        VStack {
            CategoriesSelection(categories: categories, selectedIndex: $currentIndex)
            TabView(selection: $currentIndex.animation()) {
                ForEach(0..<categories.count, id: \.self) { index in
                    CategoryProductsView(category: categories[index], productService: productService)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            // .environmentObject(productService)
            
            //.environmentObject(<#T##object: ObservableObject##ObservableObject#>)
            /*
            NavigationLink(destination: PaymentAddressSelectionPage(), isActive: $isShowingSelectPage) { EmptyView() }
            .isDetailLink(false)
             */
            
            NavigationLink(tag: NavigationRoutes.addressPaymentSelection.rawValue, selection: $navigationHelper.route) {
                PaymentAddressSelectionPage()
            } label: {
                EmptyView()
            }
            

            
        }
        .onDisappear(perform: {
            print("NOLUYOR LAAAN")
        })
        .toolbar { // <2>
            ToolbarItem(placement: .principal) { // <3>
                Text("Ürünler")
                    .bold()
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                CartIcon(
                    /*navigateToSelection: $isShowingSelectPage
                     */)
            }
        }
        //.environment(\.rootPresentationMode, self.$isShowingSelectPage)
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
        ProductsView(indexP: 1)
    }
}

struct CategoriesSelection: View {
    let categories: [ProductCategory]
    
    var selectedIndex: Binding<Int>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<categories.count, id: \.self) { index in
                    CategoryTab(name: categories[index].name, index: index, selected: selectedIndex)
                }
            }
        }
        .padding(.horizontal)
        .background(appPurple)
    }
}
