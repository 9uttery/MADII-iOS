//
//  MadiiToast.swift
//  MadiiDesignSystem
//
//  Created by 정태우 on 7/1/25.
//

import SwiftUI

public enum ToastType {
    case complete, error
}

public struct MadiiToast: View {
    public let type: ToastType
    public let title: String
    @Binding public var isShowToast: Bool
    
    public init(type: ToastType = .complete, title: String, isShowToast: Binding<Bool>) {
        self.type = type
        self.title = title
        self._isShowToast = isShowToast
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            Image(type == .complete ? "checkFillLime" : "exclamationCircle")
                .resizable()
                .frame(width: 28, height: 28)
            
            Text(title)
                .madiiFont(.body3)
                .foregroundStyle(.madiiElevated)
        }
        .padding(.vertical, 12)
        .padding(.leading, 20)
        .padding(.trailing, 28)
        .background(.madiiStrong)
        .cornerRadius(90)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isShowToast = false
            }
        }
        .onChange(of: isShowToast) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isShowToast = false
            }
        }
    }
}

#Preview {
    MadiiToast(type: .complete, title: "안녕하세요", isShowToast: .constant(false))
}
