//
//  Expenditure.swift
//  Budget
//
//  Created by Edric Antoine on 2025-05-07.
//

import Foundation

class Expenditure {
    var description: String
    var amount: Decimal
    var id: Int
    
    init(id: Int, description: String, amount: Decimal) {
        self.id = id
        self.description = description
        self.amount = amount
    }
}
