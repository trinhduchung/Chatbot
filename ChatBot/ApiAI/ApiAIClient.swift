//
//  ApiAIClient.swift
//  ChatBot
//
//  Created by Duc Hung Trinh on 13/5/18.
//  Copyright © 2018 Hung. All rights reserved.
//

import Foundation
import ApiAI
import RxSwift

class ApiAIClient {
    
    static func sendMessage(_ message: String) -> Observable<String> {
        return Observable<String>.create({ observer in
            let request = ApiAI.shared().textRequest()
            request?.query = message
            request?.setMappedCompletionBlockSuccess({ (request, response) in
                if let response = response as? AIResponse, let textResponse = response.result.fulfillment.speech {
                    observer.onNext(textResponse)
                } else {
                    observer.onCompleted()
                }
                
                observer.onCompleted()
            }, failure: { (request, error) in
                observer.onError(error!)
            })
            
            ApiAI.shared().enqueue(request)
            
            return Disposables.create {
                request?.cancel()
            }
        })
    }
}
