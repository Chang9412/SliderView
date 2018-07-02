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
    
    let titles = ["推荐", "娱乐", "生活", "游戏", "汽车", "纪录片", "拍客", "路由", "科技", "财经", "原创"]
    var viewArray = [UITableView]()
    
    
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
        
        mainView = UIScrollView.init(frame: CGRect(x: 0, y: 64, width: UIView.screenWidth(), height: UIView.screenHeight()-64))
        self.view.addSubview(mainView)
        
        let itemWidth = mainView.width
        let itemHeight = mainView.height
        
        
        for (index, _) in titles.enumerated() {
            let tab = UITableView(frame: CGRect(x: CGFloat(index)*itemWidth, y: 0, width: itemWidth, height: itemHeight), style: .plain)
            mainView.addSubview(tab)
            tab.separatorStyle = .none
            tab.addSubview(TempleteView(frame: tab.bounds))
        }
        mainView.contentSize = CGSize(width: CGFloat(titles.count)*itemWidth, height: itemHeight)
    }
}
class TempleteView: UIView {
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
