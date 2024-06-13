//
//  BarOwnerBarFind.swift
//  Bar App
//
//  Created by Raj on 6/3/24.
//

import SwiftUI

enum Destination: Hashable {
    case barOwnerMenu(store: Stores)
}

struct BarOwnerBarFind: View {
    @ObservedObject var storeData: StoresData
    @State var user: String = ""
    @State var password: String = ""
    @State private var showAlert = false
    @State private var currentStore: Stores?
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Enter your username and password below: ")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding()
                TextField("Username: ", text: $user)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Password: ", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                //add button to check if username and password are valid
                Button(action: {
                    if(storeData.checkCredentials(username: user, password: password)){
                        //go to barOwnerMenu view
                        currentStore = storeData.getStore(username: user, password: password)
                        if let store = currentStore {
                            path.append(Destination.barOwnerMenu(store: store))
                        }
                    }
                    else{
                        //make pop up text that says username or password is wrong
                        showAlert = true
                    }
                }){
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showAlert){
                    Alert(title: Text("Error"), message: Text("Username or password is incorrect"), dismissButton: .default(Text("OK")))
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .barOwnerMenu(let store):
                    BarOwnerMenu(store: store)
                }
            }
        }
    }
}

#Preview {
    BarOwnerBarFind(storeData: StoresData())
}
