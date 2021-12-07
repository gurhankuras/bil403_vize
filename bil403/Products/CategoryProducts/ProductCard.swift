//
//  ProductCard.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI


struct ProductCard: View {
    let url = "https://cdn.getir.com/product/5cac8e6603c5fd0001497b73_tr_1638777832255.jpeg"
    var body: some View {
        
        VStack(alignment: .leading) {
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
            ZStack(alignment: .topTrailing) {
                Image("apple")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(radius: 2)
                Button {
                    
                    
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                        .overlay {
                            Image(systemName: "plus")
                                .tint(.purple)
                        }
                        .frame(width: 25, height: 25)
                        .offset(x: 5, y: -5)
                }

                    
                /*
                        Rectangle()
                            .offset(x: 100, y: 10)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.yellow)
                 */
                    
            }
            
            Text("$7,45")
                .bold()
                .font(.subheadline)
                .foregroundColor(.purple)
                .padding(.bottom, 1)
                
            Text("Elma")
                .font(.caption)
            Text("1 kg")
                .foregroundColor(Color(UIColor(.secondary)))
                .font(.caption)
        }
        .padding()
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard()
            .previewLayout(.sizeThatFits)
    }
}
