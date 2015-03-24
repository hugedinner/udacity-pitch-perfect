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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        //
        // Legacy fixed "movie_quote" code
        // Removed in favor of the use of "receivedAudio"
        // passed in from the RecordAudioViewController
        //
        
        //        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        //        {
        //            var filePathURL = NSURL.fileURLWithPath(filePath)
        //            audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
        //            audioPlayer.enableRate = true
        //        }
        //        else
        //        {
        //            println("Failed to find filepath")
        //        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton)
    {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func playFastAudio(sender: UIButton)
    {
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func playChipmunkAudio(sender: UIButton)
    {
        
    }
    
    @IBAction func playVaderAudio(sender: UIButton)
    {
        
    }
    
    @IBAction func playEchoAudio(sender: UIButton)
    {
        
    }
    
    @IBAction func playReverbAudio(sender: UIButton)
    {
        
    }
    
    @IBAction func stopPlayback(sender: UIButton)
    {
        audioPlayer.stop()
    }
    
    
    
    
    
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
