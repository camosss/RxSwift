import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

// MARK: - Observable

// just - 하나의 특정요소로 관찰 가능 항목을 만들려는 변수
let observableJust = Observable.just(1)

observableJust.subscribe { event in
    print(event)
}

// 함수가 아닌 observable을 사용하면
// 배열 또는 다른요소로 관찰 가능 항목을 만들 수 있다.
// 여러값을 전달할 수 있음
let observableOf = Observable.of(1,2,3)
let observableOf2 = Observable.of([1,2,3])

observableOf.subscribe { event in
    print(event)
}

// from - 실제로 배열을 사용하고 원하는 경우 배열을 전달할 수 있음
let observableFrom = Observable.from([1,2,3,4,5])

observableFrom.subscribe { event in
    print(event)
}

observableFrom.subscribe { event in
    if let element = event.element {
        print(element)
    }
}

let subscriptionFrom = observableFrom.subscribe(onNext: { element in
    print(element)
})

// ------------------------------------

// 자체처리가 불가능하므로, DisposeBag 생성
let disposeBag = DisposeBag()

Observable.of("A","B","C")
    .subscribe {
        print($0)
}.disposed(by: disposeBag)

// Create
Observable<String>.create { observer in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")
    return Disposables.create()

}.subscribe(onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") })
    .disposed(by: disposeBag)

