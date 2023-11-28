//
//  ContentView.swift
//  Madii
//
//  Created by 이안진 on 11/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("madiiTitle")
                .madiiFont(font: .madiiTitle, color: .black)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
