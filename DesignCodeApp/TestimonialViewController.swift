//
//  TestimonialViewController.swift
//  DesignCodeApp
//
//  Created by Sergio Gomes on 10/05/18.
//  Copyright © 2018 Sergio Gomes. All rights reserved.
//

import UIKit

class TestimonialViewController: UIViewController {

    @IBOutlet var testimonialCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testimonialCollectionView.delegate = self
        testimonialCollectionView.dataSource = self
    }

}

extension TestimonialViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testimonials.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testimonialCell", for: indexPath) as! TestimonialCollectionViewCell
        
        let testimonial = testimonials[indexPath.row]
        cell.testimonialText.text = testimonial["text"]
        cell.jobLabel.text = testimonial["job"]
        cell.nameLabel.text = testimonial["name"]
        cell.avatarImageView.image = UIImage(named : testimonial["avatar"]!)
        
        return cell
    }
    
    
}
