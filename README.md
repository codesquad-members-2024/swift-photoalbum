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
