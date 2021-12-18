//
//  CategoriesView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI


struct Category: Identifiable {
    let id: ProdCategory
    let title: String
    let image: String
}



struct CategoriesGrid: View {
    let data = [
        Category(id: ProdCategory.meyveSebze, title: "Meyve & Sebze", image: "https://cdn.getir.com/cat/5928113e616cab00041ec6de_1619242870968_1619242871055.jpeg"),
        Category(id: ProdCategory.kisiselBakim, title: "Kişisel Bakım", image: "https://cdn.getir.com/cat/551430043427d5010a3a5c5c_1619242651249_1619242651335.jpeg"),
        Category(id: ProdCategory.atistirmalik, title: "Temel Gıda", image: "https://cdn.getir.com/cat/56dfcfba86004203000a870d_1619242834654_1619242834734.jpeg"),
        Category(id: ProdCategory.temelGida, title: "Atıştırmalık", image: "https://cdn.getir.com/cat/56dfe03cf82055030022cdc0_1619242841966_1619242842053.jpeg"),
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0..<data.count) { item in
                CategoryCard(category: data[item], categories: data)
            }
        }
        .padding(.horizontal)
    }
}


struct CategoriesGrid_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesGrid()
    }
}
