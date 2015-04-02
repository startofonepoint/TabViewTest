//
//  CustomTabBarController.swift
//  TabViewTest
//
//  Created by lostin1 on 2015. 3. 23..
//  Copyright (c) 2015년 lostin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func imageWithColor(color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        let rect:CGRect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextClipToMask(context, rect, self.CGImage)
        color.setFill()
        CGContextFillRect(context, rect)
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

class CustomTabBarController:UITabBarController {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var selectedColor:UIColor!
    var unSelectedColor:UIColor!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        selectedColor = UIColor.blackColor()
        let selectedTextAttr = [NSForegroundColorAttributeName:selectedColor]        
        UITabBar.appearance().tintColor = selectedColor
        //tabBar의 백그라운드 컬러 설정
        self.tabBar.barTintColor = UIColor.blueColor()
        unSelectedColor = UIColor.whiteColor()
        let textAttribute = [NSForegroundColorAttributeName:unSelectedColor]
        //tabBar버튼 텍스트의 unSelectedColor설정
        UITabBarItem.appearance().setTitleTextAttributes(textAttribute, forState: UIControlState.Normal)
        //tabBar버튼 텍스트의 SelectedColor설정
        UITabBarItem.appearance().setTitleTextAttributes(selectedTextAttr, forState: UIControlState.Selected)
        let items =  self.tabBar.items? as [UITabBarItem]
        //tabBar버튼 아이콘의 unSelectedColor설정
        for item:UITabBarItem in items {
            item.image = item.selectedImage.imageWithColor(unSelectedColor).imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
