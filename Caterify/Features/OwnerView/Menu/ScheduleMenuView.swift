//
//  ScheduleMenuView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct ScheduleMenuView: View {
    
    @StateObject var viewModel = ScheduleMenuViewModel()
    
    var body: some View {
        ZStack{
            Color.main.edgesIgnoringSafeArea(.top)
            VStack(){
                DatePicker("Select Date", selection: $viewModel.date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    
                HStack{
                    Text("Today Menu")
                        //.fontWeight(.bold)
                    Spacer()
                    NavigationLink {
                        
                    } label: {
                        Text("View all menu >")
                            .font(.caption)
                            .foregroundColor(Color.grey)
                    }
                }
                ScrollView{
                    MenuInfo(date: viewModel.date.toString(), price: viewModel.price, menu: Menu(id: 123, name: "Food Name", description: "This is Dummy Menu"))
                }.padding(.vertical, 16)
                .disabled(true)
                
            }
            .padding()
            .background(Color.ultraLightGrey)
            
        }
        
        .navigationTitle("My Menu")
        
    }
}


struct ScheduleMenuView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerView()
    }
}
