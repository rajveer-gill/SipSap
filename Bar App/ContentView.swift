//
//  ContentView.swift
//  Bar App
//
//  Created by Raj on 5/8/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var storeData = StoresData()
    @State private var searchText: String = ""
    @State private var selectedStore: Stores?
    
    var body: some View {
        ZStack{
            VStack {
                Text("Welcome to SipSap!")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                Text("What bar are you going to?")
                    .padding()
                TextField("Bar Name", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                if !searchText.isEmpty {
                    List {
                        ForEach(storeData.allStores.filter { $0.barName.lowercased()
                            .contains(searchText.lowercased()) }) { store in
                                Text(store.barName)
                                    .onTapGesture {
                                        selectedStore = store
                                        searchText = store.barName
                                    }
                            }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: 200)
                }
                if let selectedStore = selectedStore {
                    Text("Selected Bar: \(selectedStore.barName)")
                        .padding()
                }
                //add button that takes user to menu of drinks at the bar
                //add button at the bottom to go to view BarOwnerBarFind
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Add sample data for preview
        let storeData = StoresData()
        storeData.allStores = [
            Stores(username: "user1", password: "pass1", barName: "Bar A", barAddress: "123 Main St"),
            Stores(username: "user2", password: "pass2", barName: "Bar B", barAddress: "456 Elm St"),
            Stores(username: "user3", password: "pass3", barName: "Bar C", barAddress: "789 Oak St")
        ]
        
        return ContentView(storeData: storeData)
    }
}
