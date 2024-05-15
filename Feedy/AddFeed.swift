//
//  AddFeed.swift
//  Feedy
//
//  Created by Ivana Rast on 16.05.2024.
//

import SwiftUI

struct AddFeed: View {
    @Binding var isPresented: Bool
    @State private var feedURL = ""
    @State private var isAddButtonDisabled = true
    
    var onFeedAdded: (String) -> Void

    var body: some View {
        VStack {
            TopBar
            URLInput
            Spacer()
        }
    }
    
    private var TopBar: some View {
        HStack {
            Button("Cancel") {
                isPresented = false
            }
            .padding()
            
            Spacer()
            
            Text("Add RSS Feed")
            
            Spacer()
            
            Button("Add") {
                finish()
            }
            .disabled(isAddButtonDisabled)
            .padding()
        }
    }
    
    private var URLInput: some View {
        TextField("Enter RSS feed URL", text: $feedURL)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textInputAutocapitalization(.never)
            .textContentType(.URL)
            .keyboardType(.URL)
            .padding()
            .onChange(of: feedURL) {
                isAddButtonDisabled = false
            }
            .onSubmit {
                finish()
            }
    }
    
    private func finish() {
        onFeedAdded(feedURL)
        isPresented = false
    }
}
