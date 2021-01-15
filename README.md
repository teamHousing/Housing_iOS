# Housing iOS 🏠
<img alt="스크린샷 2021-01-03 오후 11 04 58" src="https://user-images.githubusercontent.com/72001692/103480681-f1edb080-4e18-11eb-8b65-3cc8350b0165.png" width="150" align="left">

```
🍎 SOPT 27th APPJAM 🍎

HOUSING 
- 
```

<br/>

## 목차

1. [개발환경 및 사용한 라이브러리](#개발환경-및-사용한-라이브러리)
2. [서비스 workflow](#서비스-workflow)
3. [기능 개발여부/담당자](#기능-개발여부/담당자)
4. [핵심기능 구현 방법](#핵심기능-구현-방법)
5. [Extension을 통해 작성한 메소드 설명](#Extension을-통해-작성한-메소드-설명)
6. [팀원 역할 및 소개](팀원-역할-및-소개)
7. [코딩 컨벤션](https://github.com/teamHousing/Housing_iOS/wiki/coding-covention)
8. [폴더링](https://github.com/teamHousing/Housing_iOS/wiki/foldering)
9. [깃 전략](https://github.com/teamHousing/Housing_iOS/wiki/git-branch-strategy)
10. [새롭게 알게 된 것](#새롭게-알게-된-것)


### 개발환경 및 사용한 라이브러리

|                          라이브러리                          |               목적               |      |
| :----------------------------------------------------------: | :------------------------------: | ---- |
|       [RxSwift](https://github.com/ReactiveX/RxSwift)        |           비동기 처리            | SPM  |
|     [Kingfisher](https://github.com/onevcat/Kingfisher)      |           이미지 캐실            | SPM  |
|        [SnapKit](https://github.com/SnapKit/SnapKit)         |          오토 레이아웃           | SPM  |
|     [Alamofire](https://github.com/Alamofire/Alamofire)      |            서버 통신             | SPM  |
|           [Then](https://github.com/devxoul/Then)            | 컴포넌트 코드 작성의 용이를 위해 | SPM  |
|   [FSCalendar](https://github.com/WenchaoD/FSCalendar.git)   |           캘린더 사용            | SPM  |
| [SwiftKeychainWrapper](https://github.com/jrendel/SwiftKeychainWrapper) |          저장소 암호화           | SPM  |
| [YPImagePicker](https://github.com/Yummypets/YPImagePicker)  |           사진첩 사용            | SPM  |
| [RxKeyboard](https://github.com/RxSwiftCommunity/RxKeyboard) |         키보드 동적 사용         | SPM  |
<br>

### 서비스 workflow



### 기능 개발여부/담당자

1. 세입자

|    기능     |        상세 기능        | 담당자 | 구현 여부 | 통신 구현 여부 |
| :---------: | :---------------------: | :----: | :-------: | :------------: |
|  스플래시   |        스플래시         |  준현  |     ✅     |       ✅        |
|   로그인    |         로그인          |  민제  |     ✅     |       ✅        |
|  회원가입   |        초대 인증        |  민제  |           |                |
|             |        회원가입         |  민제  |     ✅     |       ✅        |
|  소통하기   |        소통하기         |  주은  |     ✅     |       ✅        |
|             |      소통하기 상세      |  한솔  |     ✅     |       ✅        |
|             |        문의 작성        |  태훈  |     ✅     |       ✅        |
|   캘린더    |         캘린더          |  준현  |     ✅     |       ✅        |
|             | 당일 문의/공지사항 보기 |  준현  |     ✅     |       ✅        |
| 우리집 소식 |      임대인 프로필      |  민제  |     ✅     |       ✅        |
|             |        공지사항         |  민제  |     ✅     |       ✅        |

2. 집주인

|    기능     |        상세기능         | 담당자 | 구현 여부 | 통신 구현 여부 |
| :---------: | :---------------------: | :----: | :-------: | :------------: |
|  스플래시   |        스플래시         |  준현  |     ✅     |       ✅        |
|   로그인    |         로그인          |  민제  |     ✅     |       ✅        |
|  회원가입   |        회원가입         |  민제  |     ✅     |       ✅        |
|  소통하기   |        소통하기         |  주은  |     ✅     |       ✅        |
|             |      소통하기 상세      |  한솔  |     ✅     |       ✅        |
|             |        문의 확인        |  한솔  |     ✅     |       ✅        |
|   캘린더    |         캘린더          |  준현  |     ✅     |       ✅        |
|             | 당일 문의/공지사항 보기 |  준현  |     ✅     |       ✅        |
| 우리집 소식 |        내 프로필        |  민제  |     ✅     |       ✅        |
|             |        공지사항         |  민제  |     ✅     |       ✅        |
|             |      공지사항 작성      |  태훈  |     ✅     |       ✅        |
|             |     초대 번호 생성      |  태훈  |     ✅     |       ✅        |



### 핵심기능 구현 방법

1. 캘린더

   

2. 상세 정보 표기

   

3. 초대 번호 생성

   

### Extension을 통해 작성한 메소드 설명

| Extension                 | 목적                                   |
| ------------------------- | -------------------------------------- |
| UICollectionView+         | 콜렉션 뷰 관리                         |
| UICollectionViewCell+     | 콜렉션 뷰 셀 관리                      |
| UICollectionReusableView+ | 콜렉션 뷰, 헤더 푸터 뷰 관리           |
| UITableView+              | 테이블 뷰 관리                         |
| UITableViewCell+          | 테이블 뷰 셀 관리                      |
| UIColor+                  | color 삽입                             |
| UIView+                   | 그림자 생성 뷰, 컴포넌트 삽입, 등등... |
| UIViewController+         | 토스터 생성 / 뷰 컨트롤러 관리         |
| CALayer+                  | 그림자 생성                            |
| UIImage+                  | 이미지 크기 조정                       |
| UIDatePicker+             | DatePicker로 텍스트 컬러 넣기          |
| UIImageView+              | URL로 이미지 넣기                      |

### 💡새롭게 알게 된 것

> 곽민제

#### CollectionView Cell에 Shadow를 넣는 방법에 대해 알게 되었습니다😋
#### 
> ```
> extension CALayer {
> func applyShadow(
> 		color: UIColor = .black,
> 		alpha: Float = 0.1,
> 		x: CGFloat = 0,
> 		y: CGFloat = 0,
> 		blur: CGFloat = 8
> 	) {
> 		shadowColor = color.cgColor
> 		shadowOpacity = alpha
> 		shadowOffset = CGSize(width: x, height: y)
> 		shadowRadius = blur / 1.0
> 	}
> }
> 
> func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> 
>                 UICollectionViewCell {
> 		guard let cell = collectionView.dequeueReusableCell(
> 						withReuseIdentifier: "CollectionViewCell",
> 						for: indexPath) as? CollectionViewCell
> 		else {
> 			return UICollectionViewCell()
> 		}		
> 		cell.backgroundColor = .white
> 		cell.containerView.layer.applyShadow()
> 		cell.contentView.backgroundColor = UIColor.white
> 		
> 		return cell
> 	}
> ```


<br/>


> 김주은

#### Expandable TableView를 만드는 법을 알게 되었어요👩‍💻
#### 

> ```
>extension CommunicationViewController: UITableViewDelegate {
>	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
>		if indexPath.row == 0 {
>			if tableViewData[indexPath.section].opened == true {
>				tableViewData[indexPath.section].opened = false
>				communicationTableView.backgroundColor = .primaryGray
>				let sections = IndexSet(integer: indexPath.section)
>				tableView.reloadSections(sections, with: .none)
>			} else {
>				tableViewData[indexPath.section].opened = true
>				communicationTableView.backgroundColor = .primaryGray
>				let sections = IndexSet(integer: indexPath.section)
>				tableView.reloadSections(sections, with: .none) 
>			}
>			communicationTableView.reloadData()
>		} else {
>			let viewController = DetailViewController()
>			viewController.requestId = >tableViewData[indexPath.section].sectionData[indexPath.row-1].id
>			navigationController?.pushViewController(viewController, animated: true)
>		}
>	}
>}
>}
> ```


### 팀원 역할 및 소개

| <IMG src="https://github.com/5anniversary.png?size=100" width="150"> | <IMG src="https://github.com/hansolnoh95.png?size=100" width="150"> | <IMG src="https://github.com/8ugustjaden.png?size=100" width="150"> | <IMG src="https://github.com/JubyKim.png?size=100" width="150"> | <IMG src="https://github.com/iAmSomething.png?size=100" width="150"> |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|                            오준현                            |                            노한솔                            |                            곽민제                            |                            김주은                            |                            김태훈                            |

