//
//  DataModel.swift
//  FetchiOSChallenge
//
//  Created by Mario Valencia on 10/19/23.
//

import Foundation

struct Dessert: Identifiable, Codable {
    var id: String
    let strMeal: String
    let strMealThumb: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strMealThumb
    }
}

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

final class DessertsManager {
    static let shared = DessertsManager()
    
    private init () {}
    
    enum FetchError: Error {
        case invalidURL
        case networkError
        case decodingError
    }
    
    func fetchData() async throws -> [Dessert] {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw FetchError.invalidURL
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedData = try JSONDecoder().decode([String: [Dessert]].self, from: data)
            
            guard let desserts = decodedData["meals"] else {
                throw FetchError.decodingError
            }
            
            return desserts
            
        } catch {
            throw FetchError.networkError
            
        }
        
    }
    
}

