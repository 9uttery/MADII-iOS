//
//  TermRow_P3.swift
//  Madii
//
//  Created by Anjin on 12/14/25.
//

import SwiftUI

struct TermRow_P3: View {
    let term: ServiceTerm
    let isAgreed: Bool
    var toggleAction: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Button {
                 toggleAction()
            } label: {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .frame(width: 28, height: 28)
                    .foregroundStyle(isAgreed ? Color.madiiLime : Color.madiiAlternative)
                
                Text(term.title)
                    .madiiFont(.body2)
                    .foregroundStyle(Color.madiiNormal)
            }
            
            Spacer()
            
            if let urlString = term.urlString {
                Button {
                    if let url = URL(string: urlString) {
                        UIApplication.shared.open(url)
                        AnalyticsManager.shared.logEvent(name: "서비스이용약관뷰_\(term.title.replacingOccurrences(of: " ", with: "_"))보기클릭")
                    }
                } label: {
                    Text("보기")
                        .madiiFont(.body3)
                        .foregroundStyle(Color.madiiAlternative)
                        .contentShape(.rect)
                }
            }
        }
    }
}
