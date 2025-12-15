//
//  ServiceTermView_P3.swift
//  Madii
//
//  Created by Anjin on 12/14/25.
//

import SwiftUI

struct ServiceTermView_P3: View {
    @Environment(SignUpViewModel.self) var viewModel
    var isAllTermAgreed: Bool { viewModel.agreeStatus.values.allSatisfy { $0 } }
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("서비스 이용 동의서")
                    .madiiFont(.title2)
                    .foregroundStyle(Color.madiiNormal)
                Spacer()
            }
            .padding(.horizontal, 4)
            
            VStack(spacing: 20) {
                HStack(spacing: 12) {
                    Button {
                        for term in ServiceTerm.allCases {
                            viewModel.agreeStatus[term] = true
                        }
                    } label: {
                        if isAllTermAgreed {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .frame(width: 28, height: 28)
                                .foregroundStyle(Color.madiiLime)
                        } else {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .frame(width: 23, height: 23)
                                .frame(width: 28, height: 28)
                                .foregroundStyle(Color.madiiAlternative)
                        }
                        
                        Text("전체 동의")
                            .madiiFont(.subTitle)
                            .foregroundStyle(Color.madiiNeutral)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 12)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color.madiiAlternative)
                }
                
                ForEach(ServiceTerm.allCases, id: \.self) { term in
                    TermRow_P3(
                        term: term,
                        isAgreed: viewModel.agreeStatus[term] ?? false
                    ) {
                        viewModel.agreeStatus[term]?.toggle()
                    }
                }
            }
            
            Spacer()
        }
    }
}
