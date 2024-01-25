//
//  HomeMyJoyView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomeMyJoyView: View {
    var body: some View {
        NavigationLink {
        } label: {
            HStack {
                Image("")
                    .resizable()
                    .frame(width: 48, height: 48)
                VStack(alignment: .leading) {
                    Text("나만의 취향저격 소확행 ")
                        .madiiFont(font: .madiiSubTitle, color: .white)
                    Text("나에게 꼭 맞는 소확행을 찾아보세요!")
                        .madiiFont(font: .madiiBody4, color: .gray400)
                }
                Spacer()
                Image("chevronRight")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
        }
        .roundBackground()
        .padding(.bottom, 16)
    }
}

#Preview {
    HomeMyJoyView()
}
