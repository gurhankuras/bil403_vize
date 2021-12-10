//
//  CartProductView.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import SwiftUI


struct CartProductView: View {
    @State var count: Int
    let cartItem: CartItem
    
    init(cartItem: CartItem) {
        self.cartItem = cartItem
        _count = State(initialValue: cartItem.count)
    }
    
    var body: some View {
        HStack {
            ProductThumbnail()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text(cartItem.product.name)
                    .font(.caption)
                    .foregroundColor(.black)
                Text(cartItem.product.additionalInfo)
                    .foregroundColor(Color(UIColor(.secondary)))
                    .font(.footnote)
                    .padding(.bottom, 5)
                Text("$\(cartItem.product.cost.toFixedString(2))")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(appPurple)
                    .padding(.bottom, 1)
                
            }
            .padding(.leading)
            Spacer()
            IncrementDecrementProductButtonGroup(countInCart: $count, product: cartItem.product)
                .scaleEffect(0.7)
            
        }
        .padding()
    }
}


struct CartProductView_Previews: PreviewProvider {
    static let cartItem = CartItem(product: mockProduct, count: 2)
    
    static var previews: some View {
        CartProductView(cartItem: Self.cartItem)
            .previewLayout(.sizeThatFits)
    }
}
