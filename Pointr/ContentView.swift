//
//  ContentView.swift
//  Pointr
//
//  Created by Olgu SIRMAN on 23/03/2023.
//

import SwiftUI

struct ContentView: View {

    @State private var showingSheet = false

    var body: some View {
        Button("Show Logger") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            LogView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
