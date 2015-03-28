//
//  RecordAudioViewController.swift
//  Pitch-Perfect
//
//  Created by Chris Cantwell on 23/03/2015.
//  Copyright (c) 2015 Chris Cantwell. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate
{
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    override func viewWillAppear(animated: Bool)
    {
        stopButton.hidden = true
        recordingInProgress.text = "Tap to Record"
    }

    
    @IBAction func recordAudio(sender: UIButton)
    {
        stopButton.hidden = false

        //
        // Record/Pause/Resume depending on existence of
        // audioRecorder instance and whether it is 
        // already recording or not
        //
        if ((audioRecorder) != nil)
        {
            if (audioRecorder.recording)
            {
                audioRecorder.pause()
                recordingInProgress.text = "PAUSED - Tap to Resume"
            }
            else
            {
                audioRecorder.record()
                recordingInProgress.text = "RECORDING - Tap to Pause"
            }
        }
        else
        {
            recordingInProgress.text = "RECORDING - Tap to Pause"
            
            //
            // Set up path and filename for recording file
            //
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            var currentDateTime = NSDate()
            var formatter = NSDateFormatter()
            formatter.dateFormat = "ddMMyyyy-HHmmss"
            var recordingName = formatter.stringFromDate(currentDateTime)+".wav"
            var pathArray = [dirPath, recordingName]
            let filePath = NSURL.fileURLWithPathComponents(pathArray)
            
            //
            // Prepare Audio "Session" ???
            //
            var session = AVAudioSession.sharedInstance()
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            
            //
            // Prepare and start the recording
            //
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }
    }

    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
    {
        //
        // Only make the jump to the Play Sounds view if processing
        // the recording has completed... and it was successful
        //
        if (flag)
        {
            //
            // Using the RecordedAudio class created,
            // initialise it and set its properties
            //
            recordedAudio = RecordedAudio(filePath: recorder.url, fileName: recorder.url.lastPathComponent!)
            
            //
            // Make the segue from this view to the Play Sounds view
            // 'passing' the recordedAudio instance
            //
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            //
            // Oops - that wasn't in the plan!
            // Real device would need somethibg more
            // robust here.
            //
            println("Recording was not successful")
            stopButton.hidden = true
            recordingInProgress.text = "Tap to Record"
        }
    }

    
    //
    // Although we've said perforSegueWithIdentifier in ..DidFinishRecording above
    // it's not yet 'passing' anything through - just the view destination
    // and path and filename (in the recordedAudio object)
    //
    // Need to "prepareForSegue"
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "stopRecording") // Check why we are here - in case of multiple segues out of this view
        {
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            
            //
            // Need something ("receivedAudio") in the target
            // view PlaySoundsViewController to receive 
            // "data" (above) that we are about to send
            //
            playSoundsVC.receivedAudio = data
        }
    }

    
    @IBAction func stopAudio(sender: UIButton)
    {
        stopButton.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }    
}

