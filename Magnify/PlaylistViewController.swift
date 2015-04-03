//
//  PlaylistViewController.swift
//  Magnify
//
//  Created by Ben Guo on 4/3/15.
//  Copyright (c) 2015 benzguo. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController, SPTAudioStreamingPlaybackDelegate {
    let cellReuseId = "songCell"

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    lazy var timer: NSTimer = {
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerTick", userInfo: nil, repeats: true)
    }()
    var currentTime: Int = 0
    var minTime: Int = 30
    var targetTime: Int = 30
    var timeExtensionRange: UInt32 = 20

    var partialPlaylist: SPTPartialPlaylist?
    lazy var player: SPTAudioStreamingController = {
        let clientId = SPTAuth.defaultInstance().clientID
        let player = SPTAudioStreamingController(clientId: clientID)
        player.playbackDelegate = self;
        player.diskCache = SPTDiskCache(capacity: 1024 * 1024 * 64)
        player.shuffle = true
        player.repeat = true
        return player
    }()

    override func viewDidLoad() {
        partialPlaylist.map { self.playURI($0.uri) }
        timer.fire()
    }

    @IBAction func nextButtonAction(sender: UIButton) {
        skipTrack()
    }

    func skipTrack() {
        player.skipNext { (err) -> Void in
            if err != nil {
                return
            }
            self.currentTime = 0
            self.progressView.setProgress(1, animated: true)
            self.targetTime = self.minTime + Int(arc4random_uniform(self.timeExtensionRange))
        }
    }

    func timerTick() {
        if currentTime == targetTime {
            skipTrack()
        }
        else {
            currentTime = (currentTime + 1)%1000
            progressView.setProgress(Float(targetTime-currentTime)/Float(targetTime),
                animated: true)
        }
    }

    func playURI(uri: NSURL) {
        let session = SPTAuth.defaultInstance().session
        player.loginWithSession(session, callback: { (err) -> Void in
            self.player.playURIs([uri], fromIndex: 0) { (err) -> Void in

            }
        })
    }

    func updateWithCurrentTrackURI(uri: NSURL) {
        let session = SPTAuth.defaultInstance().session
        SPTTrack.trackWithURI(uri, session: session) { (err, obj) -> Void in
            let maybeTrack = obj as? SPTTrack
            if let track = maybeTrack {
                self.artistLabel.text = track.artists.first.map { $0.name }
                self.trackLabel.text = track.name
            }
        }
    }

    func audioStreaming(audioStreaming: SPTAudioStreamingController!, didChangeToTrack trackMetadata: [NSObject : AnyObject]!) {
        updateWithCurrentTrackURI(player.currentTrackURI)
    }
}
