//
//  Search.swift
//  Money Tracker
//
//  Created by Андрей Логвинов on 1/18/24.
//

import SwiftUI
import Combine

struct Search: View {
    // MARK: - View Properties
    @State private var searchText: String = ""
    @State private var filterText: String = ""
    
    //MARK: - Combine Properties
    let searchPublisher: PassthroughSubject = PassthroughSubject<String, Never>()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    
                }
            }
            .overlay {
                ContentUnavailableView("Search Transaction", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1 : 0)
            }
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    filterText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: RunLoop.main), perform: { text in
                filterText = text
                
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
        }
    }
}

#Preview {
    Search()
}
