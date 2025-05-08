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
    var id = UUID()
    
    init(description: String, amount: Decimal) {
        self.description = description
        self.amount = amount
    }
}
