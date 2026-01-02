//
//  MadiiNavigationBar_P3.swift
//  Madii
//
//  Created by 정태우 on 10/1/25.
//

import SwiftUI

struct MadiiNavigationBar_P3: View {
    @Environment(Router.self) var router
    
    @State var title: String = ""
    @State var popNum: Int = 1
    var body: some View {
        ZStack {
            HStack {
                Button {
                    router.pop(times: popNum)
                } label: {
                    Image(.arrowBack)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .colorMultiply(.madiiAlternative)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    MadiiNavigationBar_P3()
}
