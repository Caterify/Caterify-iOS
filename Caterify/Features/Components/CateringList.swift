//
//  CateringList.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

enum CateringListType {
    case vertical, horizontal
}

struct CateringList: View {
    
    let type: CateringListType
    var caterings: [Catering]
    
    var body: some View {
        switch type {
        case .vertical:
            ScrollView {
                LazyVStack {
                    ForEach(caterings, id:\.id) { catering in
                        if let name = catering.name,
                           let imageURL = catering.imageURL ?? "",
                           let distance = catering.distance,
                           let price = catering.averagePrice {
                            CateringCard(type: .small, catering: catering, name: name, imageURL: imageURL, distance: distance, averagePrice: price)
                                .padding(4)
                        }
                    }
                }
                .padding(12)
            }
        case .horizontal:
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(caterings, id: \.id) { catering in
                        if let name = catering.name,
                           let imageURL = catering.imageURL ?? "",
                           let distance = catering.distance,
                           let price = catering.averagePrice {
                            CateringCard(type: .big, catering: catering, name: name, imageURL: imageURL, distance: distance, averagePrice: price)
                                .padding(4)
                        }
                    }
                }
                .padding(12)
            }
        }
    }
}

struct CateringListPreview: View {
    
    var caterings: [Catering] = [
        Catering(id: 1, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 2, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 3, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 4, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 5, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 6, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 7, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
    ]
    
    let type: CateringListType
    
    var body: some View {
        CateringList(type: type, caterings: caterings)
    }
}

struct CateringList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color.ultraLightGrey
                ScrollView {
                    VStack(spacing: 0) {
                        CateringListPreview(type: .horizontal)
                        CateringListPreview(type: .vertical)
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("CateringCard Preview")
        }
    }
}
