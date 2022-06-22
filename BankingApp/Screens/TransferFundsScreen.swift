
//
//  TransferFundsScreen.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 17/06/22.
//


import SwiftUI

struct TransferFundsScreen: View {
    // MARK: - property
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var TransferFundsVM = TransferFundsViewModel()
    @State private var showSheet: Bool = false
    @State private var isFromAccount: Bool = false
    
    var actionSheetButton: [Alert.Button] {
    var actionButtons = TransferFundsVM.filteredAccounts.map {
           account in
        Alert.Button.default(Text("\(account.name)(\(account.accountType))")) {
            if self.isFromAccount {
                TransferFundsVM.fromAccount = account
            }
            else { self.TransferFundsVM.toAccount = account
                
            }
        }
    }
        actionButtons.append(.cancel())
        return actionButtons
    }

    // MARK: - Body
    var body: some View {
        ScrollView {
        VStack {
            AccountListView(accounts: TransferFundsVM.accounts)
                .frame(height: 200)
            
            TransferFundsAccountSelectionView(TransferFundsVM: TransferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount)
           Spacer()
            .onAppear {
                TransferFundsVM.populateAccounts()
            }
           Text(self.TransferFundsVM.message ?? "")
            
            Button("Submit Transfer") {
                self.TransferFundsVM.submitTransfer {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            }.padding()
                
                .actionSheet(isPresented: $showSheet) {
                ActionSheet(title: Text("Transfer Funds"), message: Text("Choose an account"), buttons:self.actionSheetButton)
        }
            
        }
        }.navigationTitle("Transfer Funds")
        .embedInNavigationView()
       
            
        }
    
    }
