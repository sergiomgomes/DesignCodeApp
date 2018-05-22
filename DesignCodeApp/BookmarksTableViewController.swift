//
//  BookmarksTableViewController.swift
//  DesignCodeApp
//
//  Created by Sergio Gomes on 22/05/18.
//  Copyright © 2018 Sergio Gomes. All rights reserved.
//

import UIKit

class BookmarksTableViewController: UITableViewController {
    
    var bookmarks: Array<Dictionary<String,String>> = allBookmarks

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! BookmarkTableViewCell
        
        let bookmark = bookmarks[indexPath.row]
        
        cell.chapterTitleLabel.text = bookmark["section"]?.uppercased()
        cell.titleLabel.text = bookmark["part"]
        cell.bodyLabel.text = bookmark["content"]
        cell.chapterNumberLabel.text = bookmark["chapter"]
        cell.badgeImageView.image = UIImage(named : "Bookmarks/" + bookmark["type"]!)

        return cell
    }

}
