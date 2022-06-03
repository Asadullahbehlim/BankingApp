//
//  AccountListView.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 03/06/22.
//

import SwiftUI

struct AccountListView: View {
    
    let accounts: [AccountViewModel]
    var body: some View {
        List(accounts, id: \.accountId) { item in
           
            HStack{
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.name)
                        .font(.headline)
                    
                    Text(item.accountType)
                        .opacity(0.5)
                    
                }
                Spacer()
                Text(item.balance.formatAsCurrency())
                    .foregroundColor(.green)
                
            }
        }
    }
}
struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView(accounts: [AccountViewModel(account:Account(id:UUID(), name:"Isha", balance: 5000, accountType:.checking)),AccountViewModel(account:Account(id:UUID(), name:"Jaya", balance: 5000, accountType:.checking))])
    }
}
