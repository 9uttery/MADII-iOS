//
//  RecordView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct RecordView: View {
    @State private var myNewJoy: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            title
                .padding(.horizontal, 22)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("나만의 소확행을 수집해보세요")
                    .madiiFont(font: .madiiSubTitle, color: .white)
                
                HStack(spacing: 0) {
                    TextField("누워서 빗소리 감상하기", text: $myNewJoy)
                        .madiiFont(font: .madiiBody3, color: .white, withHeight: true)
                    
                    Button {
                        
                    } label: {
                        Rectangle()
                            .frame(width: 36, height: 36)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                // FIXME: Color System에 없는 색상 -> 추후 추가해서 넣기
                .background(Color(red: 0.21, green: 0.22, blue: 0.29))
                .cornerRadius(6)
            }
            .padding(20)
            // FIXME: Color System에 없는 색상 -> 추후 추가해서 넣기
            .background(Color(red: 0.1, green: 0.1, blue: 0.15))
            .cornerRadius(20)
            .padding(.horizontal, 16)
            
            Spacer()
        }
    }
    
    var title: some View {
        HStack(spacing: 0) {
            Text("레코드")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.vertical, 12)
            
            Spacer()
        }
    }
}

#Preview {
    RecordView()
}
