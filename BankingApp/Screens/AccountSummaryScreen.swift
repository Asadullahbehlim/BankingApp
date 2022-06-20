//
//  AccountSummaryScreen.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 03/06/22.
//

import SwiftUI

enum ActiveSheet {
    case addAccount
    case transferFunds
}
struct AccountSummaryScreen: View {
 @ObservedObject private var AccountSummaryVM : AccountSummaryViewModel = AccountSummaryViewModel()
    @State private var isPresented:Bool = false
    @State private var activeSheet: ActiveSheet = .addAccount
   
    var body: some View {
        VStack {
        GeometryReader { g in
            VStack{
                AccountListView(accounts: AccountSummaryVM.accounts)
                    .frame(height: g.size.height/2)
                Text("\(self.AccountSummaryVM.total.formatAsCurrency())")
                Spacer()
                Button("Transfer Funds") {
                    activeSheet = .transferFunds
                    isPresented = true
                }.padding()
            }
            
        }
        }
       .onAppear{
                self.AccountSummaryVM.getAllAccounts()
            }
       .sheet(isPresented: $isPresented, onDismiss: {
           // Get All Accounts
           self.AccountSummaryVM.getAllAccounts()
       }) {
           if activeSheet == .transferFunds {
               TransferFundsScreen()
           }
           else if activeSheet == .addAccount {
               AddAccountScreen()
           }
          
       }
       .navigationBarItems(trailing: Button("Add Account")
        {
           self.activeSheet = .addAccount
           self.isPresented = true
           
       })
            .navigationTitle("Account Summary")
            .embedInNavigationView()
            
        }
    }

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}

