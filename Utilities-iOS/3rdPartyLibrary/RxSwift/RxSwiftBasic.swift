//  Created by SinaMN75 on 2/12/20.
//  Copyright © 2020 SinaMN75. All rights reserved.

import Foundation
import RxSwift
import RxRelay

func runRx() {
    behaviorRelay()
}

func observebales() {
    let observable = Observable.from([1, 10, 25, 32, 15, 100, 54, 21])
        
    observable.filter({ e in
        if e % 2 == 0 { return true }
        else { return false }
    }).map({ e in
        return "even numbers are \(e) "
    }).subscribe(onNext: { e in
        print(e)
    }).dispose()
}

func behaviorRelay() {
    let numbers = BehaviorRelay(value: [1, 10, 25, 32, 15, 100, 54, 21])
    
    _ = numbers.asObservable()
        .throttle(.seconds(5), scheduler: MainScheduler.instance)
        .subscribe { e in
        print(e)
    }
    
    numbers.accept(numbers.value + [100])
}

