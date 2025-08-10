//
//  MadiiToast.swift
//  MadiiDesignSystem
//
//  Created by 정태우 on 7/1/25.
//

import SwiftUI

enum ToastType {
    case complete, error
}

struct MadiiToast: View {
    let type: ToastType
    let title: String
    @Binding var isShowToast: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(type == .complete ? "checkFillLime" : "exclamationCircle")
                .resizable()
                .frame(width: 28, height: 28)
            Text(title)
        }
        .padding(.vertical, 12)
        .padding(.leading, 20)
        .padding(.trailing, 28)
        .background(.madiiStrong)
        .cornerRadius(16)
    }
}

#Preview {
    MadiiToast(type: .complete, title: "toastMessage", isShowToast: .constant(false))
}
