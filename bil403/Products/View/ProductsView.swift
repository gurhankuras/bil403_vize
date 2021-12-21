//
//  ProductsView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct ProductsView: View {
    let category: Category
    let categories: [Category]
    @State var currentId: ProdCategory
    @EnvironmentObject var navigationHelper: NavigationHelper
    let productService: ProductServiceProtocol = Dependencies.instance.productService
    
    // @State private var isShowingSelectPage = false
    
    init(category: Category, categories: [Category]) {
        self.category = category
        self.categories = categories
        _currentId = State(initialValue: category.id)
        // self.currentIndex = indexP
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        print("\(Self.self) initiliazed...")
    }
    
  
    
    var body: some View {
        VStack {
            
            CategoriesSelection(categories: categories, selectedId: $currentId)
            TabView(selection: $currentId.animation()) {
                ForEach(categories) { category in
                    LazyView {
                        CategoryProductsView(category: category, productService: productService)
                    }
                        .tag(category.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
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
                CartIcon()
            }
        }
        }

}

struct CategoryTab: View {
    let category: Category
    @Binding var selected: ProdCategory
    
    var body: some View {
        Button {
            withAnimation {
                self.selected = category.id
            }
            print("Selected")
        } label: {
            VStack(spacing: 0) {
                Text(category.title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.bottom, 6)
                
                    Rectangle()
                        .frame(width: .infinity, height: 3)
                        .foregroundColor(selected == category.id ? .yellow : appPurple)
                
                    
            }
            .padding(.horizontal, 10)
        }

        
        
        
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(category: Category(id: ProdCategory.atistirmalik, title: "Meyve & Sebze", image: ""), categories: [])
    }
}

struct CategoriesSelection: View {
    let categories: [Category]
    
    var selectedId: Binding<ProdCategory>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories) { cat in
                    CategoryTab(category: cat, selected: selectedId)
                }
            }
        }
        .padding(.horizontal)
        .background(appPurple)
    }
}
