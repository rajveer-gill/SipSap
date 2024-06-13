//
//  BarData.swift
//  Bar App
//
//  Created by Raj on 5/27/24.
//

import Foundation
import SwiftUI

struct BarDrink: Identifiable, Equatable, Hashable{
    var id = UUID()
    var drinkName: String
    var drinkPrice: Double
    
    init(drinkName: String, drinkPrice: Double) {
        self.drinkName = drinkName
        self.drinkPrice = drinkPrice
    }
    
    static func == (lhs: BarDrink, rhs: BarDrink) -> Bool {
        return lhs.id == rhs.id &&
            lhs.drinkName == rhs.drinkName &&
            lhs.drinkPrice == rhs.drinkPrice
    }
}

class BarData: ObservableObject{
    
    
    func getPrice(drinkCheck: BarDrink) -> Double?{
        return drinkCheck.drinkPrice
    }
    
    func getName(drinkCheck: BarDrink) -> String?{
        return drinkCheck.drinkName
    }
    
}
