//
//  SectionViewController.swift
//  DesignCodeApp
//
//  Created by Sergio Gomes on 09/05/18.
//  Copyright © 2018 Sergio Gomes. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var captionLabel: UILabel!
    
    @IBOutlet var coverImageView: UIImageView!
    
    @IBOutlet var progressLabel: UILabel!
    
    @IBOutlet var bodyLabel: UILabel!
    
    var section: [String:String]!
    var sections: [[String:String]]!
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = section ["title"]
        captionLabel.text = section ["caption"]
        bodyLabel.text = section ["body"]
        coverImageView.image = UIImage(named: section["image"]!)
        progressLabel.text = "\(indexPath.row+1) / \(sections.count)"
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
