//
//  Error+Extension.swift
//  actisso
//
//  Created by Dang Thai Son on 7/4/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import Action
import Moya

extension ActionError {
    var underlyingError: Swift.Error? {
        switch self {
        case .underlyingError(let error):
            return error

        case .notEnabled:
            return nil
        }
    }

    var message: String {
        switch self {
        case .underlyingError(let error):
            return error.message

        case .notEnabled:
            return "Action not enabled"
        }
    }
}

extension MoyaError {
    var serverError: ServerError? {
        guard case .underlying(let error) = self else { return nil }
        guard let serverError = error as? ServerError else { return nil }
        return serverError
    }
}

extension Swift.Error {
    var message: String {
        guard let moyaError = self as? MoyaError else { return String(describing: self) }
        if let serverError = moyaError.serverError {
            return serverError.detail
        }

        switch moyaError {
        case .underlying(let error):
            return error.localizedDescription

        default:
            return String(describing: self)
        }
    }
}
