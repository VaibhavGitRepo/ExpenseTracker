//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Vaibhav Sharma on 22/07/24.
//

import Foundation

var TransactionPreviewData = Transaction(id: 1, date: "01/01/2024", institution: "College", account: "College account", merchant: "Apple", amount: 500.0, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var TransactionListPreviewData = [Transaction](repeating: TransactionPreviewData , count: 10)
