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
    var defaultLimit: Decimal
    var limit: Decimal
    var spent: Decimal
    var mode: String // can be "Add" or "Reset"
    var expenditures: [Expenditure]
    
    init() {
        self.limit = 50.0
        self.defaultLimit = 50.0
        self.spent = 0.0
        self.mode = "Add"
        self.expenditures = []
    }
}

