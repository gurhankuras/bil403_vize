//
//  UserProfilePage.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/11/21.
//

import SwiftUI

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String
    let phoneNumber: String
}

struct UserProfilePage: View {
    
    @StateObject var vm: ProfileViewModel = ProfileViewModel(networkService: Dependencies.instance.networkService)
    
    init() {
    
    }
    
    
     let ab = ["asdsa", "asdasd", "sadasd"]
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0) {
                AppNavBar(title: "Profil")
                ShadowedVStack {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 55, height: 55, alignment: .center)
                            .padding(5)
                            .foregroundColor(appPurple)
                            .background()
                            .cornerRadius(5)
                            .shadow(radius: 1)
                            .padding(.trailing, 8)
                        Text(vm.user?.name ?? "-")
                            .bold()
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    Divider().padding(.horizontal)
                    UserInfoRow(icon: "mail.fill",
                                text: Text(vm.user?.email ?? "-")
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray))
                                    .fontWeight(.semibold)
                    
                    )
                        .padding(5)
                    Divider().padding(.horizontal)
                    UserInfoRow(icon: "candybarphone",
                                text: Text(vm.user?.phoneNumber ?? "-")
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray))
                                    .fontWeight(.semibold))
                        .padding(5)
                }
                
                ShadowedVStack {
                    NavigationLink {
                        MyAddressesPage()
                    } label: {
                        UserInfoRow(icon: "location.fill", text: Text("Adreslerim")
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                        .fontWeight(.semibold)
                        )
                            .padding(5)
                    }
                    Divider().padding(.horizontal)
                    NavigationLink {
                        MyPaymentMethodsPage()
                    } label: {
                        UserInfoRow(icon: "creditcard.fill", text: Text("Ödeme Yöntemlerim")
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                        .fontWeight(.semibold)
                        )
                            .padding(5)
                    }
                    Divider().padding(.horizontal)
                }
                .tint(appPurple)
                .padding(.vertical)
                
                
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ShadowedVStack<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .padding(.vertical, 10)
        .background()
        .cornerRadius(5)
        .shadow(radius: 5)
        .padding(.top)
    }
}

struct UserProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        UserProfilePage()
    }
}

struct UserInfoRow: View {
    let icon: String
    let text: Text
    
    var body: some View {
        HStack {
            Label {
                text
            } icon: {
                Image(systemName: icon)
                    .frame(width: 20, height: 20, alignment: .center)
                    .padding(.trailing, 5)
            }
            Spacer()
        }
        .padding(.horizontal)
        
    }
}
