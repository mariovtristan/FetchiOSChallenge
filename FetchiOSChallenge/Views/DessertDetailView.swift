//
//  DessertDetailView.swift
//  FetchiOSChallenge
//
//  Created by Mario Valencia on 19/10/23.
//

import SwiftUI

struct DessertDetailView: View {
    @StateObject var viewModel = DessertInfoViewModel()
    
    @State var checkedItems = Array(repeating: "square.dashed", count: 20)
    
    var dessert: Dessert
    
    let layout = [
        GridItem(.adaptive(minimum: 200))
    ]
    var body: some View {
        ScrollView {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.yellow)
                    .frame(maxWidth: .infinity, maxHeight: 350)
                
                
                AsyncImage(url: dessert.strMealThumb) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: .infinity, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    
                } placeholder: {
                    ProgressView()
                }
                
            }
            
            Text(dessert.name ?? "No Dessert Name")
                .font(.largeTitle)
                .foregroundColor(.white)
                .minimumScaleFactor(0.5)
                .padding()
                .frame(width: 300, height: 100)
                .background(.yellow)
                .cornerRadius(10)
                .shadow(radius: 10)
                .offset(y: -50)
            

            
            
            HStack {
                Image(systemName: "leaf")
                    .foregroundColor(.green)
                    .padding(.leading)
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding(6)
            
            LazyVGrid(columns: layout) {
                ForEach(0..<20) { idx in
                    HStack {
                        if let dessertInfo = viewModel.dessertInfo {
                            if viewModel.validateNilOrEmpty(dessert: dessertInfo, idx: idx)  {
                                
                                Image(systemName: checkedItems[idx])
                                    .onTapGesture {
                                        if checkedItems[idx] == "square.dashed" {
                                            checkedItems[idx] = "square.fill"
                                        } else {
                                            checkedItems[idx] = "square.dashed"
                                        }
                                    }
                                Text(viewModel.dessertInfo?["strMeasure\(idx)"] ?? "Loading")
                                Text(viewModel.dessertInfo?["strIngredient\(idx)"] ?? "Loading")
                                
                                Spacer()
                            }
                            
                        }
                    }
                    .padding(.horizontal)


                }
                
            }
            
            HStack {
                Image(systemName: "cooktop")
                    .foregroundColor(.brown)
                    .padding(.leading)
                VStack(alignment: .leading) {
                    
                    Text("Instructions")
                }
                .font(.title3)
                .fontWeight(.semibold)
                Spacer()
            }
            .padding(6)
            
            Text(viewModel.dessertInfo?.instructions ?? "No instructions for this receipe")
                .padding(.horizontal)

            

        }
        .onAppear {
            Task {
                if let id = dessert.id {
                    await viewModel.loadInformation(id: id)
                } else {
                    return
                }
                

            }
        }
    }
        
}

struct DessertDetailView_Previews: PreviewProvider {
    static let dessert = Dessert(
        id: "53049",
        name: "Apam balik",
        strMealThumb: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
    )
    static var previews: some View {
        DessertDetailView(dessert: dessert)
    }
}
