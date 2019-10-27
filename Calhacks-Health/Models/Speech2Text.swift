//
//  Speech2Text.swift
//  Calhacks-Health
//
//  Created by Charlie Wang on 2019/10/26.
//  Copyright © 2019 wcz. All rights reserved.
//

import Foundation
import AVFoundation
import Alamofire
import SwiftyJSON

let STT_API_URL = "https://speech.googleapis.com/v1/speech:recognize"
//let API_Key = "AIzaSyAZI3U7df4ofy1y3StxS0YtKiEuDxFPccw"

protocol Speech2TextDelegate: class {
    func setRecognizedText(_ text: String?)
}

class Speech2Text: NSObject, AVAudioRecorderDelegate {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    weak var delegate: Speech2TextDelegate?
    
    override init() {
        recordingSession = AVAudioSession.sharedInstance()
        try! recordingSession.setCategory(.playAndRecord, mode: .default)
        try! recordingSession.setActive(true)
        recordingSession.requestRecordPermission() { _ in }
    }
    
    func startRecording() {
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        audioRecorder = try? AVAudioRecorder(url: audioFilename, settings: settings)
        audioRecorder.delegate = self
        audioRecorder.record()
        
    }
    
    func stopRecording() {
        audioRecorder.stop()
        audioRecorder = nil
    }
    
    func request() {
        let dir = getDocumentsDirectory().appendingPathComponent("recording.wav")
        let data = (try! Data(contentsOf: dir)).base64EncodedString()

        let param: [String:Any] = [
            "audio": [
                "content": data
            ],
            "config": [
                "sampleRateHertz": 16000,
                "languageCode": "en-US",
                "encoding": "LINEAR16",
                "enableWordTimeOffsets": false
            ]
        ]
        
        AF.request(STT_API_URL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["X-Goog-Api-Key": API_Key, "Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
            if let data = response.value {
                let json = JSON(data)
                print(json)
                let text = json["results"].arrayValue[0]["alternatives"].arrayValue[0]["transcript"].stringValue
                self.delegate?.setRecognizedText(text)
            }
            self.delegate?.setRecognizedText(nil)
        }
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
