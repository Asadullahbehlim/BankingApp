
//
//  TransferFundsScreen.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 17/06/22.
//


import SwiftUI

struct TransferFundsScreen: View {
    // MARK: - property
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
   
        VStack {
            AccountListView(accounts: TransferFundsVM.accounts)
                .frame(height: 300)
            TransferFundsAccountSelectionView(TransferFundsVM: TransferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount)
           Spacer()
            .onAppear {
                TransferFundsVM.populateAccounts()
            }
            Button("Submit Transfer") {
                
            }.padding()
                
                .actionSheet(isPresented: $showSheet) {
                ActionSheet(title: Text("Transfer Funds"), message: Text("Choose an account"), buttons:self.actionSheetButton)
        }
            
        }.navigationTitle("Transfer Funds")
        .embedInNavigationView()
       
            
        }
    
    }

struct TransferFundsAccountSelectionView: View {
    @ObservedObject  var TransferFundsVM : TransferFundsViewModel
    
    @Binding var showSheet: Bool
    @Binding var isFromAccount: Bool
    var body: some View {
        VStack(spacing: 10) {
            Button("From \(TransferFundsVM.fromAccountType)") {
                self.isFromAccount = true
                showSheet.toggle()
            }.padding()
            .frame(maxWidth: .infinity)
            .background(.red)
            .foregroundColor(.white)
            
            Button("To \(TransferFundsVM.toAccountType)") {
                self.isFromAccount = false
                showSheet.toggle()
            }.padding()
            .frame(maxWidth:  .infinity)
            .background(.green)
            .foregroundColor(.white)
            .opacity(TransferFundsVM.fromAccount == nil ? 0.5:1.0)
            .disabled(TransferFundsVM.fromAccount == nil )
         
            TextField("Amount", text: $TransferFundsVM.amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    
}
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}

