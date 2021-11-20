//
//  CateringListView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CateringListView: View {
    
    let caterings: [Catering]
    let title: String
    
    var body: some View {
        ZStack {
            Color.main
                .edgesIgnoringSafeArea(.top)
            VStack(spacing: 0) {
                ScrollView {
                    CateringList(type: .vertical, caterings: caterings)
                }
                .background(Color.ultraLightGrey)
            }
        }
        .navigationTitle(title)
    }
}

struct CateringListViewPreview: View {
    
    @State var caterings: [Catering] = [
        Catering(id: 1, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 2, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 3, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 4, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 5, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 6, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000)),
        Catering(id: 7, name: "Catering Name", imageURL: "", distance: Distance.random(in: 100...12000), averagePrice: Price.random(in: 8000...80000))
    ]
    
    var body: some View {
        CateringListView(caterings: caterings, title: "Caterings")
    }
}

struct CateringListView_Previews: PreviewProvider {
    static var previews: some View {
        CateringListViewPreview()
    }
}
