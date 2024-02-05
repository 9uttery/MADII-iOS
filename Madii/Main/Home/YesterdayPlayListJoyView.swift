//
//  YesterdayPlayListJoyView.swift
//  Madii
//
//  Created by 정태우 on 1/31/24.
//

import SwiftUI

struct YesterdayPlayListJoyView: View {
    @State var joyYesterdayPlayList: [Joy] = Joy.yesterdayPlayListDummy
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
        Text("2024.01.13")
            .madiiFont(font: .madiiSubTitle, color: .white)
            .padding(.bottom, 11.5)
        ForEach(joyYesterdayPlayList.indices, id: \.self) { index in
            let joy = joyYesterdayPlayList[index]
            HStack {
                Image("")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(90)
                    .padding(.trailing, 14.5)
                Text(joy.title)
                    .madiiFont(font: .madiiBody3, color: .white)
                Spacer()
                Button {
                    joyYesterdayPlayList[index].isCompleted.toggle()
                } label: {
                    if joy.isCompleted {
                        Image("check")
                            .resizable()
                            .frame(width: 28, height: 28)
                    } else {
                        Image("plus")
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                }
            }
            .frame(height: 56)
        }
    }
    .roundBackground()
    }
}

#Preview {
    YesterdayPlayListJoyView()
}
