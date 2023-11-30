//
//  HomeView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                NavigationLink {
                    Text("홈에서 넘어온 화면")
                } label: {
                    Text("home")
                }
                    
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
