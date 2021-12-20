import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

// MARK: - Operators

/// ignore

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

strikes
    .ignoreElements() // ignore을 사용한 필터링
    .subscribe { _ in
        print("[Subscription is called]")
}.disposed(by: disposeBag)

strikes.onNext("A")
strikes.onNext("B")

// 구독이 실제로 호출되는 유일한 시간은 완료 이벤트를 실행할 때
strikes.onCompleted()

// [Subscription is called]


/// Element At

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

strikes.element(at: 2)
    .subscribe(onNext: { _ in
        print("You are out!")
    }).disposed(by: disposeBag)

strikes.onNext("X")
strikes.onNext("X")
strikes.onNext("X") // "You are out!"


/// Filter

let disposeBag = DisposeBag()

// 필터 연산자와 함께 작업하기 위해 가장 먼저 필요한 것
// 일종의 시퀀스 ex) (1,2,3,4,5,6,7)

Observable.of(1,2,3,4,5,6,7)
    .filter{ $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 2
// 4
// 6


/// Skip

let disposeBag = DisposeBag()

Observable.of("A","B","C","D","E","F")
    .skip(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// D
// E
// F


/// Skip While

let disposeBag = DisposeBag()

Observable.of(2,2,3,4,4)
    .skip(while: { $0 % 2 == 0 })
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 3
// 4
// 4

// $0 % 2 == 0 조건식이 3은 해당이 안되기 때문에
// 조건에 해당되지 않는 3 이후의 값부터 출력


/// Skip Until

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.skip(until: trigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

subject.onNext("A")
subject.onNext("B")
// trigger에 전달할 때까지 이벤트를 얻지 못함
trigger.onNext("X") // trigger을 시작해야 subscribe가 시작
subject.onNext("C")
// C


/// Take

let disposeBag = DisposeBag()

Observable.of(1,2,3,4,5,6)
    .take(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 1
// 2
// 3


/// Take While

let disposeBag = DisposeBag()

Observable.of(2,4,6,7,8,10)
    .take(while: {
        return $0 % 2 == 0
    }).subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 2
// 4
// 6
// 조건이 false값(7)부터 출력 x


/// Take Until

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.take(until: trigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

subject.onNext("1")
subject.onNext("2")
// 1
// 2
trigger.onNext("X")
subject.onNext("3")
// 1
// 2
// trigger가 전달할 때까지 얻고, 그 후로는 무시된다
