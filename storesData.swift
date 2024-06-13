//
//  storesData.swift
//  Bar App
//
//  Created by Raj on 6/1/24.
//

import Foundation
import SwiftUI

struct Stores: Identifiable, Equatable, Hashable{
    private(set) var username: String
    private(set) var password: String
    var id = UUID()
    var barName: String
    var barAddress: String
    var drinks: [BarDrink] = []
    
    init(username: String, password: String, barName: String, barAddress: String) {
        self.barName = barName
        self.barAddress = barAddress
        self.username = username
        self.password = password
    }
    
    func getPass() -> String{
        return password
    }
    
    func getUsername() -> String{
        return username
    }
    
    mutating func changePass(newPass: String){
        password = newPass
    }
    
    mutating func changeUsername(newUsername: String){
        username = newUsername
    }
    
    static func == (lhs: Stores, rhs: Stores) -> Bool {
        return lhs.id == rhs.id &&
            lhs.username == rhs.username &&
            lhs.password == rhs.password &&
            lhs.barName == rhs.barName &&
            lhs.barAddress == rhs.barAddress &&
            lhs.drinks == rhs.drinks
    }
}


class StoresData: ObservableObject{
    
    @Published var allStores: [Stores] = [
        Stores(username: "Frank", password: "Pass123", barName: "Bar 1", barAddress: "Bar1st")
    ]

    
    func addDrink(_ drink: BarDrink, to store: inout Stores) {
        store.drinks.append(drink)
        if let index = allStores.firstIndex(where: { $0.id == store.id }) {
            allStores[index] = store
        }
    }
    
    func removeDrink(drink: BarDrink, from store: inout Stores) {
        if let index = store.drinks.firstIndex(where: { $0.id == drink.id }) {
            store.drinks.remove(at: index)
        }
    }
    
    func checkCredentials(username: String, password: String) -> Bool {
        return allStores.contains(where: { $0.getUsername() == username && $0.getPass() == password })
    }
    
    func getStore(username: String, password: String) -> Stores? {
        return allStores.first { $0.getUsername() == username && $0.getPass() == password }
    }
}


