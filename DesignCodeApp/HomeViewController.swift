//
//  ViewController.swift
//  DesignCodeApp
//
//  Created by Sergio Gomes on 08/05/18.
//  Copyright © 2018 Sergio Gomes. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var playVisualEfectView: UIVisualEffectView!
    
    @IBOutlet var deviceImageView: UIImageView!
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var heroView: UIView!
    
    @IBOutlet var bookView: UIView!
    
    var isStatusBarHidden = false
    
    let presentSectionViewController = PresentSectionViewController()
    
    @IBAction func playButtonTapped(_ sender: Any) {
        let urlString = "https://player.vimeo.com/external/235468301.hd.mp4?s=e852004d6a46ce569fcf6ef02a7d291ea581358e&profile_id=175"
        
        let url = URL(string: urlString)
        let player = AVPlayer(url: url!)
        
        let playerController = AVPlayerViewController()
        playerController.player = player
        
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    @IBOutlet var chapterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        scrollView.delegate = self
        chapterCollectionView.delegate = self
        chapterCollectionView.dataSource = self
        
        titleLabel.alpha = 0
        playVisualEfectView.alpha = 0
        deviceImageView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.titleLabel.alpha = 1
            self.playVisualEfectView.alpha = 1
            self.deviceImageView.alpha = 1
        }
        
        /* SET Top bar
         
        addBlurStatusBar()
        
        setStatusBarBackgroundColor(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        isStatusBarHidden = false
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 50)
        ]
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    func addBlurStatusBar(){
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let blur = UIBlurEffect(style: .dark)
        let blurStatusBar = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: statusBarHeight))
        blurStatusBar.effect = blur
        
        view.addSubview(blurStatusBar)
    }
    
    func setStatusBarBackgroundColor(color: UIColor){
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else{
            return
        }
        
        statusBar.backgroundColor = color
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToSection" {
            let destination = segue.destination as! SectionViewController
            let indexPath = sender as! IndexPath
            
            let section = sections[indexPath.row]
            destination.section = section
            destination.sections = sections
            destination.indexPath = indexPath
            destination.transitioningDelegate = self
            
            let attributes = chapterCollectionView.layoutAttributesForItem(at: indexPath)!
            let cellFrame = chapterCollectionView.convert(attributes.frame, to: view)
            
            presentSectionViewController.cellFrame = cellFrame
            presentSectionViewController.cellTransform = animateCell(cellFrame: cellFrame)
            
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.5, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })
        }
    }
}

extension HomeViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        let navigationIsHidden = offsetY <= 0
        navigationController?.setNavigationBarHidden(navigationIsHidden, animated: true)
        
        if offsetY < 0 {
            heroView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            playVisualEfectView.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
            titleLabel.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
            deviceImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/4)
            backgroundImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
        }
        
        if let collectionView = scrollView as? UICollectionView {
            for cell in collectionView.visibleCells as! [SectionCollectionViewCell]{
                let indexPath = collectionView.indexPath(for: cell)
                let attributes = collectionView.layoutAttributesForItem(at: indexPath!)
                
                let cellFrame = collectionView.convert((attributes?.frame)!, to: view)
                
                let translationX = cellFrame.origin.x / 5
                cell.coverImageView.transform = CGAffineTransform(translationX: translationX, y: 0)
                
                cell.layer.transform = animateCell(cellFrame: cellFrame)
            }
        }
    }
    
    func animateCell(cellFrame: CGRect) -> CATransform3D{
        
        //Rotate Card
        let angleFromX = Double((-cellFrame.origin.x) / 10)
        let angle = CGFloat((angleFromX * Double.pi) / 180.0)
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)
        
        //Scale Card
        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        let scaleMax: CGFloat = 1.0
        let scaleMin: CGFloat = 0.6
        
        if scaleFromX > scaleMax{
            scaleFromX = scaleMax
        }
        
        if scaleFromX < scaleMin {
            scaleFromX = scaleMin
        }
        
        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)
        
        // Return Transformation
        return CATransform3DConcat(rotation, scale)
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell", for: indexPath) as! SectionCollectionViewCell
        
        let section = sections[indexPath.row]
        cell.captionLabel.text = section["caption"]
        cell.titleLabel.text = section["title"]
        cell.coverImageView.image = UIImage(named : section["image"]!)
        
        cell.layer.transform = animateCell(cellFrame: cell.frame)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "homeToSection", sender: indexPath)
    }
}

extension HomeViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return presentSectionViewController
    }
    
}

