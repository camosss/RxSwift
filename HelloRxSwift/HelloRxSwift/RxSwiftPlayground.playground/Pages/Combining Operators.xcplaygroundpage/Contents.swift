import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

// MARK: - Combining Operators

// Starts With

let disposeBag = DisposeBag()

let numbers = Observable.of(2,3,4)

let observable = numbers.startWith(1)
observable.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

// 1, 2, 3, 4


// Concat
// 첫번째 시퀀스와 두번째 시퀀스 연결

let disposeBag = DisposeBag()

let first = Observable.of(1,2,3)
let second = Observable.of(4,5,6)

let observable = Observable.concat([first,second])
observable.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

// 1,2,3,4,5,6


// Merge
// 좌변과 우변의 결과를 합치는 것

let disposeBag = DisposeBag()

let leftV = PublishSubject<Int>()
let rightV = PublishSubject<Int>()

let source = Observable.of(leftV.asObserver(), rightV.asObserver())

let observable = source.merge()
observable.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

leftV.onNext(1)
rightV.onNext(4)
rightV.onNext(5)
leftV.onNext(2)
rightV.onNext(6)
leftV.onNext(3)

// 1,4,5,2,6,3


// Combine Latest

let disposeBag = DisposeBag()

let leftV = PublishSubject<Int>()
let rightV = PublishSubject<Int>()

let observable = Observable.combineLatest(leftV, rightV) { lastLeft, lastRight in
    "Left \(lastLeft), Right \(lastRight)"
}

let disposable = observable.subscribe(onNext: {
    print($0)
})

leftV.onNext(45)
rightV.onNext(1)
leftV.onNext(30)
rightV.onNext(99)
rightV.onNext(2)

// Left 45, Right 1
// Left 30, Right 1
// Left 30, Right 99
// Left 30, Right 2


// With Latest From
// 호출할 때 해당시간의 값만 얻을 수 있음

let disposeBag = DisposeBag()

let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let observable = button.withLatestFrom(textField)
let disposable = observable.subscribe(onNext: {
    print($0)
})

textField.onNext("S")
textField.onNext("Swift")

button.onNext(())
// Swift

textField.onNext("Swift Rocks!")

button.onNext(())
// Swift Rocks!


// Reduce
// 시퀀스를 취한 다음 하나의 특정 값으로 줄이는 것

let disposeBag = DisposeBag()

let source = Observable.of(1,2,3)

source.reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 6

source.reduce(0) { summary, newValue in
    return summary + newValue
}.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)
// 6


// Scan

let disposeBag = DisposeBag()

let source = Observable.of(1,2,3,4,5)

source.scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 1, 3, 6, 10 ,15
