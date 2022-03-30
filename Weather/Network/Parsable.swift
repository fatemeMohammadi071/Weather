//
//  Parsable.swift
//  Weather
//
//  Created by Fateme on 1/7/1401 AP.
//

import Foundation

protocol Parsable {
    associatedtype Object: Codable
    func parse(data: Data) -> Object?
}
