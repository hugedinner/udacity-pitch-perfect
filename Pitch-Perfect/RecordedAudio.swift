//
//  RecordedAudio.swift
//  Pitch-Perfect
//
//  Created by Chris Cantwell on 24/03/2015.
//  Copyright (c) 2015 Chris Cantwell. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject
{
    var filePathUrl: NSURL!
    var title: String!

    init(filePath: NSURL, fileName: String)
    {
        filePathUrl = filePath
        title = fileName
        super.init()
    }
}

