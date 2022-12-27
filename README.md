# MDGroupAvatarView
This library provides a custom UIView with support for showing group of avatars. It’s used for group chat. The images list can be loaded from local or web url.


[![CI Status](http://img.shields.io/travis/dungttm/MDGroupAvatarView.svg?style=flat)](https://travis-ci.org/dungttm/MDGroupAvatarView)
[![Version](https://img.shields.io/cocoapods/v/MDGroupAvatarView.svg?style=flat)](http://cocoapods.org/pods/MDGroupAvatarView)
[![License](https://img.shields.io/cocoapods/l/MDGroupAvatarView.svg?style=flat)](http://cocoapods.org/pods/MDGroupAvatarView)
[![Platform](https://img.shields.io/cocoapods/p/MDGroupAvatarView.svg?style=flat)](http://cocoapods.org/pods/MDGroupAvatarView)
<div style="float: left; text-align: center">
<img src="https://farm9.staticflickr.com/8694/28141739940_c0f3378c29_o.jpg" width="80%"></img>
&nbsp;
<img src="https://farm9.staticflickr.com/8892/27807926164_7dde495c14_o.png" width="30%"></img>

</div>
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Drag UIView to storyboard or xib file. Then assign class of this view is MDGroupAvatarView.

NOTE: ```localGroupAvatarView ``` and ```urlGroupAvatarView``` in this example are two properties connected to Storyboard.


**Local Images**
```swift
        var images = Array<UIImage>()
        images.append(UIImage(named: "img_avatar_01") ?? UIImage())
        images.append(UIImage(named: "img_avatar_02") ?? UIImage())
        images.append(UIImage(named: "img_avatar_03") ?? UIImage())
        localGroupAvatarView.setAvatarImages(images, realTotal: NUM_OF_MEMBER)
```
**Images loaded from url**
```swift
        var urls = Array<NSURL>()
        urls.append(NSURL(string: "https://img_url01.jpg")!)
        urls.append(NSURL(string: "https://img_url02.jpg")!)
        urls.append(NSURL(string: "https://img_url03.jpg")!)
        urls.append(NSURL(string: "https://img_url04.jpg")!)
        urlGroupAvatarView.setAvatarUrl(urls, realTotal: NUM_OF_MEMBER)
```

## Requirements

## Installation

MDGroupAvatarView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod "MDGroupAvatarView"
```

## Author

dungttm, ttmdung203@gmail.com

## License

MDGroupAvatarView is available under the MIT license. See the LICENSE file for more info.
