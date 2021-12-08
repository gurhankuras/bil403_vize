//
//  ProductDetails.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import SwiftUI

struct ProductDetailsPage: View {
    let product: Product
    @State var countInCart: Int = 1
    
    var body: some View {
        ZStack {
            Color(red: 240/255, green: 241/255, blue: 242/255).ignoresSafeArea()
            VStack {
                ProductDetailsToolbar()
                ProductDetails(product)
                Spacer()
                
                if countInCart == 0 {
                    AddCartLongButton(countInCart: $countInCart)
                }
                else {
                    IncrementDecrementProductButtonGroup(countInCart: $countInCart)
                }

            }
        }
        
    }
}

struct ProductDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsPage(product: mockProduct)
    }
}

struct ProductDetailsToolbar: View {
    @Environment(\.presentationMode) var presentationMode;
    
    var body: some View {
        HStack {
            Button {
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
            Image("apple")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.4,
                       height: UIScreen.main.bounds.width * 0.4)
                .scaledToFit()
            
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

    var body: some View {
        Button {
            self.countInCart = countInCart + 1
        } label: {
            Text("Sepete Ekle")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(appPurple)
                .padding()
            
            //.padding()
        }
    }
}

struct IncrementDecrementProductButtonGroup: View {
    @Binding var countInCart: Int

    var body: some View {
        HStack(spacing: 0) {
            Button {
                countInCart = countInCart - 1
            } label: {
                Image(systemName: "minus")
                    .frame(maxHeight: .infinity)
                    .padding(16)
                    //.shadow(radius: 5)
                
                    //.border(.gray)
            }
            
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
