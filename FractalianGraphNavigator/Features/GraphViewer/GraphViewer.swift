//
//  GraphViewer.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 31/01/2024.
//

import SwiftUI

struct GraphViewer: View {

    @State var contacts = [
        "John",
        "Alice",
        "Bob",
        "Foo",
        "Bar"
    ]

    var body: some View {
        List {
            ForEach(contacts, id: \.self) { contact in
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(contacts, id: \.self) { contact in
                                Text(contact)
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 5)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                self.contacts.append(contentsOf: ["1", "2", "3"])
            })
        })
    }
}

#Preview {
    GraphViewer()
}
