//
//  Expenditure.swift
//  Budget
//
//  Created by Edric Antoine on 2025-05-07.
//

import Foundation
import SwiftData

@Model
class Expenditure {
    var desc: String
    var amount: Decimal
    var id = UUID()
    
    init(description: String, amount: Decimal) {
        self.desc = description
        self.amount = amount
    }
}
