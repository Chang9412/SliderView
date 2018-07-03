//
//  ViewController.swift
//  SliderView
//
//  Created by zzq on 2018/7/2.
//  Copyright © 2018年 zzq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mainView: UICollectionView!
    var sliderView: ZQSliderView!
    let titles = ["推荐", "娱乐", "生活", "游戏", "汽车", "纪录片", "拍客", "路由", "科技", "财经", "原创"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.creatSubview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:
    func creatSubview() {
       
        
        sliderView = ZQSliderView(frame: CGRect(x: 0, y: 20, width: UIView.screenWidth(), height: 44), titles: titles)
        self.view.addSubview(sliderView)
        
        
        let itemWidth = UIView.screenWidth()
        let itemHeight = UIView.screenHeight()-sliderView.bottom

        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        mainView = UICollectionView(frame: CGRect(x: 0, y: sliderView.bottom, width: itemWidth, height: itemHeight), collectionViewLayout: layout)
        self.view.addSubview(mainView)
        mainView.isPagingEnabled = true
        mainView.showsHorizontalScrollIndicator = false
        mainView.backgroundColor = UIColor.white
        mainView.dataSource = self
        mainView.delegate = self
        mainView.bounces = false
        mainView.register(ZQCell.classForCoder(), forCellWithReuseIdentifier: "zqcell")

    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zqcell", for: indexPath) as? ZQCell
        cell?.tv.text = titles[indexPath.item]
        return cell!
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var dir = 1
        let x = scrollView.contentOffset.x
        
        if x<CGFloat(self.sliderView.currentIndex.item)*UIView.screenWidth() {
            dir = -1
        }
        
        self.sliderView.moveLine(offsetX: x, stan: UIView.screenWidth()/2, direction: dir)
    }
    
}


class ZQCell: UICollectionViewCell {
    
    var tv: TempleteView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tv = TempleteView(frame: self.bounds)
        self.contentView.addSubview(tv)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class TempleteView: UIView {
    var text: String? {
        didSet {
            if let a = self.viewWithTag(10) {
                a.removeFromSuperview()
                
            }
            
            let la = UILabel.creatLabel(frame: CGRect(x: 10, y: 10, width: self.width-20, height: 30), title: text, titleColor: UIColor.red, font: UIFont.systemFont(ofSize: 15), textAlignment: .center)
            la.tag = 10
            self.addSubview(la)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let layer1 = CALayer.init()
        self.layer.addSublayer(layer1)
        layer1.backgroundColor = UIColor.rgba(red: 230, green: 230, blue: 230, alpha: 1).cgColor
        layer1.frame = CGRect(x: 10, y: 50, width: self.width-20, height: 60)
        
        
        let layer2 = CALayer.init()
        self.layer.addSublayer(layer2)
        layer2.backgroundColor = UIColor.rgba(red: 230, green: 230, blue: 230, alpha: 1).cgColor
        layer2.frame = CGRect(x: 10, y: 130, width: self.width-20, height: 20)
        
        let layer3 = CALayer.init()
        self.layer.addSublayer(layer3)
        layer3.backgroundColor = UIColor.rgba(red: 230, green: 230, blue: 230, alpha: 1).cgColor
        layer3.frame = CGRect(x: 10, y: 170, width: self.width-20, height: 20)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
