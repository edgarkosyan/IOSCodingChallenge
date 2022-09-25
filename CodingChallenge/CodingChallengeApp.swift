//
//  CodingChallengeApp.swift
//  CodingChallenge
//
//  Created by Edgar on 24.09.22.
//

import SwiftUI

@main
struct CodingChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ProductsListView(viewModel: ProductsListViewModel())
        }
    }
}
