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
            CateringOrderCard()
        }
        .navigationTitle("My Order")
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
            }
        }
    }
}



struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
