//
//  ContentView.swift
//  Budget
//
//  Created by Edric Antoine on 2025-03-29.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingPopup = false
    @State private var showingErrorPopup = false
    @State private var showingResetPopup = false
    
    
    @State private var budgetState: BudgetState = BudgetState()
    
    @State private var newDesc = ""
    @State private var newAmountStr = ""
    
    func gotoSettings() {
        print("Go to settings...")
    }
    var body: some View {
        NavigationStack {
            List(budgetState.expenditures, id: \.id) { expenditure in
                HStack {
                    Text(expenditure.description)
                    Spacer()
                    Text("$\(expenditure.amount)")
                    
                }
            }.toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("My Budget").font(.title).padding(.bottom, 10)
                        HStack {
                            Text("Spent: $15.05").font(.title3)
                            Spacer()
                            Text("Remaining: $184.95").font(.title3)
                        }
                    }.padding(.top, 40)
                }
            }.safeAreaInset(edge: .bottom) {
                VStack {
                    Button("Add new expenditure") {
                        showingPopup.toggle()
                    }.alert("Add new expenditure", isPresented: $showingPopup) {
                        TextField("Description", text: $newDesc)
                        TextField("Amount Spent", text: $newAmountStr)
                        Button("Add") {
                            var newAmount: Decimal = 0.0
                            let formatter = NumberFormatter()
                            formatter.locale = Locale(identifier: "en_US")
                            formatter.numberStyle = .decimal
                            
                            if let number = formatter.number(from: newAmountStr) {
                                newAmount = number.decimalValue
                                let newExp = Expenditure( description: newDesc, amount: newAmount)
                                
                                budgetState.expenditures.append(newExp)
                            } else {
                                showingErrorPopup.toggle()
                            }
                            newDesc = ""
                            newAmountStr = ""
                        }
                        Button("Cancel") {
                            
                        }
                    }.alert("Please enter a valid decimal number.", isPresented: $showingErrorPopup) {
                        Button("OK") {
                            
                        }
                    }
                    // TODO: move this to settings page...
                    Button("Reset budget") {
                        showingResetPopup.toggle()
                    }.padding(.top).tint(.red).alert("Are you sure you want to reset this budget?", isPresented: $showingResetPopup) {
                        Button("Yes") {
                            budgetState.expenditures = []
                        }.tint(.red)
                        Button("Cancel") {
                            
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
