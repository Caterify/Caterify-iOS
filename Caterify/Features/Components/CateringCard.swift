//
//  CateringCard.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CateringCard: View {
    
    enum CardSizeType {
        case big, small
    }
    
    let type: CardSizeType
    let catering: Catering
    let name: String
    let imageURL: URL?
    let distance: Distance
    let averagePrice: Price
    
    @AppStorage("side") var side: String = "login"
    @State var isPresentingSheet: Bool = false
    
    init(type: CardSizeType, catering: Catering, name: String, imageURL: String, distance: Distance, averagePrice: Price) {
        self.type = type
        self.catering = catering
        self.name = name
        let baseUrl = "https://caterify.xyz/images/caterings/"
        let url = imageURL.isEmpty ? Constants.Endpoint.placeholderImage : baseUrl + imageURL
        self.imageURL = URL(string: url)!
        self.distance = distance
        self.averagePrice = averagePrice
    }
    
    var body: some View {
        switch type {
        case .big:
            Button {
                isPresentingSheet.toggle()
            } label: {
                VStack(alignment: .leading, spacing: 2) {
                    Group {
                        AsyncImage(url: imageURL) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                            } else {
                                Image("Dummy Food")
                                    .resizable()
                                    .redacted(reason: .placeholder)
                            }
                        }
                    }
                    .scaledToFill()
                    .frame(height: 134)
                    .clipped()
                    CateringCardInfo(name: name, range: distance, price: averagePrice)
                }
                .frame(width: 253)
                .background(.background)
                .cornerRadius(6)
                .fullScreenCover(isPresented: $isPresentingSheet) {
                    NavigationView {
                        CateringDetailsView(catering, isPresented: $isPresentingSheet)
                    }
                }
            }
        case .small:
            Button {
                isPresentingSheet.toggle()
            } label: {
                HStack {
                    Group {
                        AsyncImage(url: imageURL) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                            } else {
                                Image("Dummy Food")
                                    .resizable()
                            }
                        }
                    }
                    .scaledToFill()
                    .frame(width: 80)
                    .clipped()
                    CateringCardInfo(name: name, range: distance, price: averagePrice)
                }
                .frame(height: 80)
                .background(.background)
                .cornerRadius(6)
                .fullScreenCover(isPresented: $isPresentingSheet) {
                    NavigationView {
                        CateringDetailsView(catering, isPresented: $isPresentingSheet)
                    }
                }
            }
        }
    }
}

struct CateringCardInfo: View {
    
    let name: String
    let range: Distance
    let price: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(name)
                .font(.headline)
            HStack {
                Text(price.priceRange.rawValue)
                Rectangle()
                    .frame(width: 1, height: 12)
                Text(range.toMeters)
                Spacer()
            }
            .font(.system(size: 13))
            .foregroundColor(.grey)
        }
        .padding(8)
    }
}
