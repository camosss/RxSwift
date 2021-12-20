import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

// MARK: - Transforming Operators
// Observable 데이터를 새 시퀀스로 변경하고, 변환
// CollectioinView나 TableView에서 바인딩해야 할 수 있는 Observable 데이터에서 준비

// to array
let disposeBag = DisposeBag()

Observable.of(1,2,3,4,5)
    .toArray()
    .subscribe({
        print($0)
    }).disposed(by: disposeBag)
// [1, 2, 3, 4, 5])

// map
let disposeBag = DisposeBag()

Observable.of(1,2,3)
    .map {
        return $0 * 2
    }.subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 2
// 4
// 6

// flat map
let disposeBag = DisposeBag()

struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 95))

let student = PublishSubject<Student>()

student.asObserver()
    .flatMap { $0.score.asObservable() }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

student.onNext(john) // 75 (초기값)
john.score.accept(100) // 100으로 값변경

student.onNext(mary) // 95 (초기값)
mary.score.accept(80) // 80으로 값변경

// mary를 추적했지만 여전히 john도 추적
john.score.accept(40)


// flat map latest
 가장 최근의 Observable만 관찰

student.asObserver()
    .flatMapLatest { $0.score.asObservable() }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

student.onNext(john)
john.score.accept(100)

student.onNext(mary)
john.score.accept(50) // 무시
