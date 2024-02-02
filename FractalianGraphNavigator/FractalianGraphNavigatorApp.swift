//
//  FractalianGraphNavigatorApp.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 27/01/2024.
//

import SwiftUI

@main
struct FractalianGraphNavigatorApp: App {
    
    private let graphManager = GraphManager()

    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(graphManager)
            //            GraphViewer()
        }
    }

    //    let dataModel = MyDataModel()
    //
    //    var body: some Scene {
    //        WindowGroup {
    //            ContentView12()
    //                .environmentObject(dataModel)
    //        }
    //    }
}
