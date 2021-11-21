//
//  OrderView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var viewModel = OrderViewModel()
    @State var selected: CateringOrderStatus = .progress
    var body: some View {
        VStack{
            CustomCateringSegmentedControl(selected: $selected)
                .padding()
            ScrollView(){
                LazyVStack(spacing: 0){
                    ForEach(1..<10){_ in
                        CateringOrderCard()
                            .padding(.horizontal,16)
                            .padding(.vertical, 8)
                    }
                }
                
            }
            .background(Color.ultraLightGrey)
        }
        //.navigationTitle("My Order")
        
    }
}

struct CateringOrderCard: View {
    
    //    let order: Order
    //   let imageURL: URL
    //
    //    init(_ order: Order) {
    //        self.order = order
    //        let baseUrl = "https://caterify.xyz/images/menus/"
    //        let imageUrl = order.schedule?.menu?.image ?? ""
    //        let url = imageUrl.isEmpty ? Constants.Endpoint.placeholderImage : baseUrl + imageUrl
    //        self.imageURL = URL(string: url) ?? URL(string: Constants.Endpoint.placeholderImage)!
    //    }
    //    var body: some View {
    //        VStack{
    //            HStack(spacing: 16){
    //                AsyncImage(url: imageURL) { phase in
    //                    if let image = phase.image {
    //                        image
    //                            .resizable()
    //                            .scaledToFill()
    //                            .frame(width: 48, height: 48)
    //                            .cornerRadius(8)
    //                            .clipped()
    //                    } else {
    //                        Image("Dummy Food")
    //                            .resizable()
    //                            .scaledToFill()
    //                            .frame(width: 48, height: 48)
    //                            .cornerRadius(8)
    //                            .clipped()
    //                            .redacted(reason: .placeholder)
    //                    }
    //                }
    //                VStack(alignment: .leading, spacing: 4){
    //                    Text(order.schedule!.menu!.name!)
    //                        .font(.callout)
    //                        .bold()
    //                    Text(order.schedule!.date!.toDate()!.toString(withFormat: "dd MMM yyyy"))
    //                        .font(.caption)
    //                }
    //                Spacer()
    //                VStack {
    //                    Text(Constants.OrderStatus[order.status!])
    //                        .font(.caption)
    //                        .foregroundColor(.main)
    //                    Text("\(order.schedule!.price!.toRupiah())")
    //                        .font(.caption)
    //                        .fontWeight(.bold)
    //                        .foregroundColor(Color.main)
    //                }
    //            }
    //            .padding(8)
    //        }
    //    }
    
    var body: some View{
        VStack{
            HStack{
                Image("Dummy Food")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .cornerRadius(8)
                    .clipped()
                    .redacted(reason: .placeholder)
                VStack(alignment: .leading){
                    Text("Name")
                    Text("Order Time")
                        .font(.callout)
                }
                Spacer()
                Text("Status")
            }
            HStack{
                Text("Total order: 200")
                    .font(.caption)
                Spacer()
                Text("Income: ")
                    .font(.caption)
                Text("Rp. 200.000")
                    .font(.caption)
                    .foregroundColor(Color.main)
            }
            Button{
                //request Pickup
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
