//
//  ContentView.swift
//  Budget
//
//  Created by Edric Antoine on 2025-03-29.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var showingPopup = false
    @State private var showingErrorPopup = false
    @State private var showingResetPopup = false
    @State private var showingModifyPopup = false
    
    
    @State private var budgetState: BudgetState = BudgetState()
    
    @State private var newDesc = ""
    @State private var newAmountStr = ""
    @State private var newLimitStr = ""
    
    func gotoSettings() {
        print("Go to settings...")
    }
    var body: some View {
        NavigationStack {
            List(budgetState.expenditures, id: \.id) { expenditure in
                HStack {
                    Text(expenditure.desc)
                    Spacer()
                    Text("$\(expenditure.amount)")
                    
                }
            }.toolbar {
                ToolbarItem() {
                    VStack {
                        HStack{
                            Text("My Budget").font(.title).padding(.bottom, 10)
                        }
                        HStack {
                            Text("Spent: $\(budgetState.spent)").font(.title3).padding(.trailing)
                            Spacer()
                            Text("Remaining: $\(budgetState.limit - budgetState.spent)").font(.title3).padding(.leading)
                            
                        }
                    }.padding(.top, 40).padding(.bottom)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        showingModifyPopup.toggle()
                    }.alert("Edit budget limit. This will reset your current budget", isPresented: $showingModifyPopup) {
                        TextField("New Limit", text: $newLimitStr)
                        Button("Confirm") {
                            var newLimit: Decimal = 0.0
                            let formatter = NumberFormatter()
                            formatter.locale = Locale(identifier: "en_US")
                            formatter.numberStyle = .decimal
                            
                            if let number = formatter.number(from: newLimitStr) {
                                newLimit = number.decimalValue
                                budgetState.limit = newLimit
                                budgetState.defaultLimit = newLimit
                                budgetState.expenditures = []
                                budgetState.spent = 0.0
                                
                                do {
                                    try context.save()
                                } catch {
                                    print("Could not save...")
                                }
                                
                            } else {
                                showingErrorPopup.toggle()
                            }
                            
                            newLimitStr = ""
                        }
                        Button("Cancel") {
                            
                        }
                    }
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
                                
                                budgetState.spent += newAmount
                                
                                do {
                                    try context.save()
                                } catch {
                                    print("Could not save...")
                                }
                                
                                
                                
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
                            
                            if(budgetState.mode == "Add") {
                                budgetState.limit = (budgetState.limit - budgetState.spent) + budgetState.defaultLimit
                            } else {
                                budgetState.limit = budgetState.defaultLimit
                            }
                            
                            budgetState.spent = 0.0

                            do {
                                try context.save()
                            } catch {
                                print("Could not save...")
                            }
                        }.tint(.red)
                        Button("Cancel") {
                            
                        }
                    }
                }
            }.onAppear(perform: load)
        }
        
    }
    
    func load() {
        if let result = try! context.fetch(FetchDescriptor<BudgetState>()).first {
                    budgetState = result
                } else {
                    let instance = BudgetState()
                    context.insert(instance)
                    budgetState = instance
                }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [BudgetState.self, Expenditure.self], inMemory: true)
}
