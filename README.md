# ReadPlay (23.09.-23.12.)

영단어 암기를 위한 어플리케이션으로 iOS 개발자 1명, AOS 개발자 1명, 디자이너 1명으로 진행하였습니다. 
화면을 터치하고 있을 때 문제가 점점 빠르게 넘어가고 최대 0.15초에 1단어가 지나갑니다. 반대로 떼면 천천히 넘어가서 최장으로는 1초마다 1개의 단어가 넘어갑니다.

## 👩🏻‍💻내가 기여한 부분

프로젝트 전체 매니저를 담당하면서 iOS 1인 개발을 진행했습니다. 

### 프로젝트 매니저

- 제시된 서비스의 핵심 기능을 바탕으로 전체 프로젝트 기획
- 디자이너와의 협업으로 UI/UX 고려한 플로우 형성
    - Figma의 코멘트를 적극 활용하여 활발히 소통
 
![Untitled](https://github.com/user-attachments/assets/77acfe29-9c33-4791-996a-e9fc7a629589)

### iOS 풀스택 개발

- **개발스택:** SwiftUI | **디자인 패턴:** MVVM 패턴
- CoreData 프레임워크 활용하여 데이터 저장
    - 데이터 CRUD 구현
- 어플리케이션 내에서 default로 제공하는 단어장의 경우 Json 파일로 자체 변환 후 앱 초기 실행 시 CoreData 형태로 저장
- 타이머와 DragGesture 를 활용하여 사용자의 터치감에 따라 List로 형성된 단어의 인덱스를 넘기는 학습화면 구현


<img src="https://github.com/user-attachments/assets/383a68af-e369-42c6-97ef-196543635cbe" alt="리드플레이 영상" style="width:300px; height:auto;">




## 🍀 배운점

### [Soft Skill]

- 디자이너와 협업 스킬 - 디자인 관련 단어 숙지
- 프로젝트 매니저로 전체 스케줄 관리 - 칸반보드 및 백로그 활용

### [Hard Skill]

- [Tech] SwiftUI의 CoreData 모델 구현 및 CRUD 기능
- [Tech] 타이머 기능으로 TimeInterval 타입 변수 핸들링
- [Tech] DragGesture의 여러 형태 파악
- [Design] 피그마 툴: 커멘트, 오토레이아웃, 레이아웃
