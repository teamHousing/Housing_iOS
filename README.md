# Housing iOS 🏠

--------------

<img width="500" align="left" alt="스크린샷 2021-01-03 오후 11 04 58" src="https://user-images.githubusercontent.com/72001692/103480681-f1edb080-4e18-11eb-8b65-3cc8350b0165.png">


```
🍎 SOPT 27th APPJAM 🍎

👷 iOS 오준현

👷 iOS 노한솔

👷 iOS 김태훈

👷 iOS 김주은

👷 iOS 곽민제
```



## 코딩 컨벤션

--------

### 네이밍

* type과 protocol 이름은 PascalCase를 사용하고, 나머지는 모두 lowerCamelCase를 사용한다.
* boolean 값은 다른 타입과 구분하기 위해 `isSpaceship`, `hasSpacesuit`와 같이  is, has를 붙여준다. 
* parameter에 _(언더 바) 사용은 지양하도록 한다.



## 폴더링

----

```
- Housing/
  ├── Util/
  ├── Supports/
  │   ├── ...
  │   ├── LaunchScreen.storyboard
  │   ├── Assets.xcassets
  │   └── Info.plist
  ├── Network/
  ├── Global/
  │   ├── Enums/
  │   │     └── Font+.swift
  │   └── Extensions/
  │         │── ...swift
  │         └── UIView+.swift
  ├── Configuration/
  ├── Screens/
  │   └── View/
  │    	├── Cell/
  │     │   └── TableviewCell / CollectionviewCell.swift
  │     ├── Storyboards/
  │     │   └── View.storyboard
  │     └── ViewControllers/
  │         └── ViewVC.swift
  ├── Housing.xcdatamodeld/
  └── Housing.xcodeproj/
```



## 깃 브랜치 전략

----

### Git-Flow

- master : 제품으로 출시될 수 있는 브랜치
- develop : 다음 출시 버전을 개발하는 브랜치
- feature : 기능을 개발하는 브랜치
- release : 이번 출시 버전을 준비하는 브랜치
- hotfix : 출시 버전에서 발생한 버그를 수정 하는 브랜치

<img width="500" height="500" align="left" alt="스크린샷 2021-01-04 오전 12 26 03" src="https://user-images.githubusercontent.com/72001692/103482480-798cec80-4e24-11eb-8b0c-ecfd9c88e356.png">



## 커밋 메시지 컨벤션

-----

* gitmoji

깃모지는 git + emoji를 합친 단어로, 모든 커밋 앞에 이모지를 붙이는 행위입니다. 깃모지를 사용하면 커밋의 목적이나 의도를 아주 쉽고 명확하게 알 수 있습니다. 그래서 코드 리뷰할 때를 포함해 커밋을 봐야 하는 경우에도 도움이 됩니다.

<img width="800" height="400" align="left" alt="스크린샷 2021-01-04 오전 12 38 42" src="https://user-images.githubusercontent.com/72001692/103482625-34b58580-4e25-11eb-98eb-6020b525225f.png">



## MARK

----

* // MARK: - 

  Component, Property, Helper, Lifecycle, Object Extension마다 MARK 주석을 사용해 설명합니다. (ex. // MARK: - UITableView Extension,  // MARK: - Helper Extension)

