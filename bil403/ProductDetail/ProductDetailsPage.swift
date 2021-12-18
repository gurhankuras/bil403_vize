//
//  ProductDetails.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct ProductDetailsPage: View {
    @Binding var product: Product?
    @State var countInCart: Int = 0
    // The environment is passed down when the body is called, so it doesn't yet exist during the initialization phase of the View struct. (use onAppear)
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        if product == nil {
            EmptyView()
        }
        else {
            ZStack {
                Color(red: 240/255, green: 241/255, blue: 242/255).ignoresSafeArea()
                VStack {
                    ProductDetailsToolbar()
                    ProductDetails(product!)
                    Spacer()
                    
                    if countInCart == 0 {
                        AddCartLongButton(countInCart: $countInCart, product: product!)
                    }
                    else {
                        IncrementDecrementProductButtonGroup(countInCart: $countInCart, product: product!)
                    }
                    
                }
            }
            .onAppear {
                guard let id = product?.id else {
                    countInCart = 0
                    return
                }
                countInCart = self.cart.items[id]?.count ?? 0
            }
        }
        
    }

}


struct ProductDetailsToolbar: View {
    @Environment(\.presentationMode) var presentationMode;
    
    var body: some View {
        HStack {
            Button {
                print("TIKLADIM")
                print(presentationMode.wrappedValue)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .tint(.white)
                    .font(.headline)
            }
            Spacer()
            Text("Ürün Detayı")
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(appPurple)
    }
}

struct ProductDetails: View {
    let product: Product
    init(_ product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ProductThumbnail(url: product.image)
                .frame(width: UIScreen.main.bounds.width * 0.35,
                       height: UIScreen.main.bounds.width * 0.35)
                .scaledToFit()
                .padding(.bottom, 10)
            
            Text("$\(product.cost.toFixedString(2))")
                .bold()
                .font(.title)
                .foregroundColor(appPurple)
                .padding(.bottom, 1)
            
            Text("\(product.name)")
                .font(.title2)
                .foregroundColor(.black)
                .padding(.bottom, 5)
            Text("\(product.additionalInfo)")
                .foregroundColor(Color(UIColor(.secondary)))
                .font(.body)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}

struct AddCartLongButton: View {
    @Binding var countInCart: Int
    @EnvironmentObject var cart: Cart
    let product: Product
    
    var body: some View {
        Button {
            self.countInCart = countInCart + 1
            cart.add(product: product)
        } label: {
            ButtonUIView(text: "Sepete Ekle")
        }
    }
}

struct IncrementDecrementProductButtonGroup: View {
    @Binding var countInCart: Int
    @EnvironmentObject var cart: Cart
    let product: Product

    var body: some View {
        HStack(spacing: 0) {
            Button {
                countInCart = countInCart - 1
                
                // it never happens, if happens there is a bug or external modification
                try? cart.remove(product: product)
            } label: {
                Image(systemName: "minus")
                    .frame(maxHeight: .infinity)
                    .padding(16)
            }
            .opacity(countInCart <= 0 ? 0.5 : 1)
            .disabled(countInCart <= 0)
            
            Text("\(countInCart)")
                .foregroundColor(.white)
                .bold()
                .frame(maxHeight: .infinity, alignment: .center)
                .frame(minWidth: 40)
                .padding(.vertical)
                .padding(.horizontal, 10)
                .background(appPurple)
            
            Button {
                countInCart = countInCart + 1
                cart.add(product: product)
            } label: {
                Image(systemName: "plus")
                    .frame(maxHeight: .infinity )
                    .padding(16)
                    //.shadow(radius: 5)
                    //.border(.gray)
            }
        }
        .foregroundColor(appPurple)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(maxHeight: 50)
        .background(Color.white)
        .cornerRadius(15.0)
        .shadow(color: .black.opacity(0.1), radius: 10)
    }
}

struct ButtonUIView: View {
    let text: String
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(appPurple)
            .padding()
    }
}
