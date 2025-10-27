//
//  MyPageNavigationBar.swift
//  Madii
//
//  Created by Anjin on 10/27/25.
//

import SwiftUI

struct MyPageNavigationBar: View {
    @Environment(Router.self) var router
    let title: String
    
    var body: some View {
        ZStack {
            Text(title)
                .madiiFont(.subTitle)
                .frame(maxWidth: .infinity)
            
            HStack {
                Button {
                    router.pop()
                } label: {
                    Image(.arrowBack)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .colorMultiply(.madiiAlternative)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}
