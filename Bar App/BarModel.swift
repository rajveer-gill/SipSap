//
//  BarModel.swift
//  Bar App
//
//  Created by Raj on 5/9/24.
//

import Foundation
import SwiftUI

struct Customer{
    var ID: Int
    var order: String
    
    init(ID: Int, order: String){
        self.ID = ID
        self.order = order
    }
    
}


class BarViewModel: ObservableObject{
    
    @Published var customerNumb = 0;
    @Published var queue = [Customer]()
    
    func makeCustomer(order: String) -> Customer{
        var newCust = Customer(ID: customerNumb, order: order)
        customerNumb += 1
        return newCust
    }
    
    func enqueue(customer: Customer){
        queue.append(customer)
    }
    
    func getNextOrder() -> String{
        return queue[0].order
    }
    
    func orderCompleted(){
        queue.remove(at: 0)
    }
    
    
}
