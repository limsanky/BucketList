//
//  BucketListApp.swift
//  BucketList
//
//  Created by Sankarshana V on 2022/02/07.
//

import SwiftUI

@main
struct BucketListApp: App {
    @StateObject private var viewModel = ContentView.ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
