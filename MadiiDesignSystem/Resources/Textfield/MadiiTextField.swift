//
//  MadiiTextField.swift
//  MadiiDesignSystem
//
//  Created by 정태우 on 8/7/25.
//

import SwiftUI

public enum TextFieldType {
    case basic, active, error, complete
}

public struct MadiiTextField: View {
    @Binding public var type: TextFieldType
    @Binding public var text: String
    @State public var isPlus: Bool = false
    @State public var originType: TextFieldType = .basic
    public let placeholder: String
    @FocusState private var isTextFieldFocused: Bool
    public var isSecureTextField: Bool
    public let action: (() -> Void)?
    
    public init(
        type: Binding<TextFieldType> = .constant(.basic),
        text: Binding<String>,
        isPlus: Bool = false,
        placeholder: String,
        isSecureTextField: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self._type = type
        self._text = text
        self.isPlus = isPlus
        self.placeholder = placeholder
        self.isSecureTextField = isSecureTextField
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            if isPlus {
                Button {
                    isTextFieldFocused = false
                    action?()
                } label: {
                    Image("plusSquare")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(text.isEmpty ? .secondary : Color.madiiNeutral)
                }
            }
            
            if isSecureTextField {
                SecureField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .madiiFont(.body2)
                            .foregroundStyle(.secondary)
                    }
                    .madiiFont(.body2)
                    .foregroundStyle(.madiiNeutral)
                    .frame(maxWidth: .infinity)
                    .frame(height: 26)
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        if isPlus {
                            action?()
                        }
                    }
            } else {
                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .madiiFont(.body2)
                            .foregroundStyle(.secondary)
                    }
                    .madiiFont(.body2)
                    .foregroundStyle(.madiiNeutral)
                    .frame(maxWidth: .infinity)
                    .frame(height: 26)
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        if isPlus {
                            action?()
                        }
                    }
            }
        }
        .padding(12)
        .background(.madiiGray30)
        .cornerRadius(12)
        .roundedBorder(cornerRadius: 12, color: borderColor())
        .onAppear {
            originType = type
        }
        .onChange(of: isTextFieldFocused) {
            if isTextFieldFocused {
                type = .active
            } else {
                type = originType
            }
        }
    }
    
    func borderColor() -> Color {
        switch type {
        case .basic: .clear
        case .active: .madiiGreen100
        case .error: .madiiNegative
        case .complete: .madiiLime
        }
    }
}

public extension View {
    func roundedBorder(cornerRadius: CGFloat, color: Color, lineWidth: CGFloat = 1) -> some View {
        self
            .cornerRadius(cornerRadius)
            .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: lineWidth)
        )
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    MadiiTextField(type: .constant(.basic), text: .constant(""), placeholder: "ㅏ너ㅣㅏㄹ")
}
