//
//  IntroVC.swift
//  Collect
//
//  Created by Janko on 30/07/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

protocol IntroViewControllerDelegate{
    func showLoginVC()
}

class IntroVC: UIViewController {
    var delegate: IntroViewControllerDelegate?
    let screenHeight = UIScreen.main.bounds.height
    var currentScrollCell=0
    let screenWidth=UIScreen.main.bounds.width
    var lastContentOffset: CGFloat = 0
    var imagesArray = [UIImage(named: "intro1"),UIImage(named: "intro2"),UIImage(named: "intro3")]
    var sunLCConstant:CGFloat=0
    var sunBCConstant:CGFloat=0
    var sunHCConstant:CGFloat=0
    var sunWCConstant:CGFloat=0
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet var scrollAreaWidth: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    @IBOutlet var sunView: UIView!
    @IBOutlet var sunLC: NSLayoutConstraint!
    @IBOutlet var sunBC: NSLayoutConstraint!
    @IBOutlet var sunHC: NSLayoutConstraint!
    @IBOutlet var sunWC: NSLayoutConstraint!
    @IBOutlet var textView1: UIView!
    @IBOutlet var textView2: UIView!
    @IBOutlet var textView3: UIView!
    @IBOutlet var pageDotViewLC: NSLayoutConstraint!
    @IBOutlet var nextVCButtonBC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollAreaWidth.constant=410
        scrollView.decelerationRate = .fast
        imagesCollectionView.register(UINib(nibName:"IntroCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "introCell")
        imagesCollectionView.dataSource=self
        imagesCollectionView.delegate=self
        
    }
    override func viewDidLayoutSubviews() {
        contentView.setFlourishGradien(withColors: [#colorLiteral(red: 0.6494204402, green: 0.701274395, blue: 0.9527999759, alpha: 1), #colorLiteral(red: 0.7903054357, green: 0.4277911186, blue: 0.8458634019, alpha: 1),  #colorLiteral(red: 0.9582206607, green: 0.3124900162, blue: 0.3667482436, alpha: 1)], start: CGPoint(x: 0.4, y: 1), end: CGPoint(x: 0.6, y: 0))
    }
    override func viewDidAppear(_ animated: Bool) {
        sunLCConstant=sunLC.constant
        sunBCConstant=sunBC.constant
        sunHCConstant=sunHC.constant
        sunWCConstant=sunWC.constant
    }
    @IBAction func nextVCButton(_ sender: Any) {
        self.delegate?.showLoginVC()
    }
}

extension IntroVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "introCell", for: indexPath) as! IntroCollectionViewCell
        cell.viewImage.image=imagesArray[indexPath.row]
        if indexPath.row==0{
            cell.viewImage.alpha=1
        }
        return cell
    }
    
    
}
extension IntroVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 146)
    }
}

extension IntroVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset=scrollView.contentOffset.x
        changeAlphaImagesCollectionView(contentOffset: contentOffset)
        scrollSunView(contentOffset:contentOffset)
        scrollImagesCollectionView(contentOffset: contentOffset)
        scrollPageDot(contentOffset: contentOffset)
        scrollNextVCButton(contentOffset: contentOffset)
    }
    func scrollSunView(contentOffset:CGFloat){
        if contentOffset<200{
            sunLC.constant=sunLCConstant-contentOffset/2.5
            sunBC.constant=sunBCConstant+contentOffset/5
            sunHC.constant=sunHCConstant+contentOffset/5
            sunWC.constant=sunHCConstant+contentOffset/5
        }else if contentOffset>200 && contentOffset<340{
            sunLC.constant = -15+contentOffset/9.1
            sunBC.constant = 53-contentOffset/6
            sunHC.constant=sunHCConstant+contentOffset/4
            sunWC.constant=sunHCConstant+contentOffset/4
            
        }
    }
    func scrollImagesCollectionView(contentOffset:CGFloat){
        imagesCollectionView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x, y: 0), animated: false)
    }
    
    func changeAlphaImagesCollectionView(contentOffset:CGFloat){
        if contentOffset<screenWidth/2{
            let cell=imagesCollectionView.cellForItem(at:IndexPath(row: 0, section: 0)) as? IntroCollectionViewCell
            cell?.viewImage.alpha=1-imagesCollectionView.contentOffset.x/180
            textView1.alpha=1-imagesCollectionView.contentOffset.x/180
            let cell2=imagesCollectionView.cellForItem(at:IndexPath(row: 1, section: 0)) as? IntroCollectionViewCell
            cell2?.viewImage.alpha=imagesCollectionView.contentOffset.x/200
            textView2.alpha=imagesCollectionView.contentOffset.x/200
        }else if 2.3*contentOffset>screenWidth{
            let cell=imagesCollectionView.cellForItem(at:IndexPath(row: 1, section: 0)) as? IntroCollectionViewCell
            let math=1-CGFloat((Int(contentOffset)-200))/210
            cell?.viewImage.alpha=math
            textView2.alpha=math
            let cell2=imagesCollectionView.cellForItem(at:IndexPath(row: 2, section: 0)) as? IntroCollectionViewCell
            cell2?.viewImage.alpha=contentOffset/410
            textView3.alpha=(contentOffset-190)/390
            if contentOffset>404{
                textView3.alpha=1
            }else if contentOffset<250{
                textView3.alpha=0
            }
        }
    }
    func scrollPageDot(contentOffset:CGFloat){
        pageDotViewLC.constant=9.9/100*contentOffset
    }
    func scrollNextVCButton(contentOffset:CGFloat){
        if contentOffset>210{
            nextVCButtonBC.constant =  110-contentOffset/4-0.09*contentOffset
        }
        if contentOffset<210{
            nextVCButtonBC.constant = -screenHeight
        }
    }
}
