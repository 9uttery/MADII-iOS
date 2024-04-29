//
//  FileAPI.swift
//  Madii
//
//  Created by 이안진 on 2/18/24.
//

import Alamofire
import KeychainSwift
import SwiftUI

class FileAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")/v1"
    static let shared = FileAPI()
 
    // 이미지 파일 업로드
    func uploadImageFile(image: UIImage, completion: @escaping (_ isSuccess: Bool, _ url: String) -> Void) {
        let url = "\(baseUrl)/file/upload"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")",
            "Content-Type": "multipart/form-data"
        ]
        
//        guard let pngimage = image.pngData() else { return }
        let resizedImage = image.resize(newSize: 150)
        guard let image = resizedImage.pngData() else {
            print("image png 처리 실패")
            completion(false, "")
            return
        }
        
        // Multipart Form 데이터 생성
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image, withName: "image", fileName: "\(image).png", mimeType: "image/png")
        }, to: url, method: .post, headers: headers)
            .responseDecodable(of: BaseResponse<FileUploadResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG(upload image file) success response: \(response.code)")
                    completion(true, response.data?.url ?? "")
                
                case .failure(let error):
                    print("DEBUG(upload image file) error: \(error)")
                    completion(false, "")
                }
            }
    }
}

struct FileUploadResponse: Codable {
    let url: String
}

extension UIImage {
    func resize(newSize: CGFloat) -> UIImage {
        let biggerSize = max(self.size.width, self.size.height)
        let scale = newSize / biggerSize
        let newWidth = self.size.width * scale
        let newHeight = self.size.height * scale

        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        
        return renderImage
    }
}
