//
//  CategoriesView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI


struct CategoriesGrid: View {
    let data = (1...10).map { "Item \($0)" }

        let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(data, id: \.self) { item in
                CategoryCard()
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
