//
//  DessertInfoViewModel.swift
//  FetchiOSChallenge
//
//  Created by Mario Valencia on 21/10/23.
//

import Foundation

@MainActor
class DessertInfoViewModel: ObservableObject {
    @Published var dessertInfo: DessertInfo?
    var checkIngredient = [Bool]()
    
    func loadInformation (id: String) async  {
        
        do {
            let dessertInfo = try await DessertsManager.shared.fetchSingleDessertData(id: id)
            self.dessertInfo = dessertInfo
            
        } catch {
            print("Error retrieving data \(error)")
        }
    }
    
    func validateNilOrEmpty (dessert: DessertInfo, idx: Int) -> Bool {
        if let ingredient = dessert["strIngredient\(idx)"], let measurement = dessert["strMeasure\(idx)"] {
            if ingredient != "" && measurement != "" {
                checkIngredient.append(false)
                return true
            } else {
                return false
            }
            
        } else {
            return false
        }
    }
    
    func setCheckIngredients () -> [Bool] {
        return checkIngredient
    }
    
}
