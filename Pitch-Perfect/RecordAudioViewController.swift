//
//  RecordAudioViewController.swift
//  Pitch-Perfect
//
//  Created by Chris Cantwell on 23/03/2015.
//  Copyright (c) 2015 Chris Cantwell. All rights reserved.
//

import UIKit
import AVFoundation

//
// See Lesson 4a Video 8 for Delegates
// and use of AVAudioRecorderDelegate ???
//
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool)
    {
        stopButton.hidden = true
    }
    
    @IBAction func recordAudio(sender: UIButton)
    {
        //
        // Initialise button states
        //
        recordButton.enabled = false
        stopButton.hidden = false
        recordingInProgress.hidden = false
        
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
        println(filePath)
        
        //
        // Prepare "Audio Session" ???
        //
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //
        // Declare, prepare and start the recording
        //
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)

        //
        // See Lesson 4a Video 8 for Delegates
        // and use of audioRecorder.delegate = self ???
        //
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    //
    // See Lesson 4a Video 8 for Delegates
    // and use of AVAudioRecorderDelegate ???
    //
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
    {
        if (flag)
        {
            //
            // Using the RecordedAudio class we created
            // Initialise and set the properties
            //
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            
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
            //
            // REVISIT THIS in Lesson 4b Video 13 - DIDNT QUITE UNDERSTAND!!!
            //
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
        recordingInProgress.hidden = true

        //
        // Stop recording
        // And "Audio Session" ???
        // Google why we do this !!!
        //
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

