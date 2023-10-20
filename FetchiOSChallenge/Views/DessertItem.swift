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
                            .frame(width: 300, height: 150)
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
                .clipped()
                .background(.brown)

            } else {
                Image(systemName: "xmark.circle.fill")
                    .frame(maxWidth: 200, maxHeight: 200)
                    .frame(width: 300, height: 150)
            }
            
            HStack {
                VStack (alignment: .leading) {
                    Text("\(dessert.name ?? "No Dessert Name")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.brown)
                }
                .padding(8)
                Spacer()
            }
        }
        .background(Color(red: 0.97, green: 0.91, blue: 0.84))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct DessertItem_Previews: PreviewProvider {
    static let dessert = Dessert(
        id: "53049",
        name: "Apam balik",
        strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    )
    static var previews: some View {
        DessertItem(dessert: dessert)
    }
}
