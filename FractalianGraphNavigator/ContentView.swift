//
//  ContentView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 27/01/2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var graphFileReader = GraphFileReader()
    @State private var isFilePickerPresented = false

    @State private var text: String = ""
    @State private var text1: String = ""

    var body: some View {
        VStack {
            Text(text)
            Text(text1)
//                .foregroundc
//            Button("Wybierz plik") {
//                isFilePickerPresented.toggle()
//            }
//            .fileImporter(
//                isPresented: $isFilePickerPresented,
//                allowedContentTypes: [UTType.xml],
//                onCompletion: handleFileSelection
//            )
//            .padding()

//            if let loadedGraph = graphFileReader.graph {
//                Text("Liczba węzłów w grafie: \(loadedGraph.nodes.count)")
//            }
        }
        .onAppear(perform: {
//            let start = CFAbsoluteTimeGetCurrent()
//            let acyclicGenerator = DirectedGraphGenerator()
//            let graph = acyclicGenerator.generateDAG()
//            let diff = CFAbsoluteTimeGetCurrent() - start
//            text = "Took \(diff) seconds"
//
//            if let node = graph.nodes.randomElement()?.value {
//                text1 = "Random element: \(node.value) \n Number of neibours: \(node.neighbors.count)"
//            }
        })
    }


    private func handleFileSelection(result: Result<URL, Error>) {
        switch result {
        case .success(let selectedURL):
            do {
//                try graphFileReader.readGraphFromFile(atPath: selectedURL.path)
//                let graph = graphFileReader.graph
//                print(graph.nodes.count)
            } catch {
                print("Błąd podczas wczytywania pliku: \(error)")
            }
        case .failure(let error):
            print("Błąd podczas wybierania pliku: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
