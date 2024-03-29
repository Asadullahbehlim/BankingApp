//
//  AddAccountScreen.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 10/06/22.
//
//
import SwiftUI

struct AddAccountScreen: View {
    // MARK: - Property
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addAccountVM = AddAccountViewModel()


    // MARK: - Body
    var body: some View {
        Form {
            TextField("Name", text: $addAccountVM.name)

            Picker(selection: $addAccountVM.accountType, label: EmptyView()) {
                ForEach (AccountType.allCases,id: \.self) {
                    AccountType in
                    Text(AccountType.title).tag(AccountType)
                }
            }
            .pickerStyle(.segmented)

            TextField("Balance", text: $addAccountVM.balance)
            HStack {
                Spacer()
                Button("Submit") {
                    self.addAccountVM.createAccount { success in
                        if success {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                Spacer()
            }
            Text(self.addAccountVM.errorMessage)
        }
        .navigationBarTitle("Add Account")
        .embedInNavigationView()

}
}

struct AddAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountScreen()
    }
}




