//
//  CustomerSubscriptionView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

enum OrderStatus: Int, CaseIterable  {
    case all = 0
    case progress = 1
    case completed = 2
}

enum CateringOrderStatus: Int, CaseIterable {
    case progress = 1
    case completed = 2
}

struct CustomerSubscriptionView: View {
    
    @StateObject var viewModel = CustomerSubscriptionViewModel()
    @AppStorage("side") var side: String = "customer"
    @AppStorage("token") var loginToken: String = ""
    
    @State var selectedSegment: OrderStatus = .all
    @State var orders: [Order] = [] {
        didSet {
            orders = orders.sorted { $0.schedule!.date!.toDate()! > $1.schedule!.date!.toDate()! }
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Spacer()
                Button {
                    if loginToken.isEmpty {
                        side = "login"
                    } else {
                        loginToken = ""
                        side = "login"
                    }
                } label: {
                    if loginToken.isEmpty {
                        Text("Login")
                    } else {
                        Text("Logout")
                    }
                }
            }
            .padding(.horizontal, 32)
            CustomSegmentedControl(selected: $selectedSegment)
                .padding(.horizontal, 16)
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.orders.filter { $0.status == selectedSegment.rawValue }, id:\.id) { order in
                        OrderCard(order)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.background)
                            )
                            .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 8)
                .onAppear {
                    viewModel.getOrders()
                }
            }
            .background(Color.ultraLightGrey)
        }
        .navigationBarTitle("")
        .navigationBarHidden(false)
    }
}

struct CustomSegmentedControl: View{
    @Binding var selected: OrderStatus
    let orderStatusName: [String] = ["All", "In Progress", "Completed"]
    
    var body: some View{
        
        HStack{
            ForEach(OrderStatus.allCases, id:\.rawValue) { status in
                Button {
                    selected = status
                } label:{
                    Text(orderStatusName[status.rawValue])
                        .font(.subheadline)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selected == status ?  Color.main : Color.clear)
                        )
                        .foregroundColor(selected == status ? .white : .grey )
                }
            }
        }
    }
}

struct CustomCateringSegmentedControl:View{
    @Binding var selected: CateringOrderStatus
    let orderStatusName: [String] = ["All", "In Progress", "Completed"]
    var body: some View{
        HStack{
            ForEach(CateringOrderStatus.allCases, id:\.rawValue) { status in
                Button {
                    selected = status
                } label:{
                    Text(orderStatusName[status.rawValue])
                        .font(.subheadline)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selected == status ?  Color.main : Color.clear)
                        )
                        .foregroundColor(selected == status ? .white : .grey )
                }
            }
        }
    }
}

struct OrderCard: View {
    
    let order: Order
    let imageURL: URL
    
    init(_ order: Order) {
        self.order = order
        let baseUrl = "https://caterify.xyz/images/menus/"
        let imageUrl = order.schedule?.menu?.image ?? ""
        let url = imageUrl.isEmpty ? Constants.Endpoint.placeholderImage : baseUrl + imageUrl
        self.imageURL = URL(string: url) ?? URL(string: Constants.Endpoint.placeholderImage)!
    }
    var body: some View {
        VStack{
            HStack(spacing: 16){
                AsyncImage(url: imageURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .cornerRadius(8)
                            .clipped()
                    } else {
                        Image("Dummy Food")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .cornerRadius(8)
                            .clipped()
                            .redacted(reason: .placeholder)
                    }
                }
                VStack(alignment: .leading, spacing: 4){
                    Text(order.schedule!.menu!.name!)
                        .font(.callout)
                        .bold()
                    Text(order.schedule!.date!.toDate()!.toString(withFormat: "dd MMM yyyy"))
                        .font(.caption)
                }
                Spacer()
                VStack {
                    Text(Constants.OrderStatus[order.status!])
                        .font(.caption)
                        .foregroundColor(.main)
                    Text("\(order.schedule!.price!.toRupiah())")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.main)
                }
            }
            .padding(8)
        }
    }
}


struct CustomerSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerSubscriptionView()
    }
}
