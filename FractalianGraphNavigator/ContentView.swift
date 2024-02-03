//
//  ContentView.swift
//  FractalianGraphNavigator
//
//  Created by Przemysław Kuzia on 27/01/2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView1: View {
    @State private var graphFileReader = GraphFileReader()
    @State private var isFilePickerPresented = false

    @State private var text: String = ""
    @State private var text1: String = ""

    var body: some View {
        VStack {
            Text(text)
            Text(text1)
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
            let start = CFAbsoluteTimeGetCurrent()

//            let x123 = RandomGraphGenerator()
//            let graph = x123.generateGraph(nodes: 10, maxEdgesPerNode: 5)

//            // Przykład użycia
//            let vertices = 20000
//            let edgesPerVertex = 1000
//            let generator = ModifiedBarabasiAlbertGraphGenerator(vertices: vertices, maxEdgesPerVertex: edgesPerVertex)
//            let generatedGraph = generator.getGraph()

            let diff = CFAbsoluteTimeGetCurrent() - start
            text = "Took \(diff) seconds"

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
    ContentView1()
}
