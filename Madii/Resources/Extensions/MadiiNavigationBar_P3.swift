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
    var body: some View {
        HStack {
            Button {
                router.pop()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.madiiAlternative)
            }
            Spacer()
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MadiiNavigationBar_P3()
}
