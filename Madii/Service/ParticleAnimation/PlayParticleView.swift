//
//  PlayParticleView.swift
//  PracticeAnimation
//
//  Created by 이안진 on 12/21/23.
//

import SwiftUI

struct PlayParticleView: View {
    @State var counter = 0
    
    var body: some View{
        ZStack {
            Text("🎉").onTapGesture { counter += 1 }

            /* Default */
            ParticleView(counter: $counter)
        }
    }
}

#Preview {
    PlayParticleView()
}
