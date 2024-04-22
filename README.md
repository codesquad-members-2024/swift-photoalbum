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
