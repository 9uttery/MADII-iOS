//
//  ArchivingView.swift
//  Madii
//
//  Created by 정태우 on 9/24/25.
//

import SwiftUI

struct ArchivingView: View {
    var body: some View {
        VStack {
            HStack {
                Text("아카이빙")
                    .madiiFont(font: .madiiTitle, color: .madiiAlternative)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("myPage")
                        .resizable()
                        .frame(width: 28, height: 28)
                }
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            Image("archivingClover")
                .resizable()
                .frame(width: 120, height: 120)
            
            Text("새로운 기능이 곧\n업데이트될 예정이에요!")
                .madiiFont(font: .madiiSubTitle, color: .madiiNeutral)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ArchivingView()
}
