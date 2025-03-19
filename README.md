# 🍀 바쁜 일상 속 나만의 일시정지 버튼, MADII

![p 1](https://github.com/user-attachments/assets/6dc5d226-1366-471a-84cb-33d8ec781631)

### 🎈 일상의 행복을 발견하는 기록 서비스

바쁜 일상 속에서 일보다 삶이 우선시 되고, 스스로를 돌보는 일을 미루고 있진 않으신가요?<br>
모두가 그저 지나쳐버리는 '나'라는 사람의 일상 속에서,<br>
나만이라도 잠시 멈춰 서서 일상을 들여다보고 작은 것이라도 무엇이 나를 행복하게 만드는지 생각해 보면 어떨까요?<br>
<br>
마디는 매일 **새로운 소확행을 추천** 받고, 다른 사람들의 **소확행을 탐색**하며, 나의 **소확행을 기록**하는 서비스입니다.<br>


[🔗 **앱스토어 바로가기**](https://apps.apple.com/kr/app/madii/id6478498142)


### 🌟 업데이트 히스토리

- 현재 최신 버전: `v1.4.0` - 2025. 02. 16. - 위젯 기능 추가
- <details>
  <summary>이전 버전 기록</summary>

  - `v1.3.1` - 2024. 12. 07.
  - `v1.3.0` - 2024. 11. 06.
  - `v1.2.0` - 2024. 08. 19.
  - `v1.1.3` - 2024. 06. 22.
  - `v1.1.2` - 2024. 06. 19.
  - `v1.1.1` - 2024. 05. 04. - 정식 출시 🎉 (홍보 시작)
  - `v1.1.0` - 2024. 04. 30.
  - `v1.0.1` - 2024. 04. 16.
  - `v1.0.0` - 2024. 03. 25. - 출시

</details>


### 📆 프로젝트 진행 기간

- 전체 기간: 2023. 08. - 진행중<br>
- 개발 기간: 2024. 11. - 진행중


### ⚙️ 기술 스택
- SwiftUI, WidgetKit
- Alamofire
- Multi-Target
- SwiftLint

<br><br>


## 📝 목차

**1. [🔥 기술적인 고민과 문제 해결](#-기술적인-고민과-문제-해결)**

**2. [🌟 주요 기능](#-주요-기능)**

**3. [💻 Git/Code Convention](#-Git/Code-Convention)**

**4. [🔋 Team 9uttery(구떠리)](#-Team-9uttery(구떠리))**

<br><br>


## 🔥 기술적인 고민과 문제 해결

### 🔖 네트워킹 리팩토링 - API 코드를 40줄에서 8줄로 만드는 마법

**상황**
- Alamofire를 사용
- 각각의 API 요청 메서드 내에서 AF.request를 호출하고, 응답을 받아 처리
- 큰 도메인(User, Album, ...)단위로 API를 모아 두는 객체 내에 각각의 API 요청 메서드를 나열해서 사용
  - ex, AlbumAPI에서 baseURL/albums/ 로 시작하는 모든 API를 관리한다
  - 각각의 API 객체들이 baseURL, Keychain 을 모두 개별적으로 생성하고 가져와서 사용한다
  - 각각의 API 내부에 싱글톤을 활용해 여러 곳(특히 View)에서 호출하는 방식이다

**문제**
- 중복 코드 증가
  - 모든 API 요청마다 AF.request를 생성하고, status code에 대한 대응을 각각 처리한다
  - `"DEBUG(getAlbumsCreatedByMe): data nil"` 디버깅을 위한 코드를 함수명만 바꿔서 매번 처리한다
    -> 이건 하드코딩의 문제이기도 하다! 함수명을 제대로 바꿔주지 않았을 때(실제로 존재한다..), 디버깅하며 어디서 생긴 오류인지 알 수 파악할 수 없다
- 싱글톤 패턴을 사용하고 있어 의존성을 끊고, 외부에서 주입하기 어렵다. (물론 테스트하기도 어렵다 - 테스트를 하고 있진 않지만..)
- 하드코딩된 URL과, URL 버전관리, 인증 토큰 값
- (심지어 파일 길이를 벗어난다는 린트도 뜬다..)
  <img width="622" alt="image" src="https://github.com/user-attachments/assets/d9a7e6b5-a5ab-4b3c-aba5-52254462c85e" />
- 모든 이유들로 인한 디버깅의 어려움
```swift
// 🚨 기존 API 호출 코드
// 🚨 각각의 API 객체들이 모두 외부 라이브러리를 가져다가 사용중
import Alamofire
import Foundation
import KeychainSwift

class AlbumAPI {
    let keychain = KeychainSwift()  // 🚨 각각의 API들이 모두 키체인 객체를 새로 생성해서 가진다
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")/v1" // 🚨 각각의 API를 고려하지 않은 url 버전 관리
    static let shared = AlbumAPI() // 🚨 공유할 데이터가 없음에도 싱글톤으로 활용중 -> 어떤 방식이 결국 더 좋은 방식일지 고민중..

    // 앨범 상세 조회
    func getAlbumsCreatedByMe(completion: @escaping (_ isSuccess: Bool, _ albumList: [GetAlbumsCreatedByMeResponse]) -> Void) {
        let url = "\(baseUrl)/albums/created"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        let dummy = GetAlbumsCreatedByMeResponse(albumId: 0, name: "")
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetAlbumsCreatedByMeResponse]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        // 🚨 디버깅을 위해 print를 쓰고 있고, 내부에 함수명을 직접 쓰고 있어서 내용을 틀리면 정확한 위치를 파악하기 어려움
                        print("DEBUG(getAlbumsCreatedByMe): data nil")
                        completion(false, [dummy])
                        return
                    }

                    // 🚨 모든 API가 각자 statusCode를 관리
                    // 🚨 개별적인 에러가 아닌, 공통 에러도 각자 관리
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getAlbumsCreatedByMe): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getAlbumsCreatedByMe): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getAlbumsCreatedByMe): error \(error))")
                    completion(false, [dummy])
                }
            }
    }
}
```

**해결**
- 공통 API 로직을 분리하고, APIEndpoint 구조체 도입
- API 요청과 관련된 로직을 캡슐화하고, 모든 API 요청이 공통된 방식을 따르도록 했다
```swift
import Alamofire  // 🍀 이제 여기서만 Alamofire를 호출해서 사용한다
import Foundation

struct APIEndpoint<Response: Codable> {
    typealias ResponseDTO = Response  // 🍀 받아오는 DTO를 설정한다
    
    var method: HTTPMethod
    var urlVersion: Int = 1  // 🍀 기본 url version을 설정하고, 추후 변경이 필요하면 개별적으로 설정할 수 있도록 한다
    var path: String
    var headerType: APIHeaderType = .withAuth
    
    var body: [String: Any]?
    
    func request(completion: @escaping (Result<Response, NetworkError>) -> Void) {
        let url = "https://\(NetworkConstants.baseUrl)/v\(urlVersion)\(path)"  // 🍀 상수로 쓰이는 값들은 Constants로 설정해 관리한다
        let headers: HTTPHeaders = headerType.headers
        
        AF.request(url, method: method, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<ResponseDTO>.self) { response in
                guard let status = response.response?.statusCode else {
                    // 🍀 Logger를 구현해 하드코딩하지 않고도 정확한 위치를 파악할 수 있도록 한다
                    NetworkLogger.debugLog(method: method, path: "/v\(urlVersion)\(path)", issue: "APIEndpoints에서 statusCode가 nil")
                    return completion(.failure(NetworkError.invalid))
                }

                // 🍀 공통된 에러 핸들링을 관리
                validateStatusCode(status) { validate in
                    switch validate {
                    case .success:
                        switch response.result {
                        case .success(let response):
                            guard let data = response.data else {
                                printLog("Decoding한 data가 nil")
                                return completion(.failure(NetworkError.invalid))
                            }
                      ...
```
- 각각의 요청에 필요한 정보만 입력해 활용한다
```swift
import Foundation

struct AlbumsAPI {
    static var path = APIPaths.albums.rawValue
    
    /// 새로운 앨범 생성
    static func postNewAlbum(name: String, description: String) -> APIEndpoint<[PostNewAlbumResponse]> {
        let body: [String: Any] = [
            "name": name,
            "description": description
        ]
        
        return APIEndpoint(method: .post, path: path, body: body)
    }
}
```
- 🚨 그러나 여전히 path 관리와 개별 에러핸들링에 완벽한 대응은 아닌 것 같다. 많은 레퍼런스를 참고해 활용하고, '모야' 라이브러리 활용법도 참고해보자!

**느낀점**
> 이전에 전혀 유지보수를 고려하지 않았다는 점을 뼈저리게 느낀다. API를 추가할 때마다 복사-붙여넣기로 사용했고, 그로 인한 오류가 많이 존재한다. API별 에러 핸들링이 어렵고, 가독성이 제로다..
> 확장성과 유지보수 고려를 뼈저리게 느꼈으니, 앞으로 잘 생각하는 습관을 길러야겠다. (1년 후엔 또 어떻게 생각할지 모르겠지만!ㅎㅎ)


<!--
<details>
  <summary><h3>🔖 1년이 넘은 코드, 그리고 앞둔 대규모 업데이트. 우리는 어떻게 대응해야 할까? (현재 진행중)</h3></summary>

  **상황**
  - 곧 대규모 업데이트를 앞두고 있다. 기능의 변화는 작지만, UI가 전부 변경될 예정이다.
  - (원인) 프로젝트를 시작하던 당시, 기능의 확장과 코드의 유지보수를 고려하지 못했다. (iOS 개발자들이 개발을 시작한 지 얼마 되지 않기도 했고..) 
  
  **문제**
  - (아래 코드는 일부 생략된 코드입니다만.. 이 짧은 코드 안에서도 보이는 문제들을 모두 가져와봤습니다)
  - View 하나가 가지는 책임이 너무 많다.
  - 특정 API의 변경이 필요할 땐, API를 사용하는 곳을 전부 찾아야 한다.
  - View가 서버에서 받은 데이터를 디코딩하기 위한 DTO를 직접 사용한다.
  - 사실 이 기능 그대로 화면만 바뀐다고 하더라도, 처음부터 새로 쓰는 것이 나을 정도로 가독성이 나쁘고 명확한 관심사 분리가 되어 있지 않다
    ```swift
    struct HomePlayJoyView: View {
        @State var playAlbums: [GetAlbumsResponse] = []  // 🚨 API에서 받아오는 DTO로 View에서 활용하고 있다
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                NavigationLink {
                    // 🚨 View가 화면 전환 로직을 가지고 있다 + 화면 생성도 한다
                    // 🚨 그래서 일부 View는 View가 필요한 것들을 상위 View가 주입해주기도 한다
                    HomePlayJoyListView()
                } label: {
                    HStack {
                        Text("행복을 재생해요")
                            .madiiFont(font: .madiiSubTitle, color: .white)
                        Spacer()
                        Image("chevronRight")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .padding(.bottom, 21.5)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    // 🚨 GA도 View가 한다.. -> 하지만 이건 어떻게 분리할지 고민중이다
                    AnalyticsManager.shared.logEvent(name: "홈뷰_행복을재생해요클릭")
                })
            }
            .onAppear {
                // 🚨 View가 API도 요청한다 ㅎㅎ..
                // 🚨 심지어 API를 싱글톤으로 생성했다.. -> 이건 네트워킹 리팩토링을 통해 변경할 얘정!
                HomeAPI.shared.getAllAlbums(albumId: nil, size: 5) { isSuccess, allAlbum in
                    if isSuccess {
                        playAlbums = allAlbum.content
                    }
                }
            }
        }
    }
    ```
  
  **해결(진행중)**
  > 대규모 업데이트와 함께 추후에 변경될 모든 가능성을 고려해 명확한 관심사 분리가 필요하다<br>
  - Presentation - Domain - Data 레이어로 프로젝트 아키텍처 재설계 !!!
  - Repository 패턴을 도입해 서버에서 받아온 데이터를 iOS에서 활용하기 위한 변환 구현 (DTO를 View에서 쓰지 말자)
  - 조립이 용이한 설계를 도와줄 수 있는 것이 뭐가 있을까.. TCA를 도입해보자! -> 현재 iOS 팀원 모두 공부중


  **느낀점**
  > 코드를 그냥 다시 쓰는 게 더 편하겠다는 생각이 들 정도로 까마득했다. 하지만 결국 모두 유지보수를 위한 일이고, 직접 코드를 보면서 명확한 문제를 파악하는 것이 중요하다고 생각한다. 디자인이 끝날 때까지 한 달 반의 시간이 주어졌다. 마디를 새단장하기 위한 모든 준비를 마치고, 기쁜 마음으로 디자인을 맞이하러 갈 수 있도록 달려보자 🔥

</details>


### 🔖 위젯을 개발하다보니 모듈을 분리하게 되었다!

**상황**
- 오늘의 소확행 위젯을 개발하게 되었다.
- Widget은 새로운 Target을 생성해서 개발하게 된다.

**문제**
- 새로운 타겟으로 생성했기 때문에, App Target에서 사용하던 DesignSystem, Networking, 등등 공유 리소스를 사용할 수 없었다.
  (사용하려면 App Target을 import 할 수 있겠으나, 

**해결**


**느낀점**


<details>
  <summary><h3>🔖 네트워킹 리팩토링 - API 코드를 40줄에서 8줄로 만드는 마법</h3></summary>

  이 부분은 토글을 클릭했을 때 보입니다.

  추가로 여러 줄도 작성할 수 있습니다.
  - 목록1
  - 목록2

</details>

<details>
  <summary><h3>🔖 위젯을 개발하다보니 모듈을 분리하게 되었다!</h3></summary>

  이 부분은 토글을 클릭했을 때 보입니다.

  추가로 여러 줄도 작성할 수 있습니다.
  - 목록1
  - 목록2

</details>
-->
<br><br>


## 🌟 주요 기능

**1. 소확행을 매일 추천받고, 다른 사람들의 소확행을 탐색하고**

![image](https://github.com/user-attachments/assets/5ec1015b-5e16-427a-9cf2-d5434214add0)

**2. 내가 실천한 소확행을 기록하고**

![image](https://github.com/user-attachments/assets/a573c443-a915-43fe-a407-8061fbd6bb64)

**3. 그동안 실천한 소확행을 모아보고**

![image](https://github.com/user-attachments/assets/4f8fb49e-2edf-43cf-b0ff-9c1537ec9091)

<br><br>


<!-- 깃/브랜치 전략 -->
## 💻 Git/Code Convention

### 🔖 Code/Naming Rules
SwiftLint를 사용해 Swift Code Convention을 준수할 수 있도록 했습니다.
- SwiftLint
    - A tool to enforce Swift style and conventions
    - [https://github.com/realm/SwiftLint](https://github.com/realm/SwiftLint)
- Variable: `lowerCamelCase` 복수는 -s
- Function: `lowerCamelCase` 동사원형으로 시작
- Enum
    - Name: `UpperCamelCase`
    - case: `lowerCamelCase`
- Struct, Class
    - Name: `UpperCamelCase` 이름 앞에 prefix 붙이기 않기
    - property, method: `lowerCamelCase`
<br>

### 🔖 Git Flow
**📌 Issue & Pull Request**

이슈 생성 -> PR

**📌 브랜치 전략**

Develop 브랜치를 메인으로 각 Feature 브랜치를 생성해 개발을 진행합니다.<br>
QA 진행 전 배포 버전에 맞춰 Release 브랜치를 생성하고,<br>
QA 중 발견된 버그 수정 사항에 대해 Release 브랜치에서 수정 후 Main, Develop 브랜치로 각각 머지합니다.<br>
이후 Main에 머지된 배포 버전은 tag를 추가하여 관리합니다.

<img src="https://www.gitkraken.com/wp-content/uploads/2021/03/git-flow-4.svg" height=500 >

<br><br>


<!-- 팀 소개 -->
## 🔋 Team 9uttery(구떠리)

### 🔖 Team Blog
[🔗 9uttery Team Blog](https://9uttery.tistory.com/)
<br>

### 🔖 R&R

| 이오 \| 이안진 | 래우 \| 정태우 | 민슨 \| 김민근 | 하노 \| 한호정 |
|:-:|:-:|:-:|:-:|
| <img src="https://github.com/user-attachments/assets/fef1b4db-f9ae-4c3a-8a89-d47211899cd1" width="110"> | <img src="https://github.com/user-attachments/assets/13ba99f2-b30d-4c28-8942-e5675d8dfc53" width="110"> | <img src="https://github.com/user-attachments/assets/270cf06f-2b3f-43c5-9ae1-ed5e0ba86a12" width="110"> | <img src="https://github.com/user-attachments/assets/daadc7de-8d81-4794-8ad2-48695ffb9a30" width="110"> |
| **iOS 개발** | **iOS 개발** | **Server 개발** | **Server 개발** |
| [@anjiniii](https://github.com/anjiniii) | [@taewoojeong](https://github.com/taewoojeong) | [@mingeun0507](https://github.com/mingeun0507) | [@hojeong2747](https://github.com/hojeong2747) |

| 에몽 \| 양예인 | 혜나 \| 김민혜 | 도요 \| 김서연 | 두두 \| 박주아 | 코코 \| 한지원 |
|:-:|:-:|:-:|:-:|:-:|
| <img src="https://github.com/user-attachments/assets/e00bfcf8-7819-4984-ac39-a611674ac69e" width="100"> | <img src="https://github.com/user-attachments/assets/6ebf0de6-a254-46c7-b20c-e4ab0e8a2fc0" width="100"> | <img src="https://github.com/user-attachments/assets/07c50c0f-ab00-4d4b-87e1-ac2e3bba1d61" alt="도요" width="100"> | <img src="https://github.com/user-attachments/assets/904ae712-9c54-4bfb-9686-83dec301ed99" width="100"> | <img src="https://github.com/user-attachments/assets/540a8a56-5b52-49b9-a270-5a6322a3a876" width="100"> |
| **서비스 기획**<br>프로젝트 운영(PM) | **서비스 기획**<br>MVP 테스트 | **서비스 기획**<br>UX writing | **서비스 기획**<br>SNS 운영 | **프로덕트 디자인**<br>SNS 콘텐츠 디자인 |
<br>

### 🔖 협업 방식
![image](https://github.com/user-attachments/assets/0f3b96fa-e2e8-4174-ba28-837407203f6f)

<img src="https://github.com/user-attachments/assets/63fa8eb6-e19f-47ae-9497-75954b0ec499" width="400">

<br><br><br><br><br>










