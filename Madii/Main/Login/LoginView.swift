//
//  LoginView.swift
//  Madii
//
//  Created by 이안진 on 12/27/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            HStack { Spacer() }
            Spacer()
            
            Button {
                print("\(Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? "")")
            } label: {
                Text("카카오 로그인")
                    .font(.title.bold())
            }
            
            Spacer()
        }
        .background( background() )
    }
    
    func background() -> LinearGradient {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.09, green: 0.09, blue: 0.15), location: 0.00),
                Gradient.Stop(color: Color(red: 0.42, green: 0.44, blue: 0.68), location: 1.00)
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
    }
}

#Preview {
    LoginView()
}
