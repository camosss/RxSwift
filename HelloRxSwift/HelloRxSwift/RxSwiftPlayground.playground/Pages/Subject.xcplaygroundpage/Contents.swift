import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

// MARK: - Subject

// Publish Subject
let disposeBag = DisposeBag()

let subject = PublishSubject<String>() // 시작할 때 기본값 필요 x

subject.onNext("Issue 1")

subject.subscribe { event in
    print(event)
}

subject.onNext("Issue 2")

subject.dispose()
subject.onCompleted()

subject.onNext("Issue 3")

// ------------------------------------

// Behavior Subject
// 생략해야하거나 사용가능한 마지막 값이 자동으로 생략
let disposeBag = DisposeBag()

let subject = BehaviorSubject(value: "Initial Value")

subject.onNext("Last Issue")

subject.subscribe { event in
    print(event)
}

subject.onNext("Issue 1")

// ------------------------------------

// Replay Subject
// 설정하려는 버퍼사이즈를 기반으로 하는 이벤트

let disposeBag = DisposeBag()

// 새로운 구독자가 이 주제를 구독하려고 할 때 자동으로
// 해당 주제에 의해 방출된 마지막 두 값을 재생한다
let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("Issue 1")
subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.subscribe { event in
    print(event)
}
//next(Issue 2)
//next(Issue 3)

subject.onNext("Issue 4")
subject.onNext("Issue 5")
subject.onNext("Issue 6")

print("[Subsciption 2]")

subject.subscribe { event in
    print(event)
}

//[Subsciption 2]
//next(Issue 5)
//next(Issue 6)


// ------------------------------------

// Variable is deprecated

// ------------------------------------


// Behavior Replay (install rxcocoa)
let disposeBag = DisposeBag()

let relay = BehaviorRelay(value: "Initial Value")

relay.asObservable()
    .subscribe {
        print($0)
}

//relay.value = "Hello" // 읽기 전용이므로 변경 x

// 대신 새값을 받아 할당할 수 있는 함수
relay.accept("Hello")

// 값이 단순 문자열이 아닌 경우

let disposeBag = DisposeBag()

let relay = BehaviorRelay(value: ["item 1"])

//relay.accept(["item 2"]) // next(["item 2"]) (초기값 포함 x)

// 1
//relay.accept(relay.value + ["item 2"]) // next(["item 1", "item 2"]) (초기값 포함 o)

// 2
var value = relay.value
value.append("item 2")
value.append("item 3")

relay.accept(value) // next(["item 1", "item 2", "item 3"])

relay.asObservable()
    .subscribe {
        print($0)
}
