//
//  DataDecoder.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 11/10/2021.
//

import Foundation

protocol DataDecoding {
    func decodeModel<C: Decodable>(from data: Data) throws -> C
}

struct DataDecoder: DataDecoding {
    func decodeModel<C: Decodable>(from data: Data) throws -> C {
        return try JSONDecoder().decode(C.self, from: data)
    }
}
