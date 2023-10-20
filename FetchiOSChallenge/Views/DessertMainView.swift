//
//  DessertMainView.swift
//  FetchiOSChallenge
//
//  Created by Mario Valencia on 10/19/23.
//

import SwiftUI

struct DessertMainView: View {
    let dessert: Dessert
    var body: some View {
        
        VStack {
            
            AsyncImage(url: dessert.strMealThumb) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 200, maxHeight: 200)

            
//            if let imageURL = dessert.strMealThumb {
//                AsyncImage(url: imageURL) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                    case .failure:
//                        Image(systemName: "xmark.circle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .foregroundColor(.red)
//                    @unknown default:
//                        fatalError("Problem with image")
//                    }
//                }
//                .frame(maxWidth: 200, maxHeight: 200)
//            } else {
//                Text("No Image Available")
//            }

        }
    }
}

struct DessertMainView_Previews: PreviewProvider {
    static let dessert = Dessert(
        id: "53049",
        name: "Apam balik",
        strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    )
    static var previews: some View {
        DessertMainView(dessert: dessert)
    }
}
