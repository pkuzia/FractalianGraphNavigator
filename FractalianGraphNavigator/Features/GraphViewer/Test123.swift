//
//  Test123.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 02/02/2024.
//

import SwiftUI

class MyDataModel: ObservableObject {
    @Published var model: MyDataModelX? = MyDataModelX(items: [MyDataModelDetails(title: "Old")])
}

class MyDataModelX: ObservableObject {
    @Published var items: [MyDataModelDetails]

    init(items: [MyDataModelDetails]) {
        self.items = items
    }
}

class MyDataModelDetails: ObservableObject {
    var title: String

    init(title: String) {
        self.title = title
    }
}


struct ContentView12: View {
    @EnvironmentObject var dataModel: MyDataModel

    var body: some View {
        NavigationView {
            List {
                ForEach(dataModel.model?.items ?? [], id: \.title) { item in
                    Text(item.title)
                }
            }
            .navigationTitle("Items List")
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                dataModel.model?.items.append(MyDataModelDetails(title: "New"))
                dataModel.objectWillChange.send()
            })
        })
    }
}
