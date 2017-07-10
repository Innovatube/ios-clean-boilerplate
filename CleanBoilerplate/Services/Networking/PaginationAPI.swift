//
//  PaginationAPI.swift
// 
//
//  Created by Dang Thai Son on 7/6/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import Action
import Moya
import ObjectMapper
import RxSwift
import RxOptional
import RealmSwift

protocol PaginationResponse {
    associatedtype Element: Object, Mappable

    var hasNext: Bool { get set }
    var offset: Int { get set }
    var limit: Int { get set }

    var items: Array<Element> { get set }
}

enum PaginationAction {
    case refresh
    case loadNextPage(offset: Int, limit: Int)
}

class PaginationAPI<ResponseType: PaginationResponse> {
    typealias PaginationRequest = (_ offset: Int, _ limit: Int) -> Observable<ResponseType>


    // Input
    let limit: Int
    let refreshTrigger: PublishSubject<Void> = PublishSubject()
    let loadNextTrigger: PublishSubject<Void> = PublishSubject()

    // Output
    var elements: Observable<[ResponseType.Element]> { return self.requestAction.elements.map { Array($0.items) } }
    var errors: Observable<Swift.Error> { return self.requestAction.errors.map { $0.underlyingError }.filterNil() }
    var loading: Observable<Bool> { return self.requestAction.executing }

    // Private
    private let request: PaginationRequest

    private lazy var requestAction: Action<PaginationAction, ResponseType> = {
        return Action<PaginationAction, ResponseType> { action -> Observable<ResponseType> in
            switch action {
            case .refresh:
                return self.request(0, self.limit)

            case .loadNextPage(let offset, let limit):
                return self.request(offset, limit)
            }
        }
    }()

    private let disposeBag = DisposeBag()

    // Init
    init(limit: Int, request: @escaping PaginationRequest) {
        self.limit = limit
        self.request = request

        refreshTrigger
            .map { _ in return PaginationAction.refresh }
            .bind(to: requestAction.inputs)
            .disposed(by: disposeBag)

        let currentPage = requestAction.elements.map { ($0.offset + $0.limit, $0.limit) }.startWith((0, self.limit))

        loadNextTrigger
            .withLatestFrom(currentPage)
            .map { offset, limit in return PaginationAction.loadNextPage(offset: offset, limit: limit) }
            .bind(to: requestAction.inputs)
            .disposed(by: disposeBag)
    }
}

