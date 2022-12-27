//
//  MDGroupAvatarView.swift
//  MDGroupAvatarView
//
//  Created by Tran Dung on 4/6/16.
//  Copyright © 2016 Dungttm. All rights reserved.
//
import UIKit
import SDWebImage

/// view contains avatars of group.
class MDGroupAvatarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    fileprivate var avatarUrls = Array<URL>()
    fileprivate var avatarImages = Array<UIImage>()
    fileprivate var avatarCollectionView : UICollectionView?
    fileprivate var realTotal : Int = 0
    var placeHolderImage: UIImage?
    
    /// Initialize with decoder
    /// - Parameter aDecoder: decoder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        avatarUrls = Array<URL>()
        
        let flowLayout = MDAvatarCollectionViewLayout()

        avatarCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        avatarCollectionView?.dataSource = self
        avatarCollectionView?.backgroundColor = UIColor.clear
        avatarCollectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "AvatarCell")
        addSubview(avatarCollectionView!)
        
        avatarCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: avatarCollectionView!,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .top,
                                         multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: avatarCollectionView!,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: avatarCollectionView!,
                           attribute: .leading,
                           relatedBy:  .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: avatarCollectionView!,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0).isActive = true
        setNeedsUpdateConstraints()
    }
    
    /// Set list of avatar (NSURL), the avatar'll be downloaded from the url. (use framework SDWebImage)
    /// - Parameters:
    ///   - urls: List of avatars (4 item at most)
    ///   - realTotal: total of group, if number is greater than 4, the count is displayed on the last item.
    func setAvatarUrl(_ urls: Array<URL>?, realTotal : Int){
        avatarImages.removeAll()
        avatarUrls = urls == nil ? Array<URL>() :  Array<URL>(urls!)
        self.realTotal = realTotal
        avatarCollectionView?.reloadData()
    }
    
    /// Set list of avatar (UIImage)
    /// - Parameters:
    ///   - images: List of avatars (4 item at most)
    ///   - realTotal: total of group, if number is greater than 4, the count is displayed on the last item.
    func setAvatarImages(_ images: Array<UIImage>?, realTotal : Int) {
        avatarUrls.removeAll()
        avatarImages = images == nil ? Array<UIImage>() : Array<UIImage>(images!)
        self.realTotal = realTotal
        avatarCollectionView?.reloadData()
    }
    
    //MARK: UICollectionViewDataSource
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath)
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        let data = getDataList()
        let view = indexPath.item >= 3 && self.realTotal > 4 ? UILabel(frame: cell.bounds) : UIImageView(frame: cell.bounds)
        cell.addSubview(view)
        
        if view is UIImageView {
            let imageView = view as! UIImageView
            imageView.contentMode = .scaleAspectFill
            if indexPath.row < data.count {
                let imageData = data[indexPath.row]
                if let imageUrl = imageData as? URL {
                    imageView.sd_setImage(with: imageUrl, placeholderImage: placeHolderImage)
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
                label.backgroundColor = UIColor.lightGray
                label.textColor = UIColor.white
                label.font = UIFont.systemFont(ofSize: 13)
                label.textAlignment = NSTextAlignment.center
                label.text = "\(self.realTotal)"
            }
        }

        view.layer.cornerRadius = view.frame.size.width / 2
        view.layer.borderWidth = collectionView.numberOfItems(inSection: 0) == 2 || collectionView.numberOfItems(inSection: 0) == 3 ? 1 : 0
        view.layer.borderColor = UIColor.white.cgColor
        view.clipsToBounds = true
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, realTotal)
    }
    
    //MARK: Helper
    fileprivate func getDataList() -> Array<Any> {
        return avatarImages.count > 0 ? avatarImages : avatarUrls
    }
    
}

private class MDAvatarCollectionViewLayout : UICollectionViewLayout {
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        cache.removeAll()
        if collectionView!.numberOfItems(inSection: 0) > 0 {
            for index in 0...(collectionView!.numberOfItems(inSection: 0) - 1) {
                let indexPath = IndexPath(item: index, section: 0)
                let attribute = calculateCellLayoutAttribute(indexPath)
                cache.append(attribute)
            }
        }
        
    }
    
    fileprivate func calculateCellLayoutAttribute(_ indexPath : IndexPath) -> UICollectionViewLayoutAttributes{
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        if collectionView != nil  {
            var frame = collectionView!.frame
            switch collectionView!.numberOfItems(inSection: indexPath.section) {
            case 1:
                frame = CGRect(x: 0, y: 0, width: collectionView!.frame.width, height: collectionView!.frame.height)
                break
            case 2:
                frame.size = CGSize(width: collectionView!.frame.width * 0.65, height: collectionView!.frame.height * 0.65)
                frame.origin = indexPath.row == 0 ? CGPoint.zero : CGPoint(x: collectionView!.frame.width * 0.35, y: collectionView!.frame.height * 0.35)
                break
            case 3:
                let cellRatio : CGFloat = 0.55
                frame.size = CGSize(width: collectionView!.frame.width * cellRatio, height: collectionView!.frame.height * cellRatio)
                if indexPath.row == 0 {
                    frame.origin = CGPoint(x: collectionView!.frame.width * (1 - cellRatio) * 0.5, y: 0)
                } else if indexPath.row == 1 {
                    frame.origin = CGPoint(x: 0, y: collectionView!.frame.height * (1 - cellRatio))
                } else {
                    frame.origin = CGPoint(x: collectionView!.frame.width * (1 - cellRatio), y: collectionView!.frame.height * (1 - cellRatio))
                }
                break
            case 4:
                let cellRatio : CGFloat = 0.5
                frame.size = CGSize(width: collectionView!.frame.width * cellRatio, height: collectionView!.frame.height * cellRatio)
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

    override var collectionViewContentSize : CGSize {
        if collectionView == nil {
            return CGSize.zero
        }
        return collectionView!.frame.size
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
