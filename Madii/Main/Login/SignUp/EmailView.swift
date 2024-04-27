//
//  EmailView.swift
//  Madii
//
//  Created by 이안진 on 1/29/24.
//

import Combine
import SwiftUI

class TextFieldObserver: ObservableObject {
    @Published var debouncedText = ""
    @Published var searchText = ""

    private var subscriptions = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                self?.debouncedText = text
            })
            .store(in: &subscriptions)
    }
}

struct EmailView: View {
    @EnvironmentObject private var signUpStatus: SignUpStatus
    
    @StateObject private var textFieldObserver = TextFieldObserver()
    private var cancellable: AnyCancellable?

    enum IdType { case none, correct, wrong, possible, impossible }
    @State private var idType: IdType = .none
    var helperMessage: String {
        switch idType {
        case .none, .correct, .wrong: "올바른 이메일 형식이 아니에요"
        case .possible: "사용할 수 있는 이메일이에요"
        case .impossible: "이미 가입된 계정이에요"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("이메일을 입력해 주세요")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
                .padding(.bottom, 14)
                .padding(.horizontal, 18)

            MadiiTextField(placeHolder: "이메일을 입력하세요",
                           text: $textFieldObserver.searchText, strokeColor: strokeColor(idType))
                .textFieldHelperMessage(helperMessage, color: strokeColor(idType))
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 25)
                .onChange(of: textFieldObserver.searchText) { checkIdVaild($0) }
                .onReceive(textFieldObserver.$debouncedText) { checkIdDuplicated($0) }
            
            Spacer()
            
            Button {
                // id 저장
                signUpStatus.id = textFieldObserver.searchText
                print("email 저장 \(textFieldObserver.searchText)")
                
                signUpStatus.count += 1
            } label: {
                MadiiButton(title: "다음", size: .big)
                    .opacity(idType == .possible ? 1.0 : 0.4)
            }
            .disabled(idType != .possible)
            .padding(.horizontal, 18)
            .padding(.bottom, 24)
        }
    }

    private func isValidInput(_ text: String) -> Bool {
        // 정규식을 사용하여 공백 없이 대소문자 영문자 및 숫자만 허용하는지 체크
//        let pattern = "^[a-zA-Z0-9]*$"
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return text.range(of: pattern, options: .regularExpression) != nil
    }
    
    // 아이디 형식 체크
    private func checkIdVaild(_ id: String) {
        if id.isEmpty {
            idType = .none
        } else if isValidInput(id) {
            idType = .correct
        } else {
            idType = .wrong
        }
    }
    
    // 아이디 중복 체크
    private func checkIdDuplicated(_ id: String) {
        // id 형식이 올바를 때만 중복 체크
        if idType == .correct {
            if id.isEmpty {
                // 비어 있으면 none
                idType = IdType.none
            } else {
                UsersAPI.shared.getIdCheck(id: id) { isSuccess, canUseID in
                    if isSuccess && canUseID {
                        // api 통신 성공 && 아이디 사용 가능
                        idType = IdType.possible
                    } else {
                        // api 통신 오류 || 아이디 사용 불가능
                        idType = IdType.impossible
                    }
                }
            }
        }
    }

    private func strokeColor(_ type: IdType) -> Color {
        switch type {
        case .none, .correct: Color.gray700
        case .wrong, .impossible: Color.madiiOrange
        case .possible: Color.madiiYellowGreen
        }
    }
}

#Preview {
    EmailView()
}
