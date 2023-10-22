//
//  DessertsViewModel.swift
//  FetchiOSChallenge
//
//  Created by Mario Valencia on 21/10/23.
//

import Foundation

@MainActor
class DessertsViewModel: ObservableObject {
    @Published var desserts = [Dessert]()
    
    func loadDesserts () async {
        do {
            let dessertsArray = try await DessertsManager.shared.fetchData()
            self.desserts = dessertsArray
        } catch {
            print("Error loading desserts \(error)")
        }
    }
}
