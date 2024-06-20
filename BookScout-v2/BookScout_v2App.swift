//
//  BookScout_v2App.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import SwiftUI

@main
struct BookScout_v2App: App {
    @StateObject private var appState = GenreSelectionViewModel()
    
    @State var isAppLoaded: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isAppLoaded {
                if appState.userDefaultsEmpty {
                    GenreSelectionView(viewModel: appState, states: .firstOpen)
                } else {
                    TabViewMain(appState: appState)
                }
            } else {
                LaunchScreen()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isAppLoaded = true
                        }
                    }
                }
            }
        }
    }

}
