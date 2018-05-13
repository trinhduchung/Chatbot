//
//  MainScreenViewModel.swift
//  ChatBot
//
//  Created by Duc Hung Trinh on 13/5/18.
//  Copyright © 2018 Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import AVFoundation
import ApiAI

class MainScreenViewModel: ViewModelType {
    
    struct Input {
        let message: Observable<String>
        let sendMessageButtonPress: Observable<Void>
    }
    
    struct Output {
        let textResponse: Driver<String>
    }
    
    func transform(input: MainScreenViewModel.Input) -> MainScreenViewModel.Output {
        let textResponse = input.sendMessageButtonPress
            .withLatestFrom(input.message)
            .flatMap { message -> Observable<String> in
                return ApiAIClient.sendMessage(message)
            }
            .asDriver(onErrorJustReturn: "")
        
        return Output(textResponse: textResponse)
    }
}
