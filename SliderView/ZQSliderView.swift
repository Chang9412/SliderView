//
//  ZQSliderView.swift
//  SliderView
//
//  Created by zzq on 2018/7/2.
//  Copyright © 2018年 zzq. All rights reserved.
//

import UIKit

typealias kCompletion = () -> Void

//enum AnimationKey {
//    case gorup
//}

class ZQSliderView: UIView {

    var titleView: UICollectionView!
    var line: UIView!
    var titles: [String]!
    var lineColor =  UIColor.red
    
    var currentIndex = IndexPath.init(item: 0, section: 0)
    var preIndex: IndexPath?
    var position: CGPoint?
    
    
    let duration = 0.3
    let itemWidth: CGFloat = 65
    let key = "animationKey"
    
    
    var animationArray = [kCompletion]()
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        self.titles = titles
        self.creatSubview()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:
    func creatSubview() {
        
        let itemHeight: CGFloat = self.height-1
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        titleView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.width, height: itemHeight), collectionViewLayout: layout)
        self.addSubview(titleView)
        
        titleView.showsHorizontalScrollIndicator = false
        titleView.backgroundColor = UIColor.white
        titleView.dataSource = self
        titleView.delegate = self
        
        for i in 0..<titles.count {
            titleView.register(SliderCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        }
        
        
        line = UIView(frame: CGRect(x: 0, y: titleView.bottom-1, width: 20, height: 1))
        titleView.addSubview(line)
        line.backgroundColor = lineColor
        position = line.center
    }
    
    func moveLine(toIndex: IndexPath, completion: @escaping kCompletion) {
        
        line.layer.removeAllAnimations()
        let cell1 = titleView.cellForItem(at: currentIndex) as? SliderCell
        let cell2 = titleView.cellForItem(at: toIndex) as? SliderCell
        
        
        let animation1 = CAKeyframeAnimation(keyPath: "bounds")
        animation1.keyTimes = [0, 0.5, 1]
        animation1.values = [CGRect(x: 0, y: 0, width: 20, height: 1), CGRect(x: 0, y: 0, width: itemWidth, height: 1), CGRect(x: 0, y: 0, width: 20, height: 1)]
        animation1.timingFunctions = [CAMediaTimingFunction.init(name: "easeOut"),CAMediaTimingFunction.init(name: "easeIn")]
        animation1.repeatCount = 1
        animation1.duration = duration
        
        let animation2 = CABasicAnimation.init(keyPath: "position")
        animation2.fromValue = position!//CGPoint(x: cell1!.centerX, y: line.centerY)
        animation2.toValue = CGPoint(x: cell2!.centerX, y: line.centerY)
        animation2.duration = duration
        animation2.repeatCount = 1
        
        let group = CAAnimationGroup.init()
        group.animations = [animation1, animation2]
        group.duration = duration
        group.repeatCount = 1
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        group.delegate = self
        objc_setAssociatedObject(group, UnsafeRawPointer.init(bitPattern: key.hashValue)!, completion, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        debugPrint("\(group)")
        line.layer.add(group, forKey: "gg")
        
        animationArray.append(completion)
        
        
        cell2?.textLabel.textColor = UIColor.red
        cell1?.textLabel.textColor = UIColor.rgba(red: 51, green: 51, blue: 51, alpha: 1)
        self.preIndex = self.currentIndex
        self.currentIndex = toIndex
        position = CGPoint(x: cell2!.centerX, y: line.centerY);
        
        titleView.reloadItems(at: [self.preIndex!, self.currentIndex])

//        titleView.scrollToItem(at: toIndex, at: .centeredHorizontally, animated: true)
    }
    func moveLine(offsetX: CGFloat, stan: CGFloat, direction: Int)  {//left:-1, right:1
        let cell1 = titleView.cellForItem(at: currentIndex) as? SliderCell
        let cell2 = titleView.cellForItem(at: IndexPath(item: currentIndex.item+direction, section: 0)) as? SliderCell
        if offsetX<stan {
            line.width = 20+offsetX/stan*45
            line.left = cell1!.centerX+offsetX/stan*5
        }else {
            line.width = 65-(offsetX-stan)/stan*45
            line.centerX = cell2!.centerX+offsetX/stan*5
        }
    }
}
extension ZQSliderView : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
         debugPrint("\(anim)")
//        if let com = objc_getAssociatedObject(anim, UnsafeRawPointer.init(bitPattern: key.hashValue)!)as?kCompletion  {
//            com()
//        }
        print("\(Thread.current)")
        if animationArray.count>0 {
            animationArray[0]()
        }
        
    }
    func animationDidStart(_ anim: CAAnimation) {
       
    }
}
extension ZQSliderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SliderCell
        
        cell?.textLabel.text = titles[indexPath.item]
        
        if currentIndex.item == indexPath.item {
            cell?.textLabel.textColor = UIColor.red
            line.centerX = cell!.centerX
        }else {
            cell?.textLabel.textColor = UIColor.rgba(red: 51, green: 51, blue: 51, alpha: 1)
        }
        
        return cell!
    }
}

extension ZQSliderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.item != self.currentIndex.item else {
            print("same")
            return
        }
       
        self.moveLine(toIndex: indexPath) {
            print("completion")
           collectionView.scrollToItem(at: self.currentIndex, at: .centeredHorizontally, animated: true)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

class SliderCell: UICollectionViewCell {
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel = UILabel(frame: self.bounds)
        self.addSubview(textLabel)
        
        textLabel.textColor = UIColor.rgba(red: 51, green: 51, blue: 51, alpha: 1)
        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.textAlignment = .center
        textLabel.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
