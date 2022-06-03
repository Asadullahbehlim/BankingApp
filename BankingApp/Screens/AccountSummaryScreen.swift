//
//  AccountSummaryScreen.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 03/06/22.
//

import SwiftUI

struct AccountSummaryScreen: View {
 @ObservedObject private var AccountSummaryVM : AccountSummaryViewModel = AccountSummaryViewModel()
    
    var body: some View {
        VStack {
        GeometryReader { g in
            VStack{
                AccountListView(accounts: AccountSummaryVM.accounts)
                    .frame(height: g.size.height/2)
                Text("\(self.AccountSummaryVM.total.formatAsCurrency())")
                Spacer()
            }
            
        }
        }
       .onAppear(){
                self.AccountSummaryVM.getAllAccounts()
            }
            .navigationTitle("Account Summary")
            .embedInNavigationView()
            
        }
    }


struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}

