//
//  RootTabView.swift
//

import SwiftUI

struct RootTabView: View {
    
    @State private var selectedTab: RootTabViewModelState = .headlines
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HeadlinesView()
                .tabItem {
                    Label("Headlines", systemImage: "newspaper")
                }
                .tag(RootTabViewModelState.headlines)
            
            SourcesView()
                .tabItem {
                    Label("Sources", systemImage: "list.bullet.rectangle")
                }
                .tag(RootTabViewModelState.source)
            
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
                .tag(RootTabViewModelState.saved)
        }
    }
}

