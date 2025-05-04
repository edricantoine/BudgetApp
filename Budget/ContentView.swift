//
//  ContentView.swift
//  Budget
//
//  Created by Edric Antoine on 2025-03-29.
//

import SwiftUI

struct ContentView: View {
    func gotoSettings() {
        print("Go to settings...")
    }
    var body: some View {
        HStack() {
            Spacer()
            Button("Settings",
                   action: gotoSettings )
            .padding([.trailing])
            
        }
        VStack() {
            Text("My Budget")
                .font(.system(size: 32))
                .padding([.bottom], 5)
            HStack(spacing: 50) {
                Text("Interval: 1 week")
                Text("Remaining: $100")
            }
            Spacer()
        }
        
    }
}

#Preview {
    ContentView()
}
