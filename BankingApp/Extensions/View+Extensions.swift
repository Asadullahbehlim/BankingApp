//
//  View+Extensions.swift
//  BankingApp
//
//  Created by Asadullah Behlim on 02/06/22.
//

import Foundation
import SwiftUI

extension View {
    
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
    
    
}
