//
//  ViewModelType.swift
//  ChatBot
//
//  Created by Duc Hung Trinh on 13/5/18.
//  Copyright © 2018 Hung. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
