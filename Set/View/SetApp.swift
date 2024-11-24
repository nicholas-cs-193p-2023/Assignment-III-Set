//
//  SetApp.swift
//  Set
//
//  Created by Nicholas Alba on 8/24/24.
//

import SwiftUI

@main
struct SetApp: App {
    @StateObject var viewModel = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: viewModel)
        }
    }
}
