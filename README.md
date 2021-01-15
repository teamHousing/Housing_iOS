# Housing iOS 🏠
<img alt="스크린샷 2021-01-03 오후 11 04 58" src="https://user-images.githubusercontent.com/72001692/103480681-f1edb080-4e18-11eb-8b65-3cc8350b0165.png" width="150" align="left">

```
🍎 SOPT 27th APPJAM 🍎

HOUSING iOS
- 2020.12.26 ~ 2021.01.16
```

<br/>

## 목차

- [개발환경 및 사용한 라이브러리](#개발환경-및-사용한-라이브러리)

- [서비스 workflow](#서비스-workflow)

- [기능 개발여부/담당자](#기능-개발여부/담당자)

- [핵심기능 구현 방법](#핵심기능-구현-방법)

- [Extension을 통해 작성한 메소드 설명](#Extension을-통해-작성한-메소드-설명)

- [팀원 역할 및 소개](팀원-역할-및-소개)

- [코딩 컨벤션](https://github.com/teamHousing/Housing_iOS/wiki/coding-covention)

- [폴더링](https://github.com/teamHousing/Housing_iOS/wiki/foldering)

- [깃 전략](https://github.com/teamHousing/Housing_iOS/wiki/git-branch-strategy)

- [새롭게 알게 된 것](#새롭게-알게-된-것)

- [testflight download link](https://testflight.apple.com/join/08nlaS1d)


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
| [Moya](https://github.com/Moya/Moya)                         |          서버 통신              | SPM  |
| [Lottie](https://github.com/airbnb/lottie-ios)               |          애니메이션 사용        | SPM  |
| [SegementSlide](https://github.com/Jiar/SegementSlide) | 탭바 사용 | CocoaPod |

<br>

### 서비스 workflow



![KakaoTalk_Photo_2021-01-15-22-54-18](https://user-images.githubusercontent.com/22820675/104735258-bfcb3f80-5784-11eb-99d9-66e6113e972a.png)



### 기능 개발여부/담당자

1. 세입자

|    기능     |        상세 기능        | 담당자 | 구현 여부 | 통신 구현 여부 |
| :---------: | :---------------------: | :----: | :-------: | :------------: |
|  스플래시   |        스플래시         |  준현  |     ✅     |       ✅        |
|   로그인    |         로그인          |  민제  |     ✅     |       ✅        |
|  회원가입   |        초대 인증        |  민제  |     ✅     |       ✅        |
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

   FSCalendar 를 이용해 개발을 진행했습니다.

   구현 중 가장 중요하다 생각하는 부분은 캘린더 내 정보 관리부분인데요.

   서버로부터 날짜 정보를 받아와 Dictionary형태로 만들어 저장을 해두고([String : [CalendarModel]])

   사용자에게 해당하는 날짜에 정보가 있는경우 반복문을 돌리는것보다 효율적으로 정보 호출을 할수가 있었습니다.

   ~~~swift
   // 캘린더 정보 저장을 위한 변수
   var calendarDictionary: [String : [FSCalendarModel]] = [:]
   
   guard let promise: [FSCalendarModel] = calendarDictionary[day] else { return UICollectionViewCell() }
   if promise[indexPath.row].isNotice == 0 {
     let cell: CalendarCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
   	cell.calendar = promise[indexPath.row]
   	cell.fetchCalendar()
   	cell.fetchCategory()
   	cell.fetchTime()
   	return cell
   } else {
   	let cell: NoticeCollectionViewCell = collectionView.dequeueCell(forIndexPath: indexPath)
   	cell.calendar = promise[indexPath.row]
   	cell.fetchCalendar()
   	cell.fetchTime()
   	return cell
   }
   
   ~~~

2. 하우징 쪽지

   SegementSlide 를 사용하여 전체 뷰를 구성했습니다.

   header 부분에는 제목과 문의 내용이 들어가고 아래 두 개의 탭에는 각각 상세 정보와 하우징 쪽지가 들어갑니다.

   하우징 쪽지가 집주인과 자취생의 소통 흐름을 볼 수 있는 핵심 기능인데요.

   MessageViewController 내에 테이블 뷰를 넣고 그 셀 안에 다시 테이블 뷰를 넣는 방식으로 진행했습니다.

   라이브러리 자체에서 내장 함수로 탭 안의 뷰가 테이블뷰로 그려지기 때문에 그 첫 번 째 셀에 다시 테이블뷰를 보여주는 방식을 선택하게 되었습니다.

   셀 마다 어떤 뷰를 넣어주고 그 셀 안에 버튼에 어떤 함수를 넣는지가 가장 중요한 구현사항이었는데요.

   Datasource를 익스텐션으로 선언하여 그 안에 셀마다의 데이터를 정해줄 수 있는 cellForRowAt 이 포함된 함수를 사용하여 텍스트를 바꿔주고 버튼이 눌렸을 때 selector를 사용하여 각 기능을 구현할 수 있었습니다.

   ```swift
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   		let cell: MessageDetailTableViewCell = tableView.dequeueCell(forIndexPath: indexPath)
   		if self.userOrOwner == 0 {
   			if self.status[indexPath.row] == 0 {
   				cell.titleLabel.text = "문의사항이 등록되었어요!"
   				cell.contextLabel.attributedText = self.makeAttributed(
   					context: "아래의 버튼을 눌러\n약속시간을 정해보세요."
   				)
   				cell.transitionButton.addTarget(self,
   																				action: #selector(didTapConfirmButton(_:)),
   																				for: .touchUpInside
   				)
   				cell.transitionButton.setTitle("약속 확정하기", for: .normal)
   			}
   			else if self.status[indexPath.row] == 1 {
   				cell.titleLabel.text = "약속이 확정되었어요!"
   				var confirmedPromise = "\(self.confirmedPromiseOption)예정이에요\n 캘린더에서 일정을 확인해보세요."
   				cell.contextLabel.attributedText = self.makeAttributed(context: confirmedPromise)				
   				cell.transitionButton.addTarget(self,
   																				action: #selector(didTapCalendarButton(_:)),
   																				for: .touchUpInside)
   				cell.transitionButton.setTitle("캘린더 보기", for: .normal)
   			}
   			else if self.status[indexPath.row] == 2 {
   				cell.titleLabel.text = "약속 수정 요청을 보냈어요!"
   				cell.contextLabel.attributedText = self.makeAttributed(
   					context: "앞으로도 하우징과 함께\n자취생과 소통해보세요!"
   				)
   				cell.transitionButton.snp.makeConstraints {
   					$0.height.equalTo(0)
   				}
   			}
   			...
   ```

   

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
> ```swift
> extension CALayer {
> 	func applyShadow(
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
> UICollectionViewCell {
> 	guard let cell = collectionView.dequeueReusableCell(
> 					withReuseIdentifier: "CollectionViewCell",
> 					for: indexPath) as? CollectionViewCell
> 	else {
> 		return UICollectionViewCell()
> 	}
> 	// collectionViewCell에 uiView outlet을 추가했습니다.
> 	cell.containerView.layer.applyShadow()
> 	cell.backgroundColor = .white
> 	cell.contentView.backgroundColor = UIColor.white
> 
> 	return cell
> }
> ```


<br/>


> 김주은

#### Expandable TableView를 만드는 법을 알게 되었어요👩‍💻
> ```swift
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



> 노한솔

#### RxMoya를 사용하여 서버 통신하는 법을 알게 되었어요🙃

>```swift
>detailProvider.rx.request(.homeDetail(id: requestId))
>			.asObservable()
>			.subscribe(onNext: { response in
>				do{
>					let json = JSON(response.data)
>					let decoder = JSONDecoder()
>					let data = try decoder.decode(ResponseType<Detail>.self,
>																				from: response.data)
>					
>					let result = data.data
>					self.statusModel.append(DetailStatus(
>						ownerStatus: json["data"]["Replies"][0]["owner_status"].arrayValue.map{$0.intValue},
>						userStatus: json["data"]["Replies"][0]["user_status"].arrayValue.map{$0.intValue},
>						id: json["data"]["Replies"][0]["id"].intValue
>					)
>					)
>					self.detailDataBind(result!)
>					let viewController = ContentViewController()
>					viewController.model = self.model
>					let statusViewController = MessageViewController()
>					self.idValue.id = data.data?.id ?? 11
>					
>					statusViewController.model = self.model
>					statusViewController.statusModel = self.statusModel
>					
>					//viewController.tableView.reloadData()
>					
>					statusViewController.tableView.reloadData()
>				} catch {
>					print(error)
>				}
>				
>			}, onError: { error in
>				print(error.localizedDescription)
>			}, onCompleted: {
>				self.headerViewLayout()
>				self.detailHeaderView.snp.makeConstraints{
>					$0.height.equalTo(130+self.contextHeight()*22)
>				}
>				self.detailHeaderView.reloadInputViews()
>			}).disposed(by: disposeBag)
>
>```
>
>
> 김태훈

#### Then과 Snapkit을 사용해서 UI를 만들었어요🎨

>```swift
>	private var nextStep = UIButton().then{
>		$0.backgroundColor = .gray01
>		$0.setTitle("다음 단계", for: .normal)
>		$0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
>		$0.isEnabled = false
>		$0.setRounded(radius: 25)
>		$0.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
>	}
>		nextStep.snp.makeConstraints{
>			$0.top.equalTo(questionDescription.snp.bottom).offset(72)
>			$0.centerX.equalTo(view)
>			$0.width.equalTo(widthConstraintAmount(value: 255))
>			$0.height.equalTo(48)
>		}
>```
>
>

#### TableView의 높이를 동적으로 구성해봤어요🤸‍♀️

>~~~swift
>	func resetTableViewHeight() {
>		self.timeStampTableView.snp.updateConstraints{
>			$0.height.equalTo(CGFloat(70 * self.requestData.availableTimeList.count))
>		}
>		self.underGrayView.snp.updateConstraints{
>			$0.height.equalTo(CGFloat(70 * requestData.availableTimeList.count) + 300)
>		}
>	}
>
>
>	func addTimeStamp(sender : UIButton) {
>		resetPickerLayout()
>		resetTableViewHeight()
>		let isTableViewEmpty = requestData.availableTimeList.isEmpty
>		registerButton.isEnabled = isTableViewEmpty ? false : true
>		registerButton.backgroundColor = isTableViewEmpty ? .gray : .primaryOrange
>		tableViewBind()
>		timeStampTableView.reloadData()
>	}
>~~~

> 오준현
#### Dictionary 타입을 사용해봤습니다

기존의 프로젝트에서 사용 할 일이 없어 사용하지 않았지만 이번 프로젝트에서 캘린더를 사용하게 되면서 
Dictionary 타입에 대해 다루어 보는 기회를 가지게 되었습니다.
구조체를 날짜 String Key값에 맞춰주는 코드를 작성하였습니다

~~~swift
		
for notice in data.notice {
	let when = "\(notice.year).\(notice.month).\(notice.day)"
	let model = FSCalendarModel(isNotice: notice.isNotice,
	 														id: notice.id,
															category: notice.category,
															solutionMethod: notice.solutionMethod,
															time: notice.time,
															title: notice.title,
															contents: notice.contents)ㅈ
	calendarDictionary["\(when)"] = [model]
}
for promise in data.issue {
  let when = "\(promise.year).\(promise.month).\(promise.day)"
  let model = FSCalendarModel(isNotice: promise.isNotice,
                              id: promise.id,
															category: promise.category,
															solutionMethod: promise.solutionMethod,
															time: promise.time,
															title: promise.title,
															contents: promise.contents)
  if calendarDictionary[when]?.count == 0 {
    calendarDictionary["\(when)"] = [model]
	} else {
    calendarDictionary[when]?.append(model)
  }
}

~~~





### 팀원 역할 및 소개

| <IMG src="https://github.com/5anniversary.png?size=100" width="150"> | <IMG src="https://github.com/hansolnoh95.png?size=100" width="150"> | <IMG src="https://github.com/8ugustjaden.png?size=100" width="150"> | <IMG src="https://github.com/JubyKim.png?size=100" width="150"> | <IMG src="https://github.com/iAmSomething.png?size=100" width="150"> |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|                            오준현                            |                            노한솔                            |                            곽민제                            |                            김주은                            |                            김태훈                            |

