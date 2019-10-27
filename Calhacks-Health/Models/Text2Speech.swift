//
//  Text2Speech.swift
//  Calhacks-Health
//
//  Created by Charlie Wang on 2019/10/26.
//  Copyright © 2019 wcz. All rights reserved.
//

import Foundation
import AVFoundation
import Alamofire
import SwiftyJSON

let TTS_API_URL = "https://texttospeech.googleapis.com/v1beta1/text:synthesize"
let API_Key = "AIzaSyAZI3U7df4ofy1y3StxS0YtKiEuDxFPccw"

class Text2Speech: NSObject, AVAudioPlayerDelegate {
    
    private(set) var busy = false
    private var audioPlayer: AVAudioPlayer?
    
    override init() {
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: .allowBluetooth)
        try! audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    func speak(_ text: String) {
        
        if busy {
            print("Audio Player Busy!!")
            return
        }
        busy = true
        
        let param: [String:Any] = [
            "audioConfig": [
              "audioEncoding": "LINEAR16",
              "pitch": 0,
              "speakingRate": 1
            ],
            "input": [
              "text": text
            ],
            "voice": [
              "languageCode": "en-US",
              "name": "en-US-Wavenet-D"
            ]
        ]
        
        AF.request(TTS_API_URL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["X-Goog-Api-Key": API_Key, "Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
            if let data = response.value {
                let json = JSON(data)
                print(json)
                let audioContent = json.dictionaryObject?["audioContent"] as! String
                let audioData = Data(base64Encoded: audioContent)!
                print(audioData.base64EncodedString())
                //DispatchQueue.main.async {
                    self.audioPlayer = try! AVAudioPlayer(data: audioData, fileTypeHint: "wav")
                    self.audioPlayer!.prepareToPlay()
                    self.audioPlayer!.delegate = self
                    self.audioPlayer!.play()
                    print("played...")
                //}
            }
        }
        
        busy = false
        audioPlayer?.delegate = nil
        audioPlayer = nil
        
    }
    
}
