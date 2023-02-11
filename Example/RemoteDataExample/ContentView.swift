//
//  ContentView.swift
//  RemoteDataExample
//
//  Created by Jakub Darowski on 11/02/2023.
//

import Combine
import SwiftUI
import RemoteData

struct ContentView: View {

    @State var remoteData: RemoteData<RDImage, URLError> = .notAsked
    @State var urlString: String = ""
    private var urlSession = URLSession(configuration: .default)
    @State var cancellable: AnyCancellable?

    var body: some View {
        VStack(spacing: 8.0) {

            switch remoteData {
            case .notAsked:
                Text("Input an image URL and press \"Load\"")
                TextField("URL", text: $urlString)
            case .loading:
                ProgressView()
            case .success(let image):
                Image(image: image)
            case .failure(let error):
                Text("Fetch failed: \(error.localizedDescription)")
            }
            HStack {
                Button("Reset", action: reset)
                Button("Load", action: fetch)
            }
        }
        .padding()
    }

    private func reset() {
        remoteData = .notAsked
        cancellable = nil
        urlString = ""
    }

    private func fetch() {
        guard let url = URL(string: urlString) else {
            remoteData = .failure(error: URLError(.badURL))
            return
        }

        remoteData = .loading
        cancellable = urlSession.dataTaskPublisher(for: url)
            .sink(receiveCompletion: {
                switch $0 {
                case .failure(let failure):
                    print(failure)
                    remoteData = .failure(error: failure)
                case .finished: ()
                }
            }, receiveValue: {
                guard let image = RDImage(data: $0.data) else {
                    remoteData = .failure(error: URLError(.cannotDecodeRawData))
                    return
                }
                remoteData = .success(value: image)
            })

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
