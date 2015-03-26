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
    }
    
    @IBAction func recordAudio(sender: UIButton)
    {
        //
        // Initialise button states
        //
        recordButton.enabled = false
        stopButton.hidden = false
        recordingInProgress.text = "Recording in Progress"
        
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
        // Declare, prepare and start the recording
        //
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
    {
        if (flag)
        {
            //
            // Using the RecordedAudio class we created
            // Initialise and set the properties
            // Now using the classes constructor
            //
            recordedAudio = RecordedAudio(filePath: recorder.url, fileName: recorder.url.lastPathComponent!)
            
            //
            // Remember we named the segue from the recording view
            // to the playback view as "stopRecording" in the storyboard
            // we now make the segue from here to there passing recordedAudio
            //
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            println("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }

    //
    // Although we've said perforSegueWithIdentifier in ..DidFinishRecording above
    // it's not yet passing anything through - just the view destination
    // and path and filename (in the recordedAudio object)
    //
    // Need to "prepareForSegue"
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "stopRecording") // In case of multiple segues out of this view
        {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            
            //
            // Need something ("receivedAudio") over the other side in PlaySoundsViewController
            // to receive "data" (above) that we are about to send
            //
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopAudio(sender: UIButton)
    {
        //
        // Initialise button states ???
        //
        recordButton.enabled = true
        stopButton.hidden = true
        recordingInProgress.text = "Tap to Record"
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    
    /////////////////////
    //
    //   THE END! :)
    //
    ////////////////////
}

