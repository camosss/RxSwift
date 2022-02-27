# RxSwift <img src = "https://github.com/ReactiveX/RxSwift/raw/main/assets/RxSwift_Logo.png" width = 60  align = right> 

## Why use RxSwift?
  
<details>
<summary></summary>
  
### Rx

Reactive Extensions을 사용하는 라이브러리이다.

즉, Reactive Programming을 쉽게 할 수 있도록 돕는 역할을 한다.

데이터의 흐름과 그에 대한 처리를 정의해놓고, 흐름에서 변경사항이 생기면 미리 정의해둔 방식에 따라 변화를 주는 프로그래밍 방식이다. 결국 반응형인데 **변화에 실시간으로 반응**하기 때문 !

> 그래서 RxSwift는 함수형 프로그래밍인 Swift에 반응형 프로그래밍을 더해주는 라이브러리로 볼 수 있다.

---

### RxSwift를 사용함으로써

- **반응형 패러다임이 제공하는 명확함으로 비동기를 동기화된 것처럼 작성이 가능하다.**

곳곳에 DispatchQueue, OperationQueue,, 를 하나의 비동기 코드로 개발이 가능하다.

이렇게 Rx로 일관된 코드를 작성하면서 확장이 불가능한 아키텍쳐 패턴의 확장이 가능하고, 서로 다르게 구현한 로직을 조합하기 쉽다.


- **Thread 처리가 쉬워진다. → 콜백지옥에서 벗어날 수 있음!**

만약 RxSwift를 사용하지 않는다면?

A라는 값을 받아와야 B라는 값을 받아올 수 있고, B라는 값을 받아와야 C라는 값을 받아올 수 있는 상황에서는 흔히 말하는 콜백(CallBack) 지옥이 코드에 나타나게 될 수 있다.

하지만 Rx를 이용하여 가독성을 높이고, 스레드를 쉽게 넘나들며 콜백 지옥을 탈출할 수 있을 것이다. 따라서 UI 이벤트, 네트워크 처리 등의 **데이터를 갱신했을 때의 처리가 쉬워지고,** 그만큼 **코드도 깔끔**해질 것이다.


### 주의할 점

- **클로저의 사용이 많다.**

캡쳐리스트를 사용하여 메모리 누수를 일으키는 강한 순환 참조 (Strong reference cycle)을 피할 수 있게 신경써야한다.

클로저에서는 value type이라고 하더라도, 해당 객체가 만들어진 곳의 인스턴스를 참조할 것이다.
캡쳐리스트를 해주지 않는다면, race condition 같은 것이 발생할 수 있다.

---

> **참고**
> 
- [끄적이는 개발노트](https://beenii.tistory.com/178)
- [Clint Jang 블로그](https://medium.com/@jang.wangsu/ios-swift-rxswift-%EC%99%9C-%EC%82%AC%EC%9A%A9%ED%95%98%EB%A9%B4-%EC%A2%8B%EC%9D%84%EA%B9%8C%EC%9A%94-5c9995f47bab)
</div>
</details>

<br>

## Reference
- [ReactiveX](http://reactivex.io/)
- [Udemy Mastering Rxswift in iOS](https://www.udemy.com/course/mastering-rxswift-in-ios/)
- [KxCoding](https://www.youtube.com/watch?v=m41N4czHGF4&list=PLziSvys01Oek7ANk4rzOYobnUU_FTu5ns)

<br>

## Curriculum

* **Section I: Getting Started with RxSwift**
  > | Ch# | Chapter Subject | Keyword |
  > |:---:| :--- | :--- |
  > |1| [Observables](https://www.notion.so/Observables-0d3b84af6e0540f6ac231aa9e6a28138) | Just, Of, From, Dispose, Create |
  > |2| [Subjects](https://www.notion.so/Subject-c75ff57eecd549b5b22a1d35455fec56) | Publish Subject, Behavior Subject, Replay Subject, Observable 과 Subject 차이 |
  > |3| [Implementing Photo Filter App Using RxSwift](https://www.notion.so/Implementing-Photo-Filter-App-Using-RxSwift-c8484db9fda447b1afb239ce4c7a855a) | [CameraFilter 코드](https://github.com/camosss/RxSwift/tree/main/CameraFilter) |

* **Section II: Operators**
  > | Ch# | Chapter Subject | Keyword |
  > |:---:| :--- | :--- |
  > |1| [Filtering Operators](https://www.notion.so/Filtering-Operators-a3d77b28919f4255b3727f0ec70d0dcb) | Ignoring Operators, Skipping Operators, Taking Operators |
  > |2| [TODO List App Using Filter Operations](https://www.notion.so/TODO-List-App-Using-Filter-Operations-c7a55fbacee7492d92607ba0d8db3319) | [GoodList 코드](https://github.com/camosss/RxSwift/tree/main/GoodList) |
  > |3| [Transforming Operators](https://www.notion.so/Transforming-Operators-1e78cc2409c84678a57623e463669477) | To Array, Map, Flat Map, Flat Map Latest |
  > |4| [Building News App Using Transforming Operators](https://www.notion.so/Building-News-App-Using-Transforming-Operators-88d566808bfd48b29bbd1fbe58a5ae39) | [GoodNews 코드](https://github.com/camosss/RxSwift/tree/main/GoodNews) |
  > |5| [Combining Operators](https://www.notion.so/Combining-Operators-50407af9c7cd4f208f005041a3a8489c) | Starts With, Concat, Merge, Combine Latest, With Latest From, Reduce, Scan |


* **Section III: iOS Apps with RxCocoa**
  > | Ch# | Chapter Subject | Keyword |
  > | :---: | :--- | :--- |
  > |1| [RxCocoa](https://www.notion.so/RxCocoa-2333716ea79c4bcfa594bd7dd79e1d7b) | Control Property, Binder, Traits |
  > |2| [Building Weather App Using RxCocoa](https://www.notion.so/Building-Weather-App-Using-RxCocoa-52d5c8d3c78446e7a5f7e06d1eb5ffc4)| [GoodWeather 코드](https://github.com/camosss/RxSwift/tree/main/GoodWeather) |


* **Section IV: Intermediaate RxSwift/RxCocoa**
  > | Chapter Subject | Keyword |
  > | :--- | :--- |
  > | [Error Handling](https://www.notion.so/Error-Handling-cd065975c2e94e8a8bddf6d9f53f16a2) | Throwing Errors, Handle Errors with Catch, Retrying on Error |


* **Section V: MVVM with Rxswift**
  > | Chapter Subject | Keyword |
  > | :--- | :--- |
  > | [MVVM with RxSwift](https://www.notion.so/MVVM-with-RxSwift-882eb18e1849473b9ef55d39455411f3) | [NewsApp(MVVM) 코드](https://github.com/camosss/RxSwift/tree/main/NewsAppMVVM) |


* **Section VI: MVVM-C with Rxswift**
  > | Chapter Subject | Keyword |
  > | :--- | :--- |
  > | [MVVM-C with Building Memo App](https://www.notion.so/Building-Memo-App-b92971e0ef5f46229a7ffc8066953760) | [GoodMemo 코드](https://github.com/camosss/RxSwift/tree/main/GoodMemo) |






