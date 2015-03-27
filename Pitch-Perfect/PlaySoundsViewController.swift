//
//  PlaySoundsViewController.swift
//  Pitch-Perfect
//
//  Created by Chris Cantwell on 23/03/2015.
//  Copyright (c) 2015 Chris Cantwell. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController
{
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!

    // for sound effects
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    // Audio effect constants
    let slowSpeed:Float = 0.5
    let fastSpeed:Float = 2.0
    let highPitch:Float = 1000.0
    let lowPitch:Float  = -750.0
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        //
        // for sound effects
        //
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func playSlowAudio(sender: UIButton)
    {
        playAudioWithVariableSpeed(slowSpeed)
    }

    
    @IBAction func playFastAudio(sender: UIButton)
    {
        playAudioWithVariableSpeed(fastSpeed)
    }

    
    @IBAction func playChipmunkAudio(sender: UIButton)
    {
        playAudioWithVariablePitch(highPitch)
    }

    
    @IBAction func playVaderAudio(sender: UIButton)
    {
        playAudioWithVariablePitch(lowPitch)
    }

    
    @IBAction func stopPlayback(sender: UIButton)
    {
        audioPlayer.stop()
        audioEngine.stop()
    }

    
    //
    // For playing with Slow/Fast effects
    //
    func playAudioWithVariableSpeed(pitch: Float)
    {
        audioEngine.stop()  // task 3
        audioEngine.reset() // task 3
        audioPlayer.stop()
        audioPlayer.rate = pitch
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    
    //
    // For playing with Chipmunk/Vader effects
    //
    func playAudioWithVariablePitch(pitch: Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }

    
    //
    // For playing with Echo effect
    //
    @IBAction func playEchoAudio(sender: UIButton)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var echoEffect = AVAudioUnitDistortion()
        echoEffect.loadFactoryPreset(AVAudioUnitDistortionPreset.MultiEcho1)
        echoEffect.wetDryMix = 50
        audioEngine.attachNode(echoEffect)

        audioEngine.connect(audioPlayerNode, to: echoEffect, format: nil)
        audioEngine.connect(echoEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    //
    // For playing with Reverb effect
    //
    @IBAction func playReverbAudio(sender: UIButton)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.LargeChamber)
        reverbEffect.wetDryMix = 50
        audioEngine.attachNode(reverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    
    /////////////////////
    //
    //   THE END! :)
    //
    ////////////////////
}



