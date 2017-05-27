//
//  ViewController４.swift
//  Musicgame
//
//  Created by EriyaMurakami on 2016/11/02.
//  Copyright © 2016年 EriyaMurakami. All rights reserved.
//

import UIKit
import AVFoundation

import EZAudio

class ViewController4: UIViewController,EZAudioFileDelegate, EZAudioFFTDelegate ,/*EZMicrophoneDelegate,*/EZAudioPlayerDelegate {

    
    
    
    @IBOutlet var hanteiLabel: UILabel!
    
    @IBOutlet var hanteiLabel2: UILabel!
    
    @IBOutlet var hanteiLabel3: UILabel!
    
    @IBOutlet var hanteiLabel4: UILabel!
    
    @IBOutlet var hanteiLabel5: UILabel!
    
    @IBOutlet var hanteiLabel6: UILabel!
    
    @IBOutlet weak var poseImage: UIImageView!
    
    @IBOutlet weak var poseButton: UIButton!
    @IBOutlet weak var poseKyoku: UIButton!
    @IBOutlet weak var poseModoru: UIButton!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var lowerrightButton: UIButton!
    @IBOutlet weak var lowerleftButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var centerButton2: UIButton!
    override func makeTextWritingDirectionLeftToRight(sender: AnyObject?) {
        
    }
//    @IBOutlet var audioPlot:EZAudioPlot!
    
    @IBOutlet var audioPlotFreq:EZAudioPlot!
    
    @IBOutlet var audioPlotTime:EZAudioPlot!

    var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    var audio:AVAudioPlayer!
    
    var ezAudioFFT:EZAudioFFT!
    
    var audioFile:EZAudioFile!
    
    
    var fft:EZAudioFFTRolling!
    
    let FFTViewControllerFFTWindowSize:vDSP_Length = 4096;
    
     var audioPlayer:EZAudioPlayer!
    
    var speed: CGFloat = 10.0
    var speed2: CGFloat = 10.0
    
    var count: Float = 0.0
    var count2: Float = 0.0
    var count3: Float = 0.0
    var count4: Float = 0.0
    var count5: Float = 0.0
    var count6: Float = 0.0
    
    var timer: NSTimer = NSTimer()
    var timer2: NSTimer = NSTimer()
    var timer3: NSTimer = NSTimer()
    var timer4: NSTimer = NSTimer()
    var timer5: NSTimer = NSTimer()
    var timer6: NSTimer = NSTimer()


    var targetLabelArray = [UILabel]()
    var targetLabelArray2 = [UILabel]()
    var targetLabelArray3 = [UILabel]()
    var targetLabelArray4 = [UILabel]()
    var targetLabelArray5 = [UILabel]()
    var targetLabelArray6 = [UILabel]()
    
    

  
    
    
    
    //    var timingArray:float = [3.0,5.0,10.0]
    let timingArray: [Float] = [1.25, 0.63, 0.80, 0.75, 0.79,01.71, 01.85, 0.17, 0.85, 0.37, 0.20, 0.19, 0.20, 0.97, 0.21, 0.22, 0.41, 0.56, 0.21, 0.64, 0.37, 0.23, 0.56, 0.19, 0.29, 0.33, 0.20, 0.37, 0.24, 0.75, 0.22, 0.83, 0.44, 0.53, 0.19, 0.66, 0.34, 0.20, 0.22, 1.84, 0.23, 0.77, 0.20, 0.46, 0.36, 1.17, 0.25, 0.86, 0.29, 0.47, 1.31, 0.20, 0.30, 0.61, 0.28, 0.31, 1.27, 0.36, 0.37, 0.20, 1.56, 0.28, 0.34, 0.32, 0.31, 0.20, 0.21, 0.32, 0.26, 0.17, 0.20, 0.27, 0.53, 0.19, 0.22, 0.66, 0.41, 0.41, 0.29, 0.35, 0.69, 0.24, 0.35, 0.23, 0.37, 0.25, 0.61, 0.34, 0.65, 0.26, 0.58, 0.25, 0.20, 0.26, 0.21, 0.77, 0.21, 0.25, 1.09, 0.30, 0.24, 1.05, 0.31, 0.24, 1.10,0.27, 0.22, 1.03, 0.46, 0.67, 0.25, 0.57, 0.23, 0.59, 0.23, 0.59, 0.31, 0.49, 0.39, 0.36, 0.44, 0.36, 0.45, 0.37, 0.56, 0.22, 0.21, 0.23, 0.36, 0.39, 0.21, 0.25, 0.64, 0.28, 0.29, 0.66, 0.44, 0.40, 0.43, 0.24, 0.43, 0.30, 0.24, 0.67, 0.56, 0.36, 0.29, 0.80, 0.29, 0.27, 0.70, 0.26, 0.20, 0.26, 0.63, 0.61, 0.38, 0.94, 0.76, 0.21, 0.88, 0.33, 0.21, 0.21, 0.18, 1.03, 0.17, 1.07, 0.33, 0.19, 1.06, 0.20, 1.53, 0.16, 0.37, 0.30, 0.21, 0.45, 0.33, 0.24, 1.27, 0.50, 0.29, 0.74, ]
    //いつブロックを落とすか、秒数をまとめた配列
    
    let timingArray2: [Float] = [1.25, 0.63, 0.80, 0.75, 1.68, 1.60, 1.36, 0.16, 1.89, 0.18, 0.21, 0.88, 1.09, 0.26, 1.01, 0.21, 1.95, 0.23, 0.73, 0.25, 0.26, 0.38, 1.23, 0.18, 1.48, 0.19, 0.25, 0.26, 0.40, 0.71, 0.28, 0.78, 1.06, 1.09, 0.23, 0.63, 0.93, 0.26, 1.48, 0.58, 0.85, 0.40, 0.79, 0.23, 0.21, 0.71, 0.86, 0.43, 1.18, 0.31, 0.31, 0.71, 0.33, 0.43, 1.48, 0.25, 0.46, 0.41, 0.38, 0.56, 0.26, 0.76, 0.56, 0.64, 0.21, 0.38, 0.30, 0.93, 0.21, 0.40, 0.40, 0.50, 0.54, 0.28, 0.43, 0.25, 0.96, 0.41, 0.21, 1.38, 0.25, 0.98, 0.40, 0.19, 0.98, 0.18, 0.66, 0.78, 0.21, 0.63, 0.58, 0.36, 0.78, 0.83, 0.83, 0.76, 0.21, 0.18, 0.23, 0.44, 1.03, 0.61, 0.54, 0.21, 0.48,0.94, 1.00, 0.61, 0.23, 0.61, 0.95, 0.34, 0.55, 0.53, 0.23, 0.46, 0.71, 0.23, 0.41, 0.59, 0.58, 0.18, 0.20, 0.63, 0.76, 0.31, 0.56, 0.96, 0.26, 0.20, 0.18, 0.58, 0.18, 0.24, 0.24, 0.35, 0.56, 0.21, 0.26, 0.93, 0.23, 0.19, 0.51, 0.55, 0.36, 0.58, 0.43, 0.51, 0.24, 0.34, 0.30, 0.41, 0.73, 0.29, ]
    //いつブロックを落とすか、秒数をまとめた配列
    let timingArray3: [Float] = [1.25, 0.63, 0.80, 0.75, 1.68, 1.60, 1.36, 0.16, 1.89, 0.18, 0.21, 0.88, 1.09, 0.26, 1.01, 0.21, 1.95, 0.23, 0.73, 0.25, 0.26, 0.38, 1.23, 0.18, 1.48, 0.19, 0.25, 0.26, 0.40, 0.71, 0.28, 0.78, 1.06, 1.09, 0.23, 0.63, 0.93, 0.26, 1.48, 0.58, 0.85, 0.40, 0.79, 0.23, 0.21, 0.71, 0.86, 0.43, 1.18, 0.31, 0.31, 0.71, 0.33, 0.43, 1.48, 0.25, 0.46, 0.41, 0.38, 0.56, 0.26, 0.76, 0.56, 0.64, 0.21, 0.38, 0.30, 0.93, 0.21, 0.40, 0.40, 0.50, 0.54, 0.28, 0.43, 0.25, 0.96, 0.41, 0.21, 1.38, 0.25, 0.98, 0.40, 0.19, 0.98, 0.18, 0.66, 0.78, 0.21, 0.63, 0.58, 0.36, 0.78, 0.83, 0.83, 0.76, 0.21, 0.18, 0.23, 0.44, 1.03, 0.61, 0.54, 0.21, 0.48,0.94, 1.00, 0.61, 0.23, 0.61, 0.95, 0.34, 0.55, 0.53, 0.23, 0.46, 0.71, 0.23, 0.41, 0.59, 0.58, 0.18, 0.20, 0.63, 0.76, 0.31, 0.56, 0.96, 0.26, 0.20, 0.18, 0.58, 0.18, 0.24, 0.24, 0.35, 0.56, 0.21, 0.26, 0.93, 0.23, 0.19, 0.51, 0.55, 0.36, 0.58, 0.43, 0.51, 0.24, 0.34, 0.30, 0.41, 0.73, 0.29, ]
    
    let timingArray4: [Float] = [1.25, 0.63, 0.80, 0.75, 1.68, 1.60, 1.36, 0.16, 1.89, 0.18, 0.21, 0.88, 1.09, 0.26, 1.01, 0.21, 1.95, 0.23, 0.73, 0.25, 0.26, 0.38, 1.23, 0.18, 1.48, 0.19, 0.25, 0.26, 0.40, 0.71, 0.28, 0.78, 1.06, 1.09, 0.23, 0.63, 0.93, 0.26, 1.48, 0.58, 0.85, 0.40, 0.79, 0.23, 0.21, 0.71, 0.86, 0.43, 1.18, 0.31, 0.31, 0.71, 0.33, 0.43, 1.48, 0.25, 0.46, 0.41, 0.38, 0.56, 0.26, 0.76, 0.56, 0.64, 0.21, 0.38, 0.30, 0.93, 0.21, 0.40, 0.40, 0.50, 0.54, 0.28, 0.43, 0.25, 0.96, 0.41, 0.21, 1.38, 0.25, 0.98, 0.40, 0.19, 0.98, 0.18, 0.66, 0.78, 0.21, 0.63, 0.58, 0.36, 0.78, 0.83, 0.83, 0.76, 0.21, 0.18, 0.23, 0.44, 1.03, 0.61, 0.54, 0.21, 0.48,0.94, 1.00, 0.61, 0.23, 0.61, 0.95, 0.34, 0.55, 0.53, 0.23, 0.46, 0.71, 0.23, 0.41, 0.59, 0.58, 0.18, 0.20, 0.63, 0.76, 0.31, 0.56, 0.96, 0.26, 0.20, 0.18, 0.58, 0.18, 0.24, 0.24, 0.35, 0.56, 0.21, 0.26, 0.93, 0.23, 0.19, 0.51, 0.55, 0.36, 0.58, 0.43, 0.51, 0.24, 0.34, 0.30, 0.41, 0.73, 0.29, ]
    
    let timingArray5: [Float] = [1.25, 0.63, 0.80, 0.75, 1.68, 1.60, 1.36, 0.16, 1.89, 0.18, 0.21, 0.88, 1.09, 0.26, 1.01, 0.21, 1.95, 0.23, 0.73, 0.25, 0.26, 0.38, 1.23, 0.18, 1.48, 0.19, 0.25, 0.26, 0.40, 0.71, 0.28, 0.78, 1.06, 1.09, 0.23, 0.63, 0.93, 0.26, 1.48, 0.58, 0.85, 0.40, 0.79, 0.23, 0.21, 0.71, 0.86, 0.43, 1.18, 0.31, 0.31, 0.71, 0.33, 0.43, 1.48, 0.25, 0.46, 0.41, 0.38, 0.56, 0.26, 0.76, 0.56, 0.64, 0.21, 0.38, 0.30, 0.93, 0.21, 0.40, 0.40, 0.50, 0.54, 0.28, 0.43, 0.25, 0.96, 0.41, 0.21, 1.38, 0.25, 0.98, 0.40, 0.19, 0.98, 0.18, 0.66, 0.78, 0.21, 0.63, 0.58, 0.36, 0.78, 0.83, 0.83, 0.76, 0.21, 0.18, 0.23, 0.44, 1.03, 0.61, 0.54, 0.21, 0.48,0.94, 1.00, 0.61, 0.23, 0.61, 0.95, 0.34, 0.55, 0.53, 0.23, 0.46, 0.71, 0.23, 0.41, 0.59, 0.58, 0.18, 0.20, 0.63, 0.76, 0.31, 0.56, 0.96, 0.26, 0.20, 0.18, 0.58, 0.18, 0.24, 0.24, 0.35, 0.56, 0.21, 0.26, 0.93, 0.23, 0.19, 0.51, 0.55, 0.36, 0.58, 0.43, 0.51, 0.24, 0.34, 0.30, 0.41, 0.73, 0.29, ]
    
    let timingArray6: [Float] = [1.25, 0.63, 0.80, 0.75, 1.68, 1.60, 1.36, 0.16, 1.89, 0.18, 0.21, 0.88, 1.09, 0.26, 1.01, 0.21, 1.95, 0.23, 0.73, 0.25, 0.26, 0.38, 1.23, 0.18, 1.48, 0.19, 0.25, 0.26, 0.40, 0.71, 0.28, 0.78, 1.06, 1.09, 0.23, 0.63, 0.93, 0.26, 1.48, 0.58, 0.85, 0.40, 0.79, 0.23, 0.21, 0.71, 0.86, 0.43, 1.18, 0.31, 0.31, 0.71, 0.33, 0.43, 1.48, 0.25, 0.46, 0.41, 0.38, 0.56, 0.26, 0.76, 0.56, 0.64, 0.21, 0.38, 0.30, 0.93, 0.21, 0.40, 0.40, 0.50, 0.54, 0.28, 0.43, 0.25, 0.96, 0.41, 0.21, 1.38, 0.25, 0.98, 0.40, 0.19, 0.98, 0.18, 0.66, 0.78, 0.21, 0.63, 0.58, 0.36, 0.78, 0.83, 0.83, 0.76, 0.21, 0.18, 0.23, 0.44, 1.03, 0.61, 0.54, 0.21, 0.48,0.94, 1.00, 0.61, 0.23, 0.61, 0.95, 0.34, 0.55, 0.53, 0.23, 0.46, 0.71, 0.23, 0.41, 0.59, 0.58, 0.18, 0.20, 0.63, 0.76, 0.31, 0.56, 0.96, 0.26, 0.20, 0.18, 0.58, 0.18, 0.24, 0.24, 0.35, 0.56, 0.21, 0.26, 0.93, 0.23, 0.19, 0.51, 0.55, 0.36, 0.58, 0.43, 0.51, 0.24, 0.34, 0.30, 0.41, 0.73, 0.29, ]
    
    
    var timingCount:Int = 0
    var timingCount2:Int = 0
    var timingCount3:Int = 0
    var timingCount4:Int = 0
    var timingCount5:Int = 0
    var timingCount6:Int = 0
    //timingArray内の順番を切り替える変数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        audioPlot.backgroundColor = UIColor.orangeColor()
//        audioPlot.color = UIColor.whiteColor()
//        audioPlot.plotType = EZPlotType.Buffer //表示の仕方 Buffer or Rolling
//        audioPlot.shouldFill = true            //グラフの表示
//        //        self.audioPlot.shouldMirror = true          //グラフをx軸でミラーするか
//        audioPlot.shouldOptimizeForRealtimePlot = true //リアルタイム描写の最適化
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
        
        //        mic = EZMicrophone()
        //        mic.delegate = self
        
        
        
        
        fft = EZAudioFFTRolling(windowSize: FFTViewControllerFFTWindowSize, sampleRate: Float(self.audioPlayer.audioFile.clientFormat.mSampleRate), delegate: self)
        
        //if timer.valid {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01,target: self,
                                                       selector: #selector(self.up),userInfo: nil,repeats: true)
        
        
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01,target: self,
                                                        selector: #selector(self.up2),userInfo:
            nil,repeats: true)
        timer3 = NSTimer.scheduledTimerWithTimeInterval(0.01,target: self,
                                                        selector: #selector(self.up3),userInfo: nil,repeats: true)
//        timer4 = NSTimer.scheduledTimerWithTimeInterval(0.01,target: self,
//                                                       selector: #selector(self.up4),userInfo:   nil,repeats: true)
//                }
//        timer5 = NSTimer.scheduledTimerWithTimeInterval(0.01,target: self,
//                                                        selector: #selector(self.up5),userInfo: nil,repeats: true)
//        timer6 = NSTimer.scheduledTimerWithTimeInterval(0.01,target: self,
//                                                        selector: #selector(self.up5),userInfo: nil,repeats: true)
        
        
        
        //音楽ファィルの設定
//        if let audiopath = NSBundle.mainBundle().URLForResource("syugabita", withExtension: "mp3"){
//            
//            //audiopathに値に入ったら
//            do {
//                //audioが生成できるときはaudioを初期化、準備
//                audio = try AVAudioPlayer(contentsOfURL: audiopath)
//                //音楽を再生するメソッド
//                audio.play()
//            }catch {
//                //audioが生成できない時エラーになる
//                fatalError("プレイヤーが作れませんでした。")
//                
//            }
//        }else{
//            //audioPAthに値が入らなっかたらエラー
//            fatalError("audioPathに値が入りませんでした")
//        
//        }
    }
    
    func openFileWithFilePathURL(filePathURL:NSURL){
        self.audioFile = EZAudioFile(URL: filePathURL)
        self.audioFile.delegate = self
        
        var buffer = self.audioFile.getWaveformData().bufferForChannel(0)
        var bufferSize = self.audioFile.getWaveformData().bufferSize
        
//        print("openfile")
//        self.audioPlot.updateBuffer(buffer, withBufferSize: bufferSize)
        
    }
    
    func fft(fft: EZAudioFFT!, updatedWithFFTData fftData: UnsafeMutablePointer<Float>, bufferSize: vDSP_Length){
        
//        print("fft")
        var maxFrequency = fft.maxFrequency
        var noteName = EZAudioUtilities.noteNameStringForFrequency(maxFrequency, includeOctave: true)
        
        dispatch_async(dispatch_get_main_queue(), {
            
//            print("noteName:\(noteName),maxFrequency:\(maxFrequency)")
            self.audioPlotFreq.updateBuffer(fftData, withBufferSize: UInt32(80))
            
            print(fftData[9]*900)
            
            if fftData[9]*900 > 100 {
                
//                fftData[9]*900
//                fftData[5]*900
//                fftData[7]*900
//                fftData[3]*600
//                fftData[12]*600
//                fftData[0]*600
            print("///////////////////////////////////////////////////////////////////////////////////////////")
            }
            
            
        })
        
        
        var fftArray = self.ptrToArray(fftData, length: Int(40))
        
//        print(fftArray)
    }
    
    func ptrToArray(src: UnsafeMutablePointer<Float>, length: Int) -> Array<Float> {
        var dst = [Float](count: length, repeatedValue: 0.0)
        
        dst.withUnsafeMutableBufferPointer({
            ptr -> UnsafeMutablePointer<Float> in
            return ptr.baseAddress
        }).initializeFrom(src, count: length)
        
        return dst
    }
    
    func audioPlayer(audioPlayer: EZAudioPlayer!, playedAudio buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32, inAudioFile audioFile: EZAudioFile!){
        
        fft.computeFFTWithBuffer(buffer[0], withBufferSize: bufferSize)
        
        
        dispatch_async(dispatch_get_main_queue(),{
            
            self.audioPlotTime.updateBuffer(buffer[0], withBufferSize: bufferSize)
            
            
        })
        
    }

    
    
    
    
    func up () {
        
        let appframe:CGRect = UIScreen.mainScreen().bounds
        let x = (appframe.size.width - 100) / 3 * 2 + 50
        let sizeY = UIScreen.mainScreen().bounds.height
        
        
        //普通に配列に追加して動かせば？
        if (count >= timingArray[timingCount] || timingCount == 0){
            
            var targetLabel: UILabel = UILabel()
            targetLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2,UIScreen.mainScreen().bounds.size.height,50,50))
            //音の発生源調整
            targetLabel.text = "■"
            targetLabel.font = UIFont.systemFontOfSize(50)
            targetLabel.backgroundColor = UIColor.blackColor()
            targetLabel.tag = 0
            self.view.addSubview(targetLabel)
            
            targetLabelArray.append(targetLabel)
            
            timingCount += 1
            count = 0.0
        }
        
        if targetLabelArray.count != 0{
            
            var iNum = 0
            for i in 0..<targetLabelArray.count{
                
                if iNum == -1 {
                    break
                }
                
                if targetLabelArray[i].center.y > sizeY {
                    targetLabelArray[i].removeFromSuperview()
                    targetLabelArray.removeAtIndex(i)
                
                
                    iNum -= 1
                }else{
                    targetLabelArray[i].center.y += speed
                    iNum += 1
                    //                    targetLabelArray[i].bounds.width =
                    targetLabelArray[i].center.x += 35
                }
            }
        }
        
        count += 0.01
        
        if timingCount == timingArray.count-1 {
            timer.invalidate()
            timer2.invalidate()
            audioPlayer.pause()//stopからposeになった
            performSegueWithIdentifier("seguetest", sender: self)
        }
        
    }
    
    
    
    func up2 () {
        
        let appframe:CGRect = UIScreen.mainScreen().bounds
        let x = (appframe.size.width - 100) / 3 * 1 - 50
        let sizeY = UIScreen.mainScreen().bounds.height
        
        
        //普通に配列に追加して動かせば？
        if (count2 >= timingArray2[timingCount2] || timingCount2 == 0){
            
            var targetLabel2: UILabel = UILabel()
            targetLabel2 = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2,UIScreen.mainScreen().bounds.size.height,50,50))
            targetLabel2.text = "■"
            targetLabel2.font = UIFont.systemFontOfSize(50)
            targetLabel2.backgroundColor = UIColor.clearColor()
            targetLabel2.tag = 0
            self.view.addSubview(targetLabel2)
            
            targetLabelArray2.append(targetLabel2)
            
            timingCount2 += 1
            count2 = 0.0
        }
        
        if targetLabelArray2.count != 0{
            
            var iNum = 0
            for i in 0..<targetLabelArray2.count{
                
                if iNum == -1 {
                    break
                }
                
                if targetLabelArray2[i].center.y > sizeY {
                    targetLabelArray2[i].removeFromSuperview()
                    targetLabelArray2.removeAtIndex(i)
                    iNum -= 1
                }else{
                    targetLabelArray2[i].center.y += speed2
                    iNum += 1
                }
            }
        }
        
        count2 += 0.01
        
        if timingCount2 == timingArray2.count-1 {
            timer.invalidate()
            timer2.invalidate()
            audio.stop()
            performSegueWithIdentifier("seguetest", sender: self)
        }
        
    }
    
    func up3 () {
        
        let appframe:CGRect = UIScreen.mainScreen().bounds
        let x = (appframe.size.width - 100) / 3 * 2 + 50
        let sizeY = UIScreen.mainScreen().bounds.height
        
        
        //普通に配列に追加して動かせば？
        if (count3 >= timingArray3[timingCount3] || timingCount3 == 0){
            
            var targetLabel: UILabel = UILabel()
            targetLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2, UIScreen.mainScreen().bounds.size.height,50,50))
            targetLabel.text = "■"
            targetLabel.font = UIFont.systemFontOfSize(50)
            targetLabel.backgroundColor = UIColor.blackColor()
            targetLabel.tag = 0
            self.view.addSubview(targetLabel)
            
            targetLabelArray3.append(targetLabel)
            
            timingCount3 += 1
            count3 = 0.0
        }
        
        if targetLabelArray3.count != 0{
            
            var iNum = 0
            for i in 0..<targetLabelArray3.count{
                
                if iNum == -1 {
                    break
                }
                
                if targetLabelArray3[i].center.y > sizeY {
                    targetLabelArray3[i].removeFromSuperview()
                    targetLabelArray3.removeAtIndex(i)
                    iNum -= 1
                }else{
                    targetLabelArray3[i].center.y += speed
                    iNum += 1
                    //                    targetLabelArray3[i].bounds.width =
                    targetLabelArray3[i].center.x += 5
                }
            }
        }
        
        count += 0.01
        
        if timingCount3 == timingArray3.count-1 {
            timer.invalidate()
            timer2.invalidate()
            audio.stop()
            performSegueWithIdentifier("seguetest", sender: self)
        }
        
    }
    
        func up4 () {
    
            let appframe:CGRect = UIScreen.mainScreen().bounds
            let x = (appframe.size.width - 100) / 3 * 2 + 50
            let sizeY = UIScreen.mainScreen().bounds.height
    
    
            //普通に配列に追加して動かせば？
            if (count4 >= timingArray4[timingCount4] || timingCount4 == 0){
    
                var targetLabel: UILabel = UILabel()
                targetLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2,
                UIScreen.mainScreen().bounds.size.height/2, 50, 50))
                targetLabel.text = "■"
                targetLabel.font = UIFont.systemFontOfSize(50)
                targetLabel.backgroundColor = UIColor.blackColor()
                targetLabel.tag = 0
                self.view.addSubview(targetLabel)
    
                targetLabelArray4.append(targetLabel)
    
                timingCount4 += 1
                count4 = 0.0
            }
    
            if targetLabelArray4.count != 0{
    
                var iNum = 0
                for i in 0..<targetLabelArray4.count{
    
                    if iNum == -1 {
                        break
                    }
    
                    if targetLabelArray4[i].center.y > sizeY {
                        targetLabelArray4[i].removeFromSuperview()
                        targetLabelArray4.removeAtIndex(i)
                        iNum -= 1
                    }else{
                        targetLabelArray4[i].center.y += speed
                        iNum += 1
                        //                    targetLabelArray4[i].bounds.width =
                        targetLabelArray4[i].center.x += 5
                    }
                }
            }
    
            count += 0.01
    
            if timingCount4 == timingArray4.count-1 {
                timer.invalidate()
                timer2.invalidate()
                audio.stop()
                performSegueWithIdentifier("seguetest", sender: self)
            }
    
        }

    func up5 () {
        
        let appframe:CGRect = UIScreen.mainScreen().bounds
        let x = (appframe.size.width - 100) / 3 * 2 + 50
        let sizeY = UIScreen.mainScreen().bounds.height
        
        
        //普通に配列に追加して動かせば？
        if (count5 >= timingArray5[timingCount5] || timingCount5 == 0){
            
            var targetLabel: UILabel = UILabel()
            targetLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2, 25,50,50))
            targetLabel.text = "■"
            targetLabel.font = UIFont.systemFontOfSize(50)
            targetLabel.backgroundColor = UIColor.blackColor()
            targetLabel.tag = 0
            self.view.addSubview(targetLabel)
            
            targetLabelArray5.append(targetLabel)
            
            timingCount5 += 1
            count5 = 0.0
        }
        
        if targetLabelArray5.count != 0{
            
            var iNum = 0
            for i in 0..<targetLabelArray5.count{
                
                if iNum == -1 {
                    break
                }
                
                if targetLabelArray5[i].center.y > sizeY {
                    targetLabelArray5[i].removeFromSuperview()
                    targetLabelArray5.removeAtIndex(i)
                    iNum -= 1
                }else{
                    targetLabelArray5[i].center.y += speed
                    iNum += 1
                    //                    targetLabelArray5[i].bounds.width =
                    targetLabelArray5[i].center.x += 5
                }
            }
        }
        
        count += 0.01
        
        if timingCount5 == timingArray5.count-1 {
            timer.invalidate()
            timer2.invalidate()
            audio.stop()
            performSegueWithIdentifier("seguetest", sender: self)
        }
        
    }
    
    func hantei(number: Float) {
        
        
        
        if count > number - 0.02 && count < number + 0.02 {
            delegate.scoreTotal=delegate.scoreTotal+15
            
            
        }else if count > number - 0.10 && count < number + 0.10 {
            delegate.scoreTotal=delegate.scoreTotal+5
            
            
        }else {
            delegate.scoreTotal=delegate.scoreTotal+0
            
        }
    }
    
    
    func up6 () {
        
        let appframe:CGRect = UIScreen.mainScreen().bounds
        let x = (appframe.size.width - 100) / 3 * 2 + 50
        let sizeY = UIScreen.mainScreen().bounds.height
        
        
        //普通に配列に追加して動かせば？
        if (count >= timingArray[timingCount] || timingCount == 0){
            
            var targetLabel: UILabel = UILabel()
            targetLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2,25,50,50))
            targetLabel.text = "■"
            targetLabel.font = UIFont.systemFontOfSize(50)
            targetLabel.backgroundColor = UIColor.blackColor()
            targetLabel.tag = 0
            self.view.addSubview(targetLabel)
            
            targetLabelArray.append(targetLabel)
            
            timingCount += 1
            count = 0.0
        }
        
        if targetLabelArray.count != 0{
            
            var iNum = 0
            for i in 0..<targetLabelArray.count{
                
                if iNum == -1 {
                    break
                }
                
                if targetLabelArray[i].center.y > sizeY {
                    targetLabelArray[i].removeFromSuperview()
                    targetLabelArray.removeAtIndex(i)
                    iNum -= 1
                }else{
                    targetLabelArray[i].center.y += speed
                    iNum += 1
                    //                    targetLabelArray[i].bounds.width =
                    targetLabelArray[i].center.x += 35
                }
            }
        }
        
        count += 0.01
        
        if timingCount == timingArray.count-1 {
            timer.invalidate()
            timer2.invalidate()
            audio.stop()
            performSegueWithIdentifier("seguetest", sender: self)
        }
        
    }
    
    
    func hantei2(number: Float) {
        
        
        
        if count2 > number - 0.02 && count2 < number + 0.02 {
            delegate.scoreTotal=delegate.scoreTotal+15
            
            
        }else if count2 > number - 0.10 && count2 < number + 0.10 {
            delegate.scoreTotal=delegate.scoreTotal+5
            
            
        }else {
            delegate.scoreTotal=delegate.scoreTotal+0
            
        }
    }
    
    func hantei3(number: Float) {
        
        
        
        if count > number - 0.02 && count < number + 0.02 {
            delegate.scoreTotal=delegate.scoreTotal+15
            
            
        }else if count > number - 0.10 && count < number + 0.10 {
            delegate.scoreTotal=delegate.scoreTotal+5
            
            
        }else {
            delegate.scoreTotal=delegate.scoreTotal+0
            
        }
    }
    
    func hantei4(number: Float) {
        
        
        
        if count > number - 0.02 && count < number + 0.02 {
            delegate.scoreTotal=delegate.scoreTotal+15
            
            
        }else if count > number - 0.10 && count < number + 0.10 {
            delegate.scoreTotal=delegate.scoreTotal+5
            
            
        }else {
            delegate.scoreTotal=delegate.scoreTotal+0
            
        }
    }
    
    func hantei5(number: Float) {
        
        
        
        if count > number - 0.02 && count < number + 0.02 {
            delegate.scoreTotal=delegate.scoreTotal+15
            
            
        }else if count > number - 0.10 && count < number + 0.10 {
            delegate.scoreTotal=delegate.scoreTotal+5
            
            
        }else {
            delegate.scoreTotal=delegate.scoreTotal+0
            
        }
    }
    
    func hantei6(number: Float) {
        
        
        
        if count > number - 0.02 && count < number + 0.02 {
            delegate.scoreTotal=delegate.scoreTotal+15
            
            
        }else if count > number - 0.10 && count < number + 0.10 {
            delegate.scoreTotal=delegate.scoreTotal+5
            
            
        }else {
            delegate.scoreTotal=delegate.scoreTotal+0
            
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func pushButton() {
        //        hanteiLabel.text = hantei(10.0)
        //        hanteiLabel.text = hantei(5.0)
        //        hanteiLabel.text = hantei(9.0)
        //        hanteiLabel.text = hantei(12.0)
        //
        hantei(timingArray[timingCount])
        
            }
    
    @IBAction func pushButton2() {
        //        hanteiLabel.text = hantei(3.0)
        //        hanteiLabel.text = hantei(5.0)
        //        hanteiLabel.text = hantei(6.0)
        //        hanteiLabel.text = hantei(7.0)
        //        hanteiLabel.text = hantei(12.0)
        //
        //hantei2(timingArray2[timingCount2])
        
    }
    
    @IBAction func pushpause(sender: AnyObject) {
        timer.invalidate()
        timer2.invalidate()
        timer3.invalidate()
        timer4.invalidate()
        timer5.invalidate()
        timer6.invalidate()
        
//        audio.pause()
        audioPlayer.pause()
        
        
        poseImage.hidden = false
        poseKyoku.hidden = false
        poseButton.hidden = false
        poseModoru.hidden = false
        
        lowerrightButton.enabled = false
        rightButton.enabled = false
        lowerleftButton.enabled = false
        leftButton.enabled = false
        centerButton.enabled = false
        centerButton2.enabled = false
    }
    
    @IBAction func pushmodoru(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01,target: self,
                                                       selector: #selector(self.up),userInfo: nil,repeats: true)
        
        //timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01,target: self,
        //selector: #selector(self.up2),userInfo: nil,repeats: true)
        audioPlayer.play()
        
        poseImage.hidden = true
        poseKyoku.hidden = true
        
        poseModoru.hidden = true
        
        lowerrightButton.enabled = true
        rightButton.enabled = true
        lowerleftButton.enabled = true
        leftButton.enabled = true
        centerButton.enabled = true
    
    }
    

}
