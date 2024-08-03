//
//  TransactionLIst.swift
//  ExpenseTracker
//
//  Created by Vaibhav Sharma on 22/07/24.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack{
            List {
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key) { month, trasactions in
                    Section {
                        ForEach(trasactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews : PreviewProvider{
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM  = TransactionListViewModel()
        transactionListVM.transactions = TransactionListPreviewData
        return transactionListVM
        }()
    
    static var previews: some View{
        NavigationView{
            TransactionList()
        }
        .environmentObject(transactionListVM)
    }
}
