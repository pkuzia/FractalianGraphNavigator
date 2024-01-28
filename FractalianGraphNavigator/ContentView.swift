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

    var body: some View {
        VStack {
            Button("Wybierz plik") {
                isFilePickerPresented.toggle()
            }
            .fileImporter(
                isPresented: $isFilePickerPresented,
                allowedContentTypes: [UTType.xml],
                onCompletion: handleFileSelection
            )
            .padding()

//            if let loadedGraph = graphFileReader.graph {
//                Text("Liczba węzłów w grafie: \(loadedGraph.nodes.count)")
//            }
        }
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
