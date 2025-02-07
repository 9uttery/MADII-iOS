//
//  JoyAPI.swift
//  MadiiNetworking
//
//  Created by Anjin on 2/1/25.
//

import Foundation

public struct JoyAPI {
    /// 오늘의 소확행
    public func getTodayJoy() async -> Result<GetTodayJoyResponseDTO, Error> {
        // URL 생성: Info.plist에 등록된 BASE_URL에서 값을 읽어옵니다.
        guard let url = URL(string: "https://" + NetworkConfig.baseURL + "/v1/joy/today") else {
            let error = NSError(domain: "JoyAPI",
                                code: -1,
                                userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return .failure(error)
        }
        
        let dummy1 = GetTodayJoyResponseDTO(joyId: 0, joyIconNum: 0, contents: "dummy")
        
        do {
            // URLSession의 async API를 사용하여 데이터를 가져옵니다.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let responseObject = try JSONDecoder().decode(BaseResponse<GetTodayJoyResponseDTO>.self, from: data)
            return .success(responseObject.data ?? dummy1)
            
        } catch {
            let dummy = GetTodayJoyResponseDTO(joyId: 0, joyIconNum: 0, contents: "\(error)")
            print("이거링 \(error)")
            return .success(dummy)
        }
    }
}
