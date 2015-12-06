//
//  SGFonts.swift
//  ToingiOS
//
//  Created by 刘山国 on 15/12/3.
//  Copyright © 2015年 云葵科技. All rights reserved.
//

import Foundation
import UIKit

class SGFonts : NSObject{
  
    
    override init(){
        super.init()
    }
    
    //第一个是系统默认字体，其余是自加字体
    let fontsDic : NSDictionary = NSDictionary(dictionaryLiteral:
        ((0),".HelveticaNeueInterface-Regular"),
        ((1),"DFShaoNvW5-GB.ttc"),
        ((2),"迷你简卡通.TTF"),
        ((3),"-V1.ttf"),
        ((4),"FZHei-B01S.TTF"),
        ((5),"Li Xuke.ttf"),
        ((6),"迷你简硬笔行书.TTF"),
        ((7),"momo_xinjian.ttf"),
        ((8),"FZJianZhi-M23S.ttf"),
        ((9),"HYHeiLiZhiTiJ.ttf")
    )
    
    
    //MARK: - public
    
    func count() -> Int {
        return self.fontsDic.count
    }
    
    func fontWithName(name: String , size:CGFloat) -> UIFont {
        let fontTag = self.fontTag(name);
        let fontName = self.fontName(atIndex: fontTag as Int)
        return UIFont(name: fontName, size: size)!
    }
    
    func fontWithTag(fontTag: NSNumber , size:CGFloat) -> UIFont {
        let fontName = self.fontName(atIndex: fontTag as Int)
        return UIFont(name: fontName, size: size)!
    }
    
    func font(atIndex: Int , size:CGFloat) -> UIFont{
        let fontName = self.fontName(atIndex: atIndex)
        return UIFont(name: fontName, size: size)!
    }
    
    func fontName(atIndex index: Int) -> String {
        let fontName = self.fontsDic.objectForKey((index)) as! String
        if index == 0 {return fontName}//第一个是系统字体
        let range = fontName.rangeOfString(".")
        let fontNamePrefix = fontName.substringToIndex((range?.startIndex)!)
        if(self.fontRegisted(fontNamePrefix) == false){
            let fontExtention = fontName.substringFromIndex((range?.endIndex.advancedBy(-1))!)
            self.registFont(fontName: fontNamePrefix, fontExtension: fontExtention)
        }
        
        return fontNamePrefix
        
    }
    
    func fontTag(fontName : String) -> NSNumber {
        for obj in fontsDic {
            if (obj.value as! String).containsString(fontName) {
                return obj.key as! NSNumber
            }
        }
        return (0)
    }
    
    
    //MARK: - Private Font Regisiter
    
    private func registFont(fontName fontName: String, fontExtension: String) -> Bool {
        let bundle = NSBundle.mainBundle()
        let url = bundle.URLForResource(fontName, withExtension: fontExtension)
        let fontData = NSData(contentsOfURL: url!)
        let providerRef = CGDataProviderCreateWithCFData(fontData)
        let  font = CGFontCreateWithDataProvider(providerRef)
        if(CTFontManagerRegisterGraphicsFont(font!, nil) == false){
            print("注册字体失败：" + fontName)
            return false
        }
        return true
    }
    
    private func fontRegisted(fontName : String) -> Bool {
        let aFont = UIFont(name: fontName, size: 15.0)
        let isReg = (aFont != nil) && (aFont?.fontName .compare(fontName) == .OrderedSame || aFont?.familyName.compare(fontName) == .OrderedSame)
        return isReg
    }
}
