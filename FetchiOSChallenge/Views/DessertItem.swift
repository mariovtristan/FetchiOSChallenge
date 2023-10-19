//
//  DessertItem.swift
//  FetchiOSChallenge
//
//  Created by Mario Valencia on 19/10/23.
//

import SwiftUI

struct DessertItem: View {
    let dessert: Dessert
    var body: some View {
        VStack {
            if let url = dessert.strMealThumb {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.red)
                    @unknown default:
                        fatalError("Problem with image")
                    }
                }
                .frame(width: 300, height: 150)
                .background(.indigo)
            } else {
                Image(systemName: "xmark.circle.fill")
                    .frame(maxWidth: 200, maxHeight: 200)
                    .frame(width: 300, height: 150)
            }
            
            HStack {
                VStack (alignment: .leading) {
                    Text("\(dessert.strMeal)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                    //the second argument in the text here specifier: "%.2f" , what it does is takes the extra trailing zeros and cuts it to only 2 decimals
                    Text("Hello")
                        .font(.caption)
                        .foregroundColor(Color("Secondary"))
                }
                .padding(8)
                Spacer()
            }
        }
    }
}

struct DessertItem_Previews: PreviewProvider {
    static let dessert = Dessert(
        id: "53049",
        strMeal: "Apam balik",
        strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    )
    static var previews: some View {
        DessertItem(dessert: dessert)
    }
}
