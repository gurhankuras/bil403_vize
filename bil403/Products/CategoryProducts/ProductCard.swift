//
//  ProductCard.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI


struct ProductCard: View {
    let product: Product
    let url = "https://cdn.getir.com/product/5cac8e6603c5fd0001497b73_tr_1638777832255.jpeg"
    var body: some View {
        
        VStack(alignment: .leading) {
           
            ZStack(alignment: .topTrailing) {
                ProductThumbnail()
                    .frame(width: 100, height: 100)
                AddToCartButton()
            }
            
            
            Text("$\(product.cost.toFixedString(2))")
                .bold()
                .font(.subheadline)
                .foregroundColor(appPurple)
                .padding(.bottom, 1)
                
            Text("\(product.name)")
                .font(.caption)
                .foregroundColor(.black)
            Text("\(product.additionalInfo)")
                .foregroundColor(Color(UIColor(.secondary)))
                .font(.caption)
        }
        .padding()
    }
}

struct ProductThumbnail: View {
    var body: some View {
        
        /*
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(radius: 2)
        } placeholder: {
            ProgressView()
        }
         */
        
        Image("apple")
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 1)
            //.frame(width: 100, height: 100)
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: mockProduct)
            .previewLayout(.sizeThatFits)
    }
}

struct AddToCartButton: View {
    var body: some View {
        Button {
            
            
        } label: {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
                .shadow(radius: 3)
                .overlay {
                    Image(systemName: "plus")
                        .tint(appPurple)
                }
                .frame(width: 25, height: 25)
                .offset(x: 5, y: -5)
        }
    }
}
