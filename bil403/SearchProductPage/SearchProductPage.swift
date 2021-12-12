//
//  SearchProductPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI

struct SearchProductPage: View {

    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]

    @State var searchText: String = ""
    @StateObject var vm: SearchViewModel = SearchViewModel()
    
    //@FocusState private var searchFieldFocused = true

    init() {

    }
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 0) {
                
                HStack {
                    Spacer()
                    Text("Arama")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical, 15)
                
                .background(appPurple)
                
                HStack(spacing: 0) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(appPurple)
                        .scaleEffect(1.0)
                    TextField(
                        "Ürün Ara",
                        text: $searchText
                    )
                    //.focused($searchFieldFocused)
                        .font(.subheadline)
                        .onSubmit {
                            
                        }
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.vertical)
                        .padding(.leading, 7)
                    
                    Button {
                        vm.loadProducts(query: searchText)
                    } label: {
                        Text("Ara")
                            .padding()
                                                
                    }
                }
                .frame(maxWidth: .infinity)
                
                .padding(.horizontal)
                //.background()
                //.clipShape(RoundedRectangle(cornerRadius: 10))
                //.shadow(radius: 2, x: 0, y: 3)
                .background(Color.white)
                .cornerRadius(2.0)
                .shadow(radius: 3)
               
                ProductsGrid(products: $vm.products)
                    .padding(.top, 10)
                Spacer()
                
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}
}

struct SearchProductPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchProductPage()
    }
}
