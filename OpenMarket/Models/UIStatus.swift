//
//  UIStatus.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-19.
//

import Foundation

enum UIStatus<T: Any> {
    case loading(Bool)
    case error(String, Error?)
    case successful(T)
}
