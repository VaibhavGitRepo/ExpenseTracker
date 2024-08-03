//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Vaibhav Sharma on 22/07/24.
//

import SwiftUI
import SwiftUICharts

struct HomeView: View {
    @State private var showmenu = false
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{
                    VStack(alignment: .leading,spacing: 24) {
                        Text("OverView")
                            .font(.title2)
                            .bold()
                        
                        let data = transactionListVM.accumulateTransactions()
                        
                        if !data.isEmpty {
                            let totalExpenses = data.last?.1 ?? 0
                            CardView{
                                VStack(alignment: .leading){
                                    ChartLabel(totalExpenses.formatted(.currency(code: "USD")),type: .title,format: "$%.02f ")
                                    LineChart()
                                }
                                .background(Color.systemBackground)
                            }
                            .data(data)
                            .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                            .frame(height: 300)
                        }
                        
                        
                       RecentTransactionList_()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                
                SideMenu_(isshowing: $showmenu)//this is the file for side view
                
            }
            .toolbar(showmenu ? .hidden: .visible, for: .navigationBar)
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline )
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button(action: {
                         showmenu.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                    })
                }
                ToolbarItemGroup(placement: .topBarTrailing){
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon,.primary)
                    
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.primary)
    }
}

struct HomeView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM  = TransactionListViewModel()
        transactionListVM.transactions = TransactionListPreviewData
        return transactionListVM
        }()
    static var previews: some View{
        HomeView()
            .environmentObject(transactionListVM)
    }
}
