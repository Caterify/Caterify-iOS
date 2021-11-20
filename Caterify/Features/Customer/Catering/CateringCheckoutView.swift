//
//  CateringCheckoutView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CateringCheckoutView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CateringDetailsViewModel
    @AppStorage("address") var address = "Address Not Set"
    
    let startDate: Date
    let endDate: Date
    let menus: [Menu]
    
    var body: some View {
        ZStack {
            Color.ultraLightGrey
                .edgesIgnoringSafeArea(.top)
            VStack {
                VStack {
                    Group {
                        HStack {
                            Text("Delivery Time")
                            Spacer()
                            Text("Every 11:00 AM")
                                .foregroundColor(.grey)
                        }
                        Divider()
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.main)
                            Text(address)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.grey)
                        }
                    }
                    .padding(.horizontal, 8)
                }
                .padding(8)
                .background(Color.background)
                .cornerRadius(16)
                .padding(16)
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.schedules, id:\.id) { schedule in
                            MenuInfoCart(date: schedule.dateToString(), price: schedule.price!, menu: schedule.menu!)
                        }
                        VStack(spacing: 12) {
                            Divider()
                            PriceInfo(title: "Subtotal", price: viewModel.totalPrice!)
                            PriceInfo(title: "Delivery Fee - \(viewModel.count) days", price: viewModel.deliveryFee)
                        }
                    }
                    .padding(16)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 160)
                }
                .background(Rectangle()
                                .foregroundColor(Color.background))
            }
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Text("Total")
                        Spacer()
                        Text("\(viewModel.totalFee.toRupiah())")
                            .foregroundColor(.main)
                            .bold()
                    }
                    NavigationLink {
                        PaymentLoadingView(isPresented: $isPresented)
                    } label: {
                        HStack {
                            Spacer()
                            Text("Pay")
                                .foregroundColor(.white)
                                .bold()
                                .padding(16)
                            Spacer()
                        }
                        .background(RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(.main))
                    }
                    Spacer()
                }
                .padding(16)
                .frame(height: 132)
                .background(Rectangle()
                                .foregroundColor(.background)
                                .shadow(radius: 8))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("\(startDate.toString()) - \(endDate.toString())")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PriceInfo: View {
    let title: String
    let price: PriceInt
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(price.toRupiah())
                .bold()
        }
    }
}

struct MenuInfoCart: View {
    
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
        HStack(spacing: 16) {
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
                Text(date)
                    .font(.caption)
                    .foregroundColor(.grey)
                Spacer()
                HStack {
                    Spacer()
                    Text(price.toRupiah())
                        .bold()
                }
            }
        }
    }
}
