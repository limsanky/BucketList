//
//  EditView.swift
//  BucketList
//
//  Created by Sankarshana V on 2022/02/07.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: EditView.ViewModel
    var onSave: (Location) -> Void
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        self.viewModel = EditView.ViewModel(location: location)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby..") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    
                    dismiss()
                }
            }
            
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}
