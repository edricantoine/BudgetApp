//
//  ContentView.swift
//  Budget
//
//  Created by Edric Antoine on 2025-03-29.
//

import SwiftUI

struct ContentView: View {
    @State private var expenditures: [Expenditure] = [
        Expenditure(id: 1, description: "Food @ McD's", amount: 15.05)
    ]
    
    func gotoSettings() {
        print("Go to settings...")
    }
    var body: some View {
        NavigationStack {
            List(expenditures, id: \.id) { expenditure in
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
            }
        }
        
    }
}

#Preview {
    ContentView()
}
