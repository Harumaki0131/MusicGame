//
//  PlayViewController.swift
//  Musicgame
//
//  Created by yuki takei on 2017/02/25.
//  Copyright © 2017年 EriyaMurakami. All rights reserved.
//

import UIKit
import AVFoundation
import EZAudio
import SpriteKit

class PlayViewController: UIViewController{
    
    @IBOutlet var audioPlotFreq:EZAudioPlot!
    
    @IBOutlet var audioPlotTime:EZAudioPlot!
    
    @IBOutlet var soundBoardView:SKView!
    
    var timingArray:[Double] = []
    
    var soundBoardScene:SoundBoardScene = SoundBoardScene()
    
    var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    var audio:AVAudioPlayer!
    
    var ezAudioFFT:EZAudioFFT!
    
    var audioFile:EZAudioFile!{
        didSet{
//            audioFile.delegate = self
        }
    }
    
    
    var fft:EZAudioFFTRolling!
    
    let FFTViewControllerFFTWindowSize:vDSP_Length = 4096;
    
    var audioPlayer:EZAudioPlayer!
//    var backAudioPlayer:EZAudioPlayer!

    
    override func viewDidLoad() {
        openFileWithFilePathURL(NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("syugabita", ofType: "mp3")!))
        
        audioPlayer = EZAudioPlayer()
        audioPlayer.delegate = self
        audioPlayer.playAudioFile(audioFile)
        
        ezAudioFFT = EZAudioFFT()
        ezAudioFFT.delegate = self
        
        audioPlotTime.plotType = EZPlotType.Buffer;
        
        audioPlotFreq.shouldFill = true
        audioPlotFreq.plotType = EZPlotType.Buffer
        audioPlotFreq.shouldCenterYAxis = false
        
        fft = EZAudioFFTRolling(windowSize: FFTViewControllerFFTWindowSize, sampleRate: Float(self.audioPlayer.audioFile.clientFormat.mSampleRate), delegate: self)
        
        soundBoardView.backgroundColor = UIColor.clearColor()
        
        soundBoardScene.size = soundBoardView.frame.size
        soundBoardView.presentScene(soundBoardScene)

    }
    
    func openFileWithFilePathURL(filePathURL:NSURL){
        self.audioFile = EZAudioFile(URL: filePathURL)
//        self.audioFile.delegate = self
        
        var buffer = self.audioFile.getWaveformData().bufferForChannel(0)
        var bufferSize = self.audioFile.getWaveformData().bufferSize
        
        //        print("openfile")
        //        self.audioPlot.updateBuffer(buffer, withBufferSize: bufferSize)
        
        
        
        dispatch_async(dispatch_get_main_queue(), {
            
            //            self.audioPlot.updateBuffer(buffer, withBufferSize: bufferSize)
        })
    }
    
    func ptrToArray(src: UnsafeMutablePointer<Float>, length: Int) -> Array<Float> {
        var dst = [Float](count: length, repeatedValue: 0.0)
        
        dst.withUnsafeMutableBufferPointer({
            ptr -> UnsafeMutablePointer<Float> in
            return ptr.baseAddress
        }).initializeFrom(src, count: length)
        
        return dst
    }
    
    
}

//MARK: - EZAudioFFTDelegate
extension PlayViewController: EZAudioFFTDelegate{
    
    
    
    func fft(fft: EZAudioFFT!, updatedWithFFTData fftData: UnsafeMutablePointer<Float>, bufferSize: vDSP_Length){
        
        //        print("fft")
        var maxFrequency = fft.maxFrequency
        var noteName = EZAudioUtilities.noteNameStringForFrequency(maxFrequency, includeOctave: true)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            //            print("noteName:\(noteName),maxFrequency:\(maxFrequency)")
            self.audioPlotFreq.updateBuffer(fftData, withBufferSize: UInt32(40))
            print(fftData[5]*100)
            if fftData[5]*100 > 100 {
                self.soundBoardScene.showNode()   //ぶろっくをつくる
            print(self.audioPlayer.currentTime)
                self.timingArray.append(self.audioPlayer.currentTime)       //配列にぶろっくだすじかんをきろく
                
                
            }
            
            
        })
        
        var fftArray = self.ptrToArray(fftData, length: Int(40))

    }

    
}

//MARK: - EZAudioPlayerDelegate
extension PlayViewController: EZAudioPlayerDelegate{
    
    func audioPlayer(audioPlayer: EZAudioPlayer!, playedAudio buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32, inAudioFile audioFile: EZAudioFile!){
        
        fft.computeFFTWithBuffer(buffer[0], withBufferSize: bufferSize)
        
        dispatch_async(dispatch_get_main_queue(),{
            self.audioPlotTime.updateBuffer(buffer[0], withBufferSize: bufferSize)
        })
        
    }
    
    
    func audioPlayer(audioPlayer: EZAudioPlayer!, reachedEndOfAudioFile audioFile: EZAudioFile!) {
    
        let saveDate: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        saveDate.setObject(timingArray, forKey: "timing" )
        
    }
    
}


//extension PlayViewController: EZAudioFileDelegate{
//    
//}


