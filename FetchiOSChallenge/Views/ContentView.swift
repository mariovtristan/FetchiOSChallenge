//
//  ContentView.swift
//  FetchiOSChallenge
//
//  Created by Mario Valencia on 10/19/23.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var viewModel = DessertsViewModel()
    var body: some View {
        NavigationStack {
            
            List(viewModel.desserts) { dessert in
                NavigationLink {
                    DessertDetailView(dessert: dessert)
                } label: {
                    DessertItem(dessert: dessert)
                    
                }
                .listRowBackground(Color(.clear))
                .listRowSeparatorTint(.clear)
            }
            .navigationTitle("Desserts")
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.loadDesserts()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
