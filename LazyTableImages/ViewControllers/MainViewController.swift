//
//  MainViewController.swift
//  LazyTableImages
//
//  Created by seoju on 2018. 6. 20..
//  Copyright © 2018년 seoju. All rights reserved.
//

import UIKit

struct CellID {
    static var lazyTableCell = "LazyTableCell"
    static var placeholderCellIdentifier = "PlaceholderCell"
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var entries: [AppRecord] = []
    var imageDownloadsInProgress : Dictionary<Int,IconDownloader> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellID.lazyTableCell, for: indexPath)
        
        
        return cell
    }
}
