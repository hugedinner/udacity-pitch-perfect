//
//  RecordAudioViewController.swift
//  Pitch-Perfect
//
//  Created by Chris Cantwell on 23/03/2015.
//  Copyright (c) 2015 Chris Cantwell. All rights reserved.
//

import UIKit

class RecordAudioViewController: UIViewController
{

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
        recordButton.enabled = false
        stopButton.hidden = false
        recordingInProgress.hidden = false
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
}

