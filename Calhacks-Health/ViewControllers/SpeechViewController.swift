//
//  SpeechViewController.swift
//  Calhacks-Health
//
//  Created by Charlie Wang on 2019/10/26.
//  Copyright © 2019 wcz. All rights reserved.
//

import UIKit

class SpeechViewController: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var spriteResponseLabel: UILabel!
    let stt = Speech2Text()
    let tts = Text2Speech()
    
    override func viewDidLoad() {
        stt.delegate = self
        tts.speak("Welcome to Health plus plus, your personal virtual physician")
    }
    
    @IBAction func startstop(_ sender: UIButton) {
        if stt.audioRecorder == nil {
            stt.startRecording()
            spriteResponseLabel.text = "Go ahead, I'm listening..."
            startStopButton.setImage(UIImage(named: "Recording.png"), for: .normal)
        } else {
            stt.stopRecording()
            stt.request()
            spriteResponseLabel.text = "Thinking..."
            startStopButton.setImage(UIImage(named: "RecordInactive.png"), for: .normal)
        }
    }
    
}

extension SpeechViewController: Speech2TextDelegate {
    func setRecognizedText(_ text: String?) {
        //spriteResponseLabel.text = text!
    }
}
