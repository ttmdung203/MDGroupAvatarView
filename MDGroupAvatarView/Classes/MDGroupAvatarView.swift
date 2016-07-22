//
//  MDGroupAvatarView.swift
//  MDGroupAvatarView
//
//  Created by Tran Dung on 4/6/16.
//  Copyright © 2016 Dungttm. All rights reserved.
//
import UIKit
import SDWebImage

class MDGroupAvatarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var avatarUrls = Array<NSURL>()
    private var avatarImages = Array<UIImage>()
    private var avatarCollectionView : UICollectionView?
    private var realTotal : Int = 0
    var placeHolderImage: UIImage?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        avatarUrls = Array<NSURL>()
        
        let flowLayout = MDAvatarCollectionViewLayout()

        avatarCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        avatarCollectionView?.dataSource = self
        avatarCollectionView?.backgroundColor = UIColor.clearColor()
        avatarCollectionView?.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "AvatarCell")
        addSubview(avatarCollectionView!)
        
        avatarCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: avatarCollectionView!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: avatarCollectionView!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: avatarCollectionView!, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: avatarCollectionView!, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        setNeedsUpdateConstraints()
    }
    
    //MARK: Public
    func setAvatarUrl(urls: Array<NSURL>?, realTotal : Int){
        avatarImages.removeAll()
        avatarUrls = urls == nil ? Array<NSURL>() :  Array<NSURL>(urls!)
        self.realTotal = realTotal
        avatarCollectionView?.reloadData()
    }
    
    func setAvatarImages(images: Array<UIImage>?, realTotal : Int) {
        avatarUrls.removeAll()
        avatarImages = images == nil ? Array<UIImage>() : Array<UIImage>(images!)
        self.realTotal = realTotal
        avatarCollectionView?.reloadData()
    }
    
    //MARK: UICollectionViewDataSource
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AvatarCell", forIndexPath: indexPath)
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        let data = getDataList()
        let view = indexPath.item >= 3 && self.realTotal > 4 ? UILabel(frame: cell.bounds) : UIImageView(frame: cell.bounds)
        cell.addSubview(view)
        
        if view is UIImageView {
            let imageView = view as! UIImageView
            imageView.contentMode = .ScaleAspectFill
            if indexPath.row < data.count {
                let imageData = data[indexPath.row]
                if let imageUrl = imageData as? NSURL {
                    imageView.sd_setImageWithURL(imageUrl, placeholderImage: placeHolderImage)
                } else if let image = imageData as? UIImage {
                    imageView.image = image
                } else {
                    imageView.image = placeHolderImage
                }
            } else {
                imageView.image = placeHolderImage
            }
        } else {
            if view is UILabel {
                let label = view as! UILabel
                label.backgroundColor = UIColor.lightGrayColor()
                label.textColor = UIColor.whiteColor()
                label.font = UIFont.systemFontOfSize(13)
                label.textAlignment = NSTextAlignment.Center
                label.text = "\(self.realTotal ?? 0)"
            }
        }

        view.layer.cornerRadius = view.frame.size.width / 2
        view.layer.borderWidth = collectionView.numberOfItemsInSection(0) == 2 || collectionView.numberOfItemsInSection(0) == 3 ? 1 : 0
        view.layer.borderColor = UIColor.whiteColor().CGColor
        view.clipsToBounds = true
        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, realTotal)
    }
    
    //MARK: Helper
    private func getDataList() -> Array<AnyObject> {
        return avatarImages.count > 0 ? avatarImages : avatarUrls
    }
    
}

class MDAvatarCollectionViewLayout : UICollectionViewLayout {
    private var cache = [UICollectionViewLayoutAttributes]()
    
    override func prepareLayout() {
        super.prepareLayout()
        cache.removeAll()
        if collectionView!.numberOfItemsInSection(0) > 0 {
            for index in 0...(collectionView!.numberOfItemsInSection(0) - 1) {
                let indexPath = NSIndexPath(forItem: index, inSection: 0)
                let attribute = calculateCellLayoutAttribute(indexPath)
                cache.append(attribute)
            }
        }
        
    }
    
    private func calculateCellLayoutAttribute(indexPath : NSIndexPath) -> UICollectionViewLayoutAttributes{
        let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        if collectionView != nil  {
            var frame = collectionView!.frame
            switch collectionView!.numberOfItemsInSection(indexPath.section) {
            case 1:
                frame = CGRectMake(0, 0, collectionView!.frame.width, collectionView!.frame.height)
                break
            case 2:
                frame.size = CGSizeMake(collectionView!.frame.width * 0.65, collectionView!.frame.height * 0.65)
                frame.origin = indexPath.row == 0 ? CGPointZero : CGPointMake(collectionView!.frame.width * 0.35, collectionView!.frame.height * 0.35)
                break
            case 3:
                let cellRatio : CGFloat = 0.55
                frame.size = CGSizeMake(collectionView!.frame.width * cellRatio, collectionView!.frame.height * cellRatio)
                if indexPath.row == 0 {
                    frame.origin = CGPointMake(collectionView!.frame.width * (1 - cellRatio) * 0.5, 0)
                } else if indexPath.row == 1 {
                    frame.origin = CGPointMake(0, collectionView!.frame.height * (1 - cellRatio))
                } else {
                    frame.origin = CGPointMake(collectionView!.frame.width * (1 - cellRatio), collectionView!.frame.height * (1 - cellRatio))
                }
                break
            case 4:
                let cellRatio : CGFloat = 0.5
                frame.size = CGSizeMake(collectionView!.frame.width * cellRatio, collectionView!.frame.height * cellRatio)
                frame.origin.x = indexPath.row % 2 == 0 ? 0 : collectionView!.frame.width * (1 - cellRatio)
                frame.origin.y = indexPath.row < 2 ? 0 : collectionView!.frame.height * (1 - cellRatio)
                break
            default:
                break
                
            }
            attribute.frame = frame
        }
        return attribute
    }

    override func collectionViewContentSize() -> CGSize {
        if collectionView == nil {
            return CGSizeZero
        }
        return collectionView!.frame.size
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }

}
