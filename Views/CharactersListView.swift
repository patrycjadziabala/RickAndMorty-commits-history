//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Patka on 08/09/2023.
//

import SwiftUI

struct CharactersListView: View {
    
    @ObservedObject var viewModel: CharactersListViewModel
    @EnvironmentObject var persistanceManager: PersistenceManager
    @State var shouldShowAlert = false
    @State var alertType: AlertType = .location
    
    enum AlertType {
        case paging
        case location
    }
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        fetchCharactersForLocationIfNeeded()
    }
    
    var body: some View {
        List {
            ForEach(viewModel.characters, id: \.id) { character in
                CharacterCellView(character: character)
            } //foreach
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    fetchNextPageIfNeeded()
                }
        } //List
        .alert(isPresented: $shouldShowAlert, content: {
            getAlert()
        })
    }
    
    func getAlert() -> Alert {
        switch alertType {
        case .paging:
            return getAlertForPaging()
        case .location:
           return getAlertForLocationMode()
        }
    }
    
    func getAlertForPaging() -> Alert {
        Alert(title: Text("Something went wrong..."),
              primaryButton: .default(Text("Retry"), action: {
            fetchNextPageIfNeeded()
        }),
              secondaryButton: .cancel(Text("Cancel"), action: {
            shouldShowAlert = false
        }))
    }
    
    func getAlertForLocationMode() -> Alert {
        Alert(title: Text("Something went wrong..."),
              primaryButton: .default(Text("Retry"), action: {
            fetchCharactersForLocationIfNeeded()
        }),
              secondaryButton: .cancel(Text("Cancel"), action: {
            shouldShowAlert = false
        }))
    }
    
    func fetchNextPageIfNeeded() {
        Task {
            do {
                try await viewModel.fetchNextPageIfNeeded()
            } catch {
                alertType = .paging
                shouldShowAlert = true
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCharactersForLocationIfNeeded() {
        Task {
            do {
                try await viewModel.fetchCharactersForLocationIfNeeded()
            } catch {
                alertType = .location
                shouldShowAlert = true
                print(error.localizedDescription)
            }
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager(), listMode: .allCharacters))
    }
}
