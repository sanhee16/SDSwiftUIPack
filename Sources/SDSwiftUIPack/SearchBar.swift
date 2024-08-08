//
//  File.swift
//  
//
//  Created by sandy on 7/31/24.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    enum SearchBarType {
        case back(onClickBack: ()->())
        case search
        case none
    }
    var text: Binding<String>
    var placeholder: String
    var onSearch: ((String)->())?
    var onChange: ((String)->())?
    var onRemoveAll: (()->())?
    let type: SearchBarType
    
    init(_ placeholder: String = "검색", text: Binding<String>, type: SearchBarType) {
        self.placeholder = placeholder
        self.text = text
        self.type = type
    }
    
    var body: some View {
        HStack {
            switch self.type {
            case .back(let onBack):
                Image(systemName: "arrow.backward")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        onBack()
                    }
            case .search:
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            case .none:
                EmptyView()
            }
            
            TextField(
                placeholder,
                text: text,
                prompt: Text(placeholder).foregroundColor(Color.gray)
            )
            .accentColor(.primary)
            .foregroundColor(.black)
            .font(.sys15r)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .onSubmit {
                onSearch?(text.wrappedValue)
            }
            .onChange(of: text.wrappedValue, perform: { value in
                onChange?(text.wrappedValue)
            })
            
            if !text.wrappedValue.isEmpty {
                Button(action: {
                    self.text.wrappedValue = ""
                    self.onRemoveAll?()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            } else {
                EmptyView()
            }
        }
        .padding(EdgeInsets(top: 11, leading: 13, bottom: 11, trailing: 13))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
        .padding(.horizontal)
    }
}

extension SearchBar {
    func onChange(_ onChange: ((String)->())?) -> SearchBar {
        var searchBar = self
        searchBar.onChange = onChange
        return searchBar
    }
    
    func onSearch(_ onSearch: ((String)->())?) -> SearchBar {
        var searchBar = self
        searchBar.onSearch = onSearch
        return searchBar
    }
    
    func onRemoveAll(_ onRemoveAll: (()->())?) -> SearchBar {
        var searchBar = self
        searchBar.onRemoveAll = onRemoveAll
        return searchBar
    }
}

