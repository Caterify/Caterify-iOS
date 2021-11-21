//
//  ScheduleMenuView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct ScheduleMenuView: View {
    
    @StateObject var viewModel = ScheduleMenuViewModel()
    @Binding var date: Date
    
    var body: some View {
        ZStack{
            Color.main.edgesIgnoringSafeArea(.top)
            VStack(){
                DatePicker("Select Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .onChange(of: viewModel.date) { newValue in
                        viewModel.getActiveOrder()
                    }
                    
                HStack{
                    Text("Today Menu")
                    Spacer()
                        //.fontWeight(.bold)
                }
                ScrollView{
                    if let menu = viewModel.menu {
                        MenuInfo(date: viewModel.date.toString(), price: viewModel.price, menu: menu)
                    } else {
                        Text("No menu on this date")
                    }
                }.padding(.vertical, 16)
                .disabled(true)
                
            }
            .padding()
            .background(Color.background)
            
        }
        //.navigationTitle("My Menu")
        
    }
}


struct ScheduleMenuView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerView()
    }
}
