//
//  PlaylistListViewController.swift
//  Magnify
//
//  Created by Ben Guo on 4/1/15.
//  Copyright (c) 2015 benzguo. All rights reserved.
//

import UIKit

class PlaylistListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let cellReuseId = "playlistCell"
    let showPlaylistSegueId = "showPlaylist"

    @IBOutlet weak var tableView: UITableView!
    var playlists: [SPTPartialPlaylist] = []

    override func viewDidLoad() {
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: cellReuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        loadPlaylists()
    }

    func loadPlaylists() {
        let session = SPTAuth.defaultInstance().session
        SPTRequest.playlistsForUserInSession(session,
            callback: { (err, obj) -> Void in
            let list = obj as? SPTPlaylistList
            list.map { self.parsePlaylistList($0) }
        })
    }

    func parsePlaylistList(list: SPTPlaylistList) {
        let items = list.items as [SPTPartialPlaylist]
        playlists = playlists + items
        tableView.reloadData()
        if list.hasNextPage {
            let session = SPTAuth.defaultInstance().session
            list.requestNextPageWithSession(session,
                callback: { (err, obj) -> Void in
                let nextList = obj as? SPTPlaylistList
                nextList.map { self.parsePlaylistList($0) }
            })
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseId,
            forIndexPath: indexPath) as UITableViewCell
        let playlist = playlists[indexPath.row]
        cell.textLabel?.text = playlist.name
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier(showPlaylistSegueId,
            sender: self.playlists[indexPath.row])
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == showPlaylistSegueId) {
            let destinationVC = segue.destinationViewController as PlaylistViewController
            let playlist = sender as SPTPartialPlaylist;
            destinationVC.partialPlaylist = playlist
            destinationVC.title = playlist.name
        }
    }

}
