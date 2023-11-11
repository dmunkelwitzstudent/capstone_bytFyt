//
//  ContentView.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/1/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
      
      DashboardView()
       
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
