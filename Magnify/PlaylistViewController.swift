//
//  PlaylistViewController.swift
//  Magnify
//
//  Created by Ben Guo on 4/3/15.
//  Copyright (c) 2015 benzguo. All rights reserved.
//

import UIKit


class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellReuseId = "songCell"

    @IBOutlet weak var tableView: UITableView!
    var partialPlaylist: SPTPartialPlaylist?
    var player: SPTAudioStreamingController?

    override func viewDidLoad() {
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: cellReuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        partialPlaylist.map { loadFullPlaylist($0) }
    }

    func loadFullPlaylist(partialPlaylist: SPTPartialPlaylist) {
        let session = SPTAuth.defaultInstance().session
        SPTRequest.requestItemFromPartialObject(partialPlaylist,
            withSession: session) { (err, obj) -> Void in
                let playlist = obj as SPTPlaylistSnapshot
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseId, forIndexPath: indexPath) as UITableViewCell
        return cell
    }

}
