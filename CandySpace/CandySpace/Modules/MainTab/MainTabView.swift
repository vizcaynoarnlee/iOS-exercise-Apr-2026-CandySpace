//
//  MainTabView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var tabRouter = TabRouter()
    
    var body: some View {
        TabView(selection: $tabRouter.selectedIndex) {
            ForEach(tabRouter.tabs) { tab in
                Tab(tab.title, systemImage: tab.systemImage, value: tab.id) {
                    viewForTab(tab)
                }
            }
        }
        .tint(.red)
        .environmentObject(tabRouter)
    }
    
    func viewForTab(_ index: TabType) -> some View {
        Group {
            switch index {
            case .cards:
                DashboardView()
            
            case .profile:
                ProfileView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
