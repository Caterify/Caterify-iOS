//
//  HorizontalList.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct HomeComponent<Content: View, TargetView: View>: View {
    
    let title: String
    let buttonTitle: String
    let destination: TargetView
    let content: Content
    
    init(title: String, buttonTitle: String, destination: @escaping () -> TargetView, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.destination = destination()
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.system(size: 18).bold())
                Spacer()
                NavigationLink {
                    destination
                } label: {
                    HStack(spacing: 2) {
                        Text(buttonTitle)
                            .font(.caption)
                        Image(systemName: "chevron.forward")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal, 16)
            content
        }
    }
}

struct HorizontalList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color.ultraLightGrey
                HomeComponent(title: "Featured",
                               buttonTitle: "View All",
                               destination: {
                    Text("View All Page Nih")
                }, content: {
                    CateringListPreview(type: .horizontal)
                })
                    .navigationTitle("Horizontal List Preview")
            }
        }
    }
}
