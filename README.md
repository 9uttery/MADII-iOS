# 🍀 바쁜 일상 속 나만의 일시정지 버튼, MADII

![p 1](https://github.com/user-attachments/assets/6dc5d226-1366-471a-84cb-33d8ec781631)

[🔗 **앱스토어 바로가기**](https://apps.apple.com/kr/app/madii/id6478498142)

일에 지나치게 몰입해서 일과 삶의 균형이 무너진 사람들의 균형을 되찾아주자.<br>
삶의 영역에 사소하게라도 몰입할 수 있는 순간을 마련하자!

`Swift` `SwiftUI`

프로젝트 기간: 2024. 08. - 진행중

<br>

<!-- 서비스 소개 -->
## 💫 서비스 핵심 기능

**1. 탐색하고**

![image](https://github.com/user-attachments/assets/5ec1015b-5e16-427a-9cf2-d5434214add0)

**2. 기록하고**

![image](https://github.com/user-attachments/assets/a573c443-a915-43fe-a407-8061fbd6bb64)

**3. 모아보고**

![image](https://github.com/user-attachments/assets/4f8fb49e-2edf-43cf-b0ff-9c1537ec9091)


<br>

<!-- 문제 해결 -->
## 🔥 고민과 문제 해결

<details>
  <summary>Networking Refactoring</summary>

  이 부분은 토글을 클릭했을 때 보입니다.

  추가로 여러 줄도 작성할 수 있습니다.
  - 목록1
  - 목록2

</details>

<details>
  <summary>Networking Refactoring</summary>

  이 부분은 토글을 클릭했을 때 보입니다.

  추가로 여러 줄도 작성할 수 있습니다.
  - 목록1
  - 목록2

</details>

<details>
  <summary>Networking Refactoring</summary>

  이 부분은 토글을 클릭했을 때 보입니다.

  추가로 여러 줄도 작성할 수 있습니다.
  - 목록1
  - 목록2

</details>

<br>

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

### 🐬 Git Flow
**📌 Issue & Pull Request**

이슈 생성 -> PR

**📌 브랜치 전략**

Develop 브랜치를 메인으로 각 Feature 브랜치를 생성해 개발을 진행합니다.<br>
QA 진행 전 배포 버전에 맞춰 Release 브랜치를 생성하고,<br>
QA 중 발견된 버그 수정 사항에 대해 Release 브랜치에서 수정 후 Main, Develop 브랜치로 각각 머지합니다.<br>
이후 Main에 머지된 배포 버전은 tag를 추가하여 관리합니다.

<img src="https://www.gitkraken.com/wp-content/uploads/2021/03/git-flow-4.svg" height=500 >

<br>

<!-- 팀 소개 -->
## 🔋 Team: 9uttery(구떠리)

### R&R

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

### Team Blog
[🔗 9uttery Team Blog](https://9uttery.tistory.com/)

<br>

### 협업 방식














