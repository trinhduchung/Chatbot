//
//  MainScreenViewController.swift
//  ChatBot
//
//  Created by Duc Hung Trinh on 11/5/18.
//  Copyright © 2018 Hung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainScreenViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    private let viewModel = MainScreenViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func bindViewModel() {
        let sendMessageButtonObservable = sendMessageButton.rx.tap.asObservable()
        let disposable = sendMessageButtonObservable.subscribe(onNext: {
            self.messageTextField.text = ""
        })
        disposable.disposed(by: bag)
        
        let inputs = MainScreenViewModel.Input(message: messageTextField.rx.text.orEmpty.asObservable(), sendMessageButtonPress: sendMessageButtonObservable)
        let outputs = viewModel.transform(input: inputs)
        outputs.textResponse.drive(messageLabel.rx.text).disposed(by: bag)
    }
}

