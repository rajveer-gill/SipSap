//
//  BarOwnerMenu.swift
//  Bar App
//
//  Created by Raj on 6/3/24.
//

import SwiftUI

struct BarOwnerMenu: View {
    @ObservedObject var storesData = StoresData()
    var store: Stores
    
    var body: some View {
        NavigationView {
            List(store.drinks) { drink in
                HStack {
                    Text(drink.drinkName)
                        .font(.headline)
                    Spacer()
                    Text(String(format: "$%.2f", drink.drinkPrice))
                        .font(.subheadline)
                }
                .padding()
            }
            .navigationTitle("Menu")
        }
    }
}


#Preview {
    let sampleDrink = BarDrink(drinkName: "Sample Drink", drinkPrice: 5.99)
    var sampleStore = Stores(username: "testUser", password: "testPass", barName: "Test Bar", barAddress: "123 Test St")
    sampleStore.drinks = [sampleDrink]
    
    return BarOwnerMenu(store: sampleStore)
}
