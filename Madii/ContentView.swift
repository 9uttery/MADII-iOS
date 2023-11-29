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
                .foregroundStyle(.gray800)
            
            Text("madiiTitle")
                .madiiFont(font: .madiiTitle, color: .white)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
