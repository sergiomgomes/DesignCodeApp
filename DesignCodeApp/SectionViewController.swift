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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var coverView: UIView!
    
    @IBOutlet weak var subheadVisualEffectView: UIVisualEffectView!
    
    @IBOutlet weak var closeVisualEffectView: UIVisualEffectView!
    
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
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
