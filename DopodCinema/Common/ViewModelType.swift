//
//  ViewModelType.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/25.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
