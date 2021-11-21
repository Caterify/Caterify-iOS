//
//  OrderView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var viewModel = OrderViewModel()
    
    var body: some View {
        VStack{
            CustomCateringSegmentedControl(selected: $viewModel.selected)
                .padding()
            ScrollView(){
                VStack(spacing: 0){
                    if viewModel.selected == .progress {
                        ForEach(viewModel.schedules.filter {
                            if let status = $0.orders?.first?.status {
                                return status < 2
                            } else {
                                return true
                            }
                        }.sorted { $0.date!.toDate()! < $1.date!.toDate()! }, id:\.id) { schedule in
                            CateringOrderCard(schedule, viewModel)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                        }
                    } else {
                        ForEach(viewModel.schedules.filter {
                            if let status = $0.orders?.first?.status {
                                return status == 2
                            } else {
                                return true
                            }
                        }.sorted { $0.date!.toDate()! > $1.date!.toDate()! }, id:\.id) { schedule in
                            CateringOrderCard(schedule, viewModel)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                        }
                    }
                }
                
            }
            .background(Color.ultraLightGrey)
        }
        .onAppear {
            viewModel.getAllOrders()
        }
        //.navigationTitle("My Order")
        
    }
}

struct CateringOrderCard: View {
    
    let schedule: Schedule
    let imageURL: URL
    @ObservedObject var viewModel: OrderViewModel
   
    init(_ schedule: Schedule, _ viewModel: OrderViewModel) {
        self.schedule = schedule
        let baseUrl = "https://caterify.xyz/images/menus/"
        let imageUrl = schedule.menu?.image ?? ""
        let url = imageUrl.isEmpty ? Constants.Endpoint.placeholderImage : baseUrl + imageUrl
        self.imageURL = URL(string: url) ?? URL(string: Constants.Endpoint.placeholderImage)!
        self.viewModel = viewModel
    }
    
    var body: some View{
        VStack{
            HStack{
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
                
                VStack(alignment: .leading){
                    Text(schedule.menu!.name!)
                    Text(schedule.date!.toDate()!.toString(withFormat: "dd MMM yyyy"))
                        .font(.caption)
                }
                Spacer()
                Text(Constants.OrderStatus[schedule.orders?.first?.status ?? 0])
            }
            HStack{
                Text("Total order: \(schedule.orders!.count)")
                    .font(.caption)
                Spacer()
                Text("Income: ")
                    .font(.caption)
                Text("Rp. \(schedule.price! * schedule.orders!.count)")
                    .font(.caption)
                    .foregroundColor(Color.main)
            }
            if schedule.orders!.first?.status ?? 0 == 1{
                NavigationLink{
                    RequestPickupView()
                        .onAppear {
                            viewModel.changeStatus(scheduleId: schedule.id!, status: 2)
                        }
                } label:{
                    Text("Request Pickup")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.main)
                        )
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.background)
        )
    }
}



struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
