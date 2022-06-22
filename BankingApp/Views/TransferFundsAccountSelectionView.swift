//
//  TransferFundsAccountSelectionView.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 22/06/22.
//

import SwiftUI

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
            Spacer()
        }.padding()
    
}
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}

