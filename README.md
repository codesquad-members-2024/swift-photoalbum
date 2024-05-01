# swift-photoalbum
4월 4주차 프로젝트

<details>
<summary>프로젝트 설정</summary>

## 🎯주요 작업

- [x]  프로젝트 설정 - fork하지 않고, 직접 로콜에 clone해서 작업 브랜치 단위로 작업
- [x]  collectionView추가하고, Safe영역에 가득채우기, frame설정하기
- [x]  CollectionView Cell 크기 80 x 80
- [x]  UICollectionViewDataSource 프로토콜 채택하고 40개 Cell 랜덤 색상 채우기
    
    

## 📚학습 키워드

### UICollectionView

iOS에서 그리드 기반의 레이아웃을 구현할 수 있는 컴포넌트

예시) 사진 갤러리

collectionView의 레이아웃은

1. FlowLayout
2. CompositionalLayout

FlowLayout만 사용해도 원하는 View를 만들 수 있고, 더 복잡한 레이아웃을 만들려면 CompositionalLayout을 사용할 수 있다.

그리고 컬렉션뷰는 ScrollView를 내장하고 있어서, cell의 갯수가 컬렉션뷰의 frame보다 넘거가게 되더라도, 알아서 스크롤이 가능하게 만든다.

### UICollectionViewDataSource

화면을 표현하기 위해, 데이터를 제공하는 역할

위 프로토콜을 구현하는 것은 collectionView의 필수 요소

- collectionView(_:numberOfItemsInSection:) : 섹션에 표시할 아이템 수
- collectionVIew(_:cellForItemAt:) : 특정 위치에 표시할 셀을 구성하고 반환

### UICollectionViewDelegate

동작을 처리하기 위해 사용자 상호작용을 처리를 담당

- collectionView(_:didSelectItemAt:): 사용자가 아이템을 선택했을 때 호출
- didDeslectItemAt : 사용자가 아이템 선택을 취소했을 때 호출

### **UICollectionViewDelegateFlowLayout**

UICollectionVIewLayout의 서브클래스이며,

셀의 크기, 섹션의 여백, 헤더 및 푸더 크기 등을 동적으로 조정할 수 있다.

- collectionView(_:layout:sizeForItemAt:): 각 셀의 크기를 결정
- collectionView(_:layout:insetForSectionAt:): 섹션의 내부 여백(인셋)을 결정
- collectionView(_:layout:minimumLineSpacingForSectionAt:) 및 collectionView(_:layout:minimumInteritemSpacingForSectionAt:): 섹션 내의 아이템 간 최소 줄 간격 및 아이템 간 간격을 결정

## 💻정리

1. custom class에 CollectionViewController 클래스 이름 넣어주면 아울렛 변수 연결할 수 있는 상태로 바뀜.
2. collectionView를 아울렛 변수로 생성되어 제어해준다. 데이터소스, 델리게이트
3. cell도 동일하게 custom class에 입력해주는데, 콜렉션뷰는 cell을 재사용하기 때문에 재사용하는 cell을 알아낼 때 이용하는 것이 Collection Reusable View의 identifier이다. 식별자를 입력해야 cell을 판별가능함.

## 🤔결과

<img width="403" alt="스크린샷 2024-04-22 오후 2 38 56" src="https://github.com/codesquad-members-2024/swift-todo/assets/104732020/863cce78-37ad-4c81-9620-5477d130bf55">

## 📚추가학습

### CollectionView 와 TableView의 공통점

UIScrollVIew를 상속받는 클래스이고, cell을 기반으로 재사용해서 데이터를 표현하는 View입니다.

### CollectionView 와 TableView의 차이점

테이블 뷰는 한 개의 열과 여러 개의 행으로 정보를 보여주기 때문에 1차원 형태이고, 수직으로만 스크롤이 가능합니다.

그래서 보통 단편적인 정보를 리스트로 보여줄 때 사용되고, 애플의 설정, 연락처 앱을 예시로 들 수 있습니다.

반면에,

컬렉션 뷰는 다양한 행렬로 보여줘서 2차원 형태이고, 수직/수평 스크롤 모두 가능합니다. 

그리고 컬렉션 뷰는 레이아웃을 복잡하고,  유연하게 구현할 수 있습니다.

사진 갤러리를 예시로 들 수 있습니다.

</div>
</details>

<details>
<summary>사진앨범 접근</summary>

## 🎯주요 작업

- [x]  사진앨범 접근

## 📚학습 키워드

### AVFoundation

애플의 미디어 프레임워크.

주요 기능으로는

- 미디어 캡쳐
- 미디어 재생
- 미디어 편집
- 미디어 파일 내용 분석

가장 자주 사용되는 기능은 미디어 재생이며, AVFoundation을 사용하면 효율적으로 재생을 로드하고 제어할 수 있다.

그러나, AVFoundation은 UIKit 아래에 있기 때문에 재생 제어를 위한 표준 UI를 제공하지 않는다. 이를 해결하기 위해 AVKit프레임워크에서 제공하는 기능에 의존하는 것

### AVKit

AVFoundation 위에 있는 보조 프레임워크.

이 프레임워크를 사용하면 플랫폼의 기본재생환경과 일치하는 앱용 플레이어 인터페이스를 쉽게 제공할 수 있다.

### Photos 프레임워크 (PhotoKit)

사진 및 비디오에 직접 접근하기 위한 Photos 프레임워크 - 사진가져오기

이 프레임워크를 사용하면 화면에 표시 및 재생할 Asset를 검색하고 사용하여 작업할 수 있다.

### PHAsset

Photos 라이브러리 내의 하나의 이미지나 비디오를 나타냄.

해당 Asset의 메타데이터를 접근할 수 있게 해준다.

메타데이터 ( 속성 정보/ 생성날짜, 위치, 유형, 해상도 정보 등)

### **PHCachingImageManager**

PHImageManager의 서브클래스

요청한 이미지를 캐싱할 수 있게 해줌.

PHCachingImageManager가 요청한 크기에 맞추어 PHAsset으로부터 이미지를 가져옴

### **PHPhotoLibrary**

애플리케이션은 사진 라이브러리에 변경을 요청할 수 있고, 사용자의 동의를 거쳐 사진을 추가, 삭제, 수정할 수 있다.

## 🤔결과
<img width="389" alt="스크린샷 2024-04-24 오전 11 43 06" src="https://github.com/joho2022/joho2022.github.io/assets/104732020/b236ee6e-aa20-41da-a53c-cb55130a1e13">


</div>
</details>


<details>
<summary>동시 이미지 다운로드</summary>

# 🎯주요 작업

- [x]  GCD 큐 기본 동작과 개념 학습
- [x]  디코딩 학습
    - [x]  json 파일 데이터 구조 변환
- [x]  UI 구성 ( add버튼 = Doodle뷰컨트롤러 코드로 present 시키기)
    - [x]  네비게이션컨트롤러 embed
    - [x]  배경색 어두운 회색, Title명시
    - [x]  Close 버튼 ViewDidLoad()에서 코드로 생성 설정
    - [x]  셀 크기 100 x 50
    - [x]  커스텀 셀 수는 모델 객체 수로 표시
    - [x]  다운로드를 받은 이미지를 해당 셀에 표시
    - [x]  다운로드하는 큐와 UIImageView에 할당하는 큐에 제약을 확인
    - [x]  특정 셀을 롱클릭할 때 Save액션을 하는 UIMenuItem표시
    - [x]  창이 사라지고 사진보관함에 저장한 이미지가 바로 업데이트

# 📚학습 키워드

## Data 형

메모리 안의 바이트가 저장될 수 있는 ‘바이트 버퍼’

바이트 버퍼란? 운영체제의 커널이 관리하는 시스템 메모리를 직접 사용할 수 있기 때문에 데이터의 저장, 로드가 가능하다.

• 자주 사용되는 것은 json데이터를 struct형으로 변경하거나, 반대로 struct형에서 json으로 변경할 때 먼저 `Data`형으로 변경한 다음 원하는 데이터형으로 변경하여 사용

### JSON

key와 value로 구성되어 있는 데이터, value는 모든 타입을 허용한다.

### Encoding

swift의 데이터 모델을 JSON과 같은 파일 포맷으로 변환하는 과정이다.

외부 API에 데이터를 보낼 때 사용한다.

### Decoding

JSON 데이터를 swift의 데이터 구조로 변환하는 과정

외부로부터 데이터를 받아서 앱에서 사용할 수 있는 형태로 변환할 때 사용

### Codable

`typealias Codable = Decodable & Encodable`

Codable 타입을 준수하는 데이터는  디코딩, 인코딩할 수 있게 한다.

Foundation의 기능으로 파일 데이터 관리를 제공하기 때문에 JSONDecoder()가 사용이 가능하다.

🤔 import Foundation이 없는데 왜 가능하지 ??? 

UIkit을 import하면 자동으로 Foundation이 import된다.

1. JSON 데이터를 디코딩하는 함수 만들기

```swift
func jsonDecoder(_ data: String) -> 데이터모델? {
    var decoder = JSONDecoder()
    guard let jsonData = data.data(using: .utf8) else { return nil } // UTF-8인코딩을 사용하여 Data타입으로 변환
    
    do {
        let decoded: 데이터모델 = try decoder.decode(데이터모델.self, from: jsonData)
        return decoded
    } catch {
        print("decoding error: \(error)")
        return nil
    }
}
```

`decode(_:from:)` 는 첫번째 매개변수는 디코딩할 타입을 전달하고, 두번째 매개변수는 디코딩할 데이터가 전달된다.

---

### Bundle

앱의 실행 파일과 관련된 리소스(이미지파일, 텍스트 파일, 스토리보드 등)을 포함하는 폴더. 번들은 파일들을 조직적으로 관리하는 시스템을 제공한다.

IOS앱에서 모든 파일은 App Bundle이라는 단일 패키지로 결합된다.

App Bundle은 여행에 필요한 모든 준비물이 있는 `여행 가방`이라고 생각하면 된다.

`App Bundle의 장점 하나는 독립형 패키지라는 것.`

앱이 실행하는데 필요한 모든 것이 번들에 포함되어 있기 때문에 종속성으로 관리하거나 라이브러리를 별도로 설치하는 것에 대한 걱정이 없다.

이를 통해서 개발자는 앱을 쉽게 배포하고 사용자는 쉽게 이용할 수 있는 것

그래서 `앱스토어에 앱을 다운하는 것은 App Bundle을 다운로드하는 것과 같음.`

Xcode에서 앱을 빌드하면 빌드프로세스에서 AppBundle을 생성한다.

### App Bundle의 구조 - 9개

- Executable File : 앱을 실제로 실행하는 파일,  앱이름이 “SampleApp”이면 실행파일이름도 “SampleApp”
- Info.plist: 앱에 대한 메타데이터가 포함된 속성 목록 파일
    - 앱이름
    - 버전 번호
    - 번들 식별자 등 포함
- Frameworks: 앱에서 타사 프레임워크를 사용하는 경우 앱 번들에 포함 Frameworks폴더에서 찾을 수 있음.
- Resources: 앱의 모든 비 코드 파일이 저장되는 곳, Resource파일
    - 이미지
    - 사운드
    - 지역화 문자열 등이 포함
- Storyboards & XIBs: 앱에서 스토리보드 또는 XIB를 사용하여 사용자 인터페이스를 정의하는 경우 앱 번들에 포함
- Launch Screen: 앱이 실행될 때 표시되는 화면, LaunchScreen.storyboard파일로 정의되고 앱번들에 포함
- Plug-ins: 앱에서 플러그인을 사용하는 경우 앱 번들에 포함
- Excutable dependencies**:** 앱이 외부라이브러리, 프레임워크에 연결되면 앱번들에 포함
- Data Files: 앱이 런타임에 생성된 데이터 파일을 사용하는 경우 Documents 폴더에 저장되고 앱이 설치될 때 앱의 샌드박스에 있다.

### iOS 파일시스템 - 샌드박스

iOS는 각각의 앱이 별도의 파일을 생성하여 공유되지 않도록 하고, 외부로부터 들어온 접근에 대해 보호되는 영역을 샌드박스라고 부른다.

ex) A앱에서 문서를 작성하면 B앱에서 열 수 없다. A앱 → B앱 전달과정을 거쳐야만 해당 파일에 접근할 수 있다.

### 샌드박스 구조

- Documents : 백업이 가능하고 유저가 저장한 데이터, 유저에게 노출되는 파일만 저장
- Library : 유저 데이터가 아닌 파일들이 저장되는 가장 최상단 폴더
    - 하위에 Cache, Preferences가 존재
    - Cache : 웹 서버에서 받아온 임시 데이터, 앱이 실행중에 삭제되지 않는 것이 보장되고 백업은 안된다
    - Preferences : 앱의 중요 설정이 들어있다.
- tep : 내 메모를 외부로 내보내기 위한 백업파일

---

### GCD(Grand Central Dispatch)

멀티코어 시스템에서 동시성 실행을 제공하는 기술 

이를 통해서 개발자는 스레드를 직접 관리하지 않고, 시스템이 최적의 방식으로 스레드를 관리해준다.

즉, 작업을 정의해서 Dispatch Queue에 넣어주면, 운영체제는 Dispatch Queue에 있는 작업들을 적절한 스레드에 할당한다. 그래서 개발자는 자신이 등록한 작업이 어떤 스레드에서 실행되는지 알 수 없다.

### GCD와 Dispatch Queue는 같으면서도 다르다.

위와같은 GCD의 개념으로 동시성 프로그래밍을 지원하는 Swift의 API가 Dispatch Queue인 것이다.

큐의 종류, qos 우선순위, (sync, async)를 설정해서 지정한 작업을 Dispatch Queue를 통해 스레드에 할당할 수 있다.

### Serial 과 Concurrent

Serial(직렬)은 큐에 등록된 작업을 한번에 하나씩 처리하는 것을 의미한다.

```swift
import Foundation

var numbers: [Int] = [0, 1, 2, 3, 4]
let dispatchQueue = DispatchQueue(label: "serial")
(0..<5).forEach( { index in
    dispatchQueue.async {
        print(numbers[index])
    }
})

dispatchMain()
```

결과가 항상 0, 1, 2, 3, 4 순서가 보장된다. 

Serial 큐로 만들어진 Dispatch Queue는 먼저 들어온 작업이 완료되어야 큐에 있는 다음 작업이 시작되기 때문이다.

즉, 한 작업이 끝날 때까지 큐에 있는 다른 작업은 건드리지 않기 때문에 실행 순서가 항상 같다.

반면에 concurrent(동시 발생의)는 동시에 여러 작업을 수행할 수 있다.

운영체제는 Dispatch Queue에서 현재 작업이 끝나지 않아도 다른 작업을 다른 스레드에 할당해서 동시에 여러 작업을 실행한다.

```swift
var numbers: [Int] = [0, 1, 2, 3, 4]
let dispatchQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)

(0..<5).forEach( { index in
    dispatchQueue.async {
        print(numbers[index])
    }
})
```

위와 같은 코드에서는 실제로 사용했을 때 많은 스레드가 있기 때문에, 모든 작업을 한번에 처리하게 된다. 

개념적으로는 한 작업이 끝나지 않아도 동시에 여러 작업을 스레드에 할당하는 것

## 세 종류의 큐

Dispatch Queue를 사용할 때 세 종류의 큐를 선택하여 사용할 수 있다.

### Main Queue

- 메인 스레드에서 작업을 보관하고 수행하는 큐
- 단 하나만 존재할 수 있고, Serial 특성을 가지고 있다.
- 큐에 있는 작업을 순차적으로 실행한다.
- 메인 스레드는 UI 업데이트를 담당한다.
- 같은 순서의 출력을 보장한다.

### Global Queue

- 메인스레드가 아니라 다른 스레드에서 작업을 수행하는 큐
- concurrent 특성을 가지기 때문에, 여러 스레드를 분산하여 동시에 처리한다.
- 항상 같은 순서의 출력을 보장하지 않는다.

### Custom Queue

사용자가 어떤 특성의 큐로 Dispatch Queue를 생성할지 결정하는 것

기본값으로 Serial이고 attributes 인자를 통해 concurrent 변경 가능

### QOS (Quality of Service)

Custom Queue와 Global Queue에 적용할 수 있는 옵션이 바로 QOS 이다.

Main Queue는 이미 가장 높은 우선순위인 `User Interactive` QOS레벨로 운영된다.

우선 순위가 높은 큐는 더 많은 스레드가 할당되고, 상대적으로 우선순위가 낮은 큐는 적게 스레드가 할당된다.

QOS의 종류 우선순위 높은 순으로 5가지

- User Interactive : 사용자와 직접 상호작용을 하는 작업, UI 업데이트, 이벤트 처리 등 사용자 요청에 따라 즉각 응답해야 된다.
- User Initiated : 사용자가 요청했을 때 결과를 즉각 받거나 사용자가 앱을 사용하는 것을 순간적으로 막기 위한 경우
- Default : 기본 값
- Utility : 사용자와 상호작용을 하지 않으면서 오랜시간동안 작업을 진행해야하는 경우
- Background :  가장 낮은 우선순위, 말그대로 앱이 백그라운드에서 실행 중일 때 사용

### Sync 와 Async

Sync는 큐에 작업을 등록한 이후 완료될 때까지 기다리기

Async는 큐에 작업을 등록하면 작업을 기다리지 않고 계속 코드 실행하기

### 동기, 비동기는 Dispatch Queue에 작업을 등록하는 주체에 대한 설정

### serial, concurrent는 이미 큐에 들어온 작업을 어떻게 처리하냐에 대한 설정

그래서 위 내용을 조합할 수 있다

### Sync + Serial

큐에는 한 번에 하나의 작업만 들어가고, 작업은 항상 메인스레드에서 실행된다.

### [ 주의 ]DispatchQueue.main.sync는 데드락 상태에 빠져요

`데드락`: 2개 이상의 스레드가 서로 작업 완료를 무한히 기다리는 상태

1. Main Queue에서 sync를 호출하면 메인스레드는 등록한 작업이 끝날 때 까지 기다린다. 
2. 동시에 큐에 등록된 작업은 메인스레드에서 할당되는데,,
3. 이미 메인스레드는 아무것도 할 수 없는 상태이기 때문에 작업을 수행할 수 없다.
4. 데드락 상태 ~~

### [ 주의 ] 같은 큐에서 sync도 데드락상태에 빠져요

동일한 스레드에서 위와 같은 흐름으로 진행됨

### Async + Serial

작업의 등록은 계속 진행되고, 작업의 수행은 순차적으로 진행된다.

그래서 등록순서와 출력순서가 항상 일치함.

### Sync + Concurrent

작업의 등록이 작업이 끝날 때까지 기다리면서 진행되기 때문에, 큐는 concurrent특성이지만 등록 순서와 출력순서가 항상 일치함.

### Async + Concurrent

결국 이 조합만 등록순서와 출력순서가 항상 일치하지 않는다.

---

# 💻고민과 해결

## 이미지 URL을 파일 시스템에 다운로드하기

→ 터미널에서 명령어 사용

1. GET 방식으로 HTTP 호출할 때 아무런 옵션없이 `curl` 커맨드를 사용할 수 있다.
2. `-o` : 저장할 파일이름을 지정할 수 있다.

`curl https://public.codesquad.kr/jk/doodle.json -o doodle.json` 

## **테스트 파일에 있는 resource 접근하기**

```swift
guard let url = Bundle.main.url(forResource: "doodle", withExtension: "json")
```

# 🤔결과
![동시이미지다운로드](https://github.com/codesquad-members-2024/swift-photoalbum/assets/104732020/608ed822-ffe1-4a5c-99a9-321d3bcaa5fc)

# 📚추가학습

## 메인스레드에서 처리해야 하는 동작

사용자 인터페이스 업데이트와 관련된 작업들로 이루어진다. 사용자와 원활하게 유지하기 위해서이다. UI컴포넌트들은 스레드 세이프하지 않기 때문에 메인스레드에서 동작이 이뤄져야 하는 것이다.

## UIMenuItem

제목과 실행할 액션을 지정하여 인스턴스를 생성하고, UIMenuController에 개별항목으로 표시된다.

## UIMenuController

메뉴구성, 특정위치 메뉴표시, 표시되는 시점을 제어한다.

- shared : 싱글턴 인스턴스에 접근
- menuItems : UIMenuItem 배열을 설정
- setMenuVisible : 메뉴 표시 애니메이션
- setTargetRect : 메뉴 위치

</div>
</details>

<details>
<summary>동영상 내보내기</summary>
# 🎯주요 작업

- [x]  선택될 때 표시
- [x]  Done 버튼
    - [x]  selectedBackgroundView 사용
- [x]  동영상 버튼 만들기

# 📚학습 키워드

## UICollectionViewDataSource

컬렉션뷰를 화면에 보여주기 위해 필요한 함수

- numberOfItemsInSection : 지정된 섹션에 표시할 항목의 수
- cellForItemAt : 컬렉션 뷰의 지정된 위치에 표시할 셀을 요청
- numberOfSections : 컬렉션 뷰의 섹션의 수 ( 구현하지 않으면 기본 1)

## UICollectionViewDelegate

컬렉션뷰 동작을 처리하기 위해 필요한 함수

# 💻고민과 해결

- PhotoManager에서 image만 전달하는 것이 아니라 라이브포토여부 정보도 같이 전달하고자 의도하였습니다.
- VideoManager는 이미지 → 비디오 변환과정을 각 함수로 과정단위를 쪼개고, 최종적으로 build메소드를 통해 비디오 저장까지의 전체과정을 나타내도록 의도하였습니다.

# 🤔결과
![최종결과](https://github.com/codesquad-members-2024/swift-todo/assets/104732020/00d51a69-2657-43b5-bd24-ae5b971bd0ee)

</div>
</details>
