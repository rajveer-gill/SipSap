//
//  AddDrinksView.swift
//  Bar App
//
//  Created by Raj on 5/12/24.
//

import Foundation
import SwiftUI

struct AddDrinksView: View{
    @ObservedObject var storeData: StoresData
    var store: Stores
    @State private var drinkName: String = ""
    @State private var drinkCost: String = ""
    @State private var drinkCostDouble: Double = 0.0
    
    var body: some View{
        ZStack{
            Color.gray
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Text("Enter the drink name and the price")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                TextField("Drink Name: ", text: $drinkName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("Drink Cost: ", text: $drinkCost)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                    .onChange(of: drinkCost){ newValue, _ in
                        let filtered = newValue.filter { "0123456789.".contains($0) }
                        if filtered != newValue {
                            self.drinkCost = filtered
                        }
                        if let value = Double(filtered){
                            self.drinkCostDouble = value
                        }
                        else{
                            self.drinkCostDouble = 0.0
                        }
                    }
                Button(action: {
                    // Add functionality to add the drink
                    let newDrink = BarDrink(drinkName: drinkName, drinkPrice: drinkCostDouble)
                    if var existingStore = storeData.allStores.first(where: { $0.id == store.id }) {
                        storeData.addDrink(newDrink, to: &existingStore)
                    }
                }) {
                    Text("Add Drink")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
    
    
    
}

struct AddDrinksView_Previews: PreviewProvider{
    static var previews: some View {
        AddDrinksView(storeData: StoresData(), store: Stores(username: "user1", password: "pass1", barName: "Sample Bar", barAddress: "123 Main St"))
    }
}
    
