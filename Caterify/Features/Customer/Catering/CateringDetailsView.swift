//
//  CateringDetailsView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CateringDetailsView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CateringDetailsViewModel
    @AppStorage("token") var loginToken = ""
    @AppStorage("side") var side = "customer"
    @State var isPresentingAlert: Bool = false
    
    @State var isActiveNavLinkCheckout: Bool = false
    
    init(_ catering: Catering, isPresented: Binding<Bool>) {
        self.viewModel = CateringDetailsViewModel(catering)
        self._isPresented = isPresented
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                isPresented.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .foregroundColor(.main)
                                .padding(.bottom, 8)
                        }
                        Spacer()
                    }
                    CateringProfile(viewModel.catering)
                    CateringContact(viewModel.catering)
                }
                .padding(.horizontal, 16)
                .background(Rectangle()
                                .foregroundColor(.background))
                OrderDatePicker(viewModel: viewModel)
                    .background(Color.ultraLightGrey)
            }
            VStack {
                Spacer()
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
                NavigationLink(isActive: $isActiveNavLinkCheckout) {
                    CateringCheckoutView(isPresented: $isPresented, viewModel: viewModel, startDate: viewModel.startDate, endDate: viewModel.endDate, menus: viewModel.schedules.map { $0.menu! })
                        .foregroundColor(.primary)
                } label: {
                    EmptyView()
                }
                Button {
                    if loginToken.isEmpty {
                        isPresentingAlert.toggle()
                    } else {
                        isActiveNavLinkCheckout = true
                    }
                } label: {
                    VStack {
                        HStack {
                            Spacer()
                            Text("Check Out - \(viewModel.totalPrice ?? 0)")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(16)
                    .frame(height: 88)
                    .background(Rectangle()
                                    .foregroundColor(.main)
                                    .shadow(radius: 8))
                    .contentShape(Rectangle())
                }
                .alert(isPresented: $isPresentingAlert) {
                    Alert(title: Text("Login Required"),
                          message:
                            Text("You need to login to check out."),
                          primaryButton:
                                .default(Text("Login"), action: {
                        isPresented = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            side = "login"
                        }
                    }),
                          secondaryButton:
                                .cancel())
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OrderDatePicker: View {
    
    @ObservedObject var viewModel: CateringDetailsViewModel
    
    var body: some View {
        VStack {
            List {
                Section {
                    DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: [.date])
                    DatePicker("End Date", selection: $viewModel.endDate, in: viewModel.startDate..., displayedComponents: [.date])
                } header: {
                    Text("Time Range")
                } footer: {
                    Text("Show scheduled menu by desired time range.")
                }
                Section {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.schedules, id: \.id) { schedule in
                            if let date = schedule.dateToString(),
                               let price = schedule.price,
                               let menu = schedule.menu {
                                MenuInfo(date: date, price: price, menu: menu)
                                    .redacted(reason: viewModel.isDoneLoadingRangedSchedule ? [] : .placeholder)
                                if let id = schedule.id, let lastId = viewModel.schedules.last?.id {
                                    if id != lastId {
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 12)
                } header: {
                    Text("Scheduled Menu")
                }
                Section {
                    
                }
                .padding(.bottom, 96)
            }
            .listStyle(.insetGrouped)
            .onReceive(viewModel.$startDate) { value in
                viewModel.endDate = viewModel.startDate.addingTimeInterval(viewModel.duration)
            }
            .onReceive(viewModel.$endDate) { value in
                viewModel.duration = viewModel.endDate.timeIntervalSince1970 - viewModel.startDate.timeIntervalSince1970
                viewModel.getSchedules()
            }
        }
    }
}

struct MenuInfo: View {
    
    let date: String
    let price: PriceInt
    let menu: Menu
    let imageURL: URL?
    
    init(date: String, price: PriceInt, menu: Menu) {
        self.date = date
        self.price = price
        self.menu = menu
        let baseUrl = "https://caterify.xyz/images/menus/"
        let imageUrl = menu.image ?? ""
        let url = imageUrl.isEmpty ? Constants.Endpoint.placeholderImage : baseUrl + imageUrl
        self.imageURL = URL(string: url)!
    }
    
    var body: some View {
        HStack {
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
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            .clipped()
            VStack(alignment: .leading, spacing: 0) {
                Text(menu.name ?? "Food Name")
                    .bold()
                Group {
                    Text(date)
                    Text(menu.description ?? "Ayam Goreng, Apple Cok, Doremi")
                        .multilineTextAlignment(.leading)
                }
                .font(.caption)
                .foregroundColor(.grey)
                Spacer()
                Text(price.toRupiah())
                    .foregroundColor(.main)
                    .bold()
            }
        }
    }
}

struct CateringContact: View {
    
    let catering: Catering
    
    init(_ catering: Catering) {
        self.catering = catering
    }
    
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(.main)
            Text(catering.address ?? "")
                .multilineTextAlignment(.leading)
               .foregroundColor(Color.primary)
                .font(.system(size: 14))
            Spacer()
            Image(systemName: "person.crop.circle.badge.plus")
                .foregroundColor(.main)
                .padding()
        }
    }
}

struct CateringProfile: View {
    
    let catering: Catering
    let imageURL: URL?
    
    init(_ catering: Catering) {
        self.catering = catering
        let baseUrl = "https://caterify.xyz/images/caterings/"
        let imageUrl = catering.imageURL ?? ""
        let url = imageUrl.isEmpty ? Constants.Endpoint.placeholderImage : baseUrl + imageUrl
        self.imageURL = URL(string: url)!
    }
    
    var body: some View {
        HStack(spacing: 16) {
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
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            .clipped()
            VStack(alignment: .leading, spacing: 4) {
                if let name = catering.name,
                   let distance = catering.distance,
                   let price = catering.averagePrice {
                    Text(name)
                        .font(.system(size: 18).bold())
                    HStack {
                        Text(price.priceRange.rawValue)
                        Rectangle()
                            .frame(width: 1, height: 12)
                        Text(distance.toMeters)
                        Spacer()
                    }
                    .font(.system(size: 13))
                    .foregroundColor(.grey)
                }
            }
        }
        .frame(height: 80)
        .background(Color.background)
        .cornerRadius(6)
    }
}
