//
//  DataModel.swift
//  FetchiOSChallenge
//
//  Created by Mario Valencia on 10/19/23.
//

import Foundation

struct Dessert: Identifiable, Codable {
    var id: String?
    let name: String?
    var strMealThumb: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case strMealThumb
    }
}

struct DessertInfo: Identifiable, Codable {
    var id: String?
    var name: String?
    var instructions: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    subscript(key: String) -> String? {
        switch key {
        case "strIngredient1": return strIngredient1
        case "strIngredient2": return strIngredient2
        case "strIngredient3": return strIngredient3
        case "strIngredient4": return strIngredient4
        case "strIngredient5": return strIngredient5
        case "strIngredient6": return strIngredient6
        case "strIngredient7": return strIngredient7
        case "strIngredient8": return strIngredient8
        case "strIngredient9": return strIngredient9
        case "strIngredient10": return strIngredient10
        case "strIngredient11": return strIngredient11
        case "strIngredient12": return strIngredient12
        case "strIngredient13": return strIngredient13
        case "strIngredient14": return strIngredient14
        case "strIngredient15": return strIngredient15
        case "strIngredient16": return strIngredient16
        case "strIngredient17": return strIngredient17
        case "strIngredient18": return strIngredient18
        case "strIngredient19": return strIngredient19
        case "strIngredient20": return strIngredient20
            
        case "strMeasure1": return strMeasure1
        case "strMeasure2": return strMeasure2
        case "strMeasure3": return strMeasure3
        case "strMeasure4": return strMeasure4
        case "strMeasure5": return strMeasure5
        case "strMeasure6": return strMeasure6
        case "strMeasure7": return strMeasure7
        case "strMeasure8": return strMeasure8
        case "strMeasure9": return strMeasure9
        case "strMeasure10": return strMeasure10
        case "strMeasure11": return strMeasure11
        case "strMeasure12": return strMeasure12
        case "strMeasure13": return strMeasure13
        case "strMeasure14": return strMeasure14
        case "strMeasure15": return strMeasure15
        case "strMeasure16": return strMeasure16
        case "strMeasure17": return strMeasure17
        case "strMeasure18": return strMeasure18
        case "strMeasure19": return strMeasure19
        case "strMeasure20": return strMeasure20
            
        default: return ""
        }
        
        
    }
    
}

class DessertData: Codable {
    var meals: [DessertInfo]
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
            
            return self.sortAlphabetically(desserts: desserts)
            
        } catch {
            throw FetchError.networkError
            
        }
        
    }
    
    func sortAlphabetically (desserts: [Dessert]) -> [Dessert] {
        let sortedDesserts = desserts.sorted { dessert1, dessert2 in
            switch (dessert1.name, dessert2.name) {
            case let (.some(name1), .some(name2)):
                return name1 < name2
            case (.some, .none):
                return true
            default:
                return false
            }
        }
        return sortedDesserts
    }
    
    
    func fetchSingleDessertData (id: String) async throws -> DessertInfo {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            throw FetchError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedData = try JSONDecoder().decode(DessertData.self, from: data)
            
            guard let dessertInfo = decodedData.meals.first else {
                throw FetchError.decodingError
            }
            
            return dessertInfo
            
        } catch {
            print("erorr in decoding")
            throw FetchError.decodingError
        }
    }
    
}

