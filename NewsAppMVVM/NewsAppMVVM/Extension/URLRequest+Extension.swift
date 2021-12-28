//
//  URLRequest+Extension.swift
//  NewsAppMVVM
//
//  Created by 강호성 on 2021/12/28.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                // Observable 데이터 반환
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                // Observable 데이터 -> decoding된 데이터 반환
                return try JSONDecoder().decode(T.self, from: data)
            }.asObservable()
    }
}
