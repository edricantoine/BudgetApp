//
//  BudgetState.swift
//  Budget
//
//  Created by Edric Antoine on 2025-05-08.
//

import Foundation
import SwiftData

@Model
class BudgetState {
    var limit: Decimal
    var spent: Decimal
    var expenditures: [Expenditure]
    
    init() {
        self.limit = 200.0
        self.spent = 0.0
        self.expenditures = []
    }
}

