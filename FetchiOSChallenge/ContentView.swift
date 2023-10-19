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
            
            ScrollView {
                LazyVStack {
                    List(viewModel.desserts) { dessert in
                        NavigationLink {
                            Text(dessert.strMeal)
                        } label: {
                            DessertMainView(dessert: dessert)
                            
                        }

                    }
                }
            }
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
