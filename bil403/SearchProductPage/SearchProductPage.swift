//
//  SearchProductPage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI

struct SearchProductPage: View {
    @StateObject var vm: SearchViewModel = SearchViewModel(productService: Dependencies.instance.productService)

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchAppbar()
                AppSearchField(placeholder: "Ürün Ara", vm: vm)
                ProductsGrid(products: $vm.products)
                    .padding(.top, 10)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct SearchAppbar: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Arama")
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.vertical, 15)
        .background(appPurple)
    }
}


struct AppSearchField: View {
    let placeholder: String
    @ObservedObject var vm: SearchViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(appPurple)
                .scaleEffect(1.0)
            TextField(
                placeholder,
                text: $vm.query
            )
                .font(.subheadline)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.vertical)
                .padding(.leading, 7)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .background(Color(.systemBackground))
        .cornerRadius(2.0)
        .shadow(radius: 3)
    }
}

struct SearchProductPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchProductPage()
    }
}
