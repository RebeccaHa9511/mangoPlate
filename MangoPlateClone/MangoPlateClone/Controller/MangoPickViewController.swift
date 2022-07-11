//
//  MangoPickViewController.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/05.
//

import UIKit
import Tabman
import Pageboy

class MangoPickViewController: TabmanViewController {

    var viewControllers = [EatDealVC(), StoryVC(), TopListVC()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}

extension MangoPickViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
//        let item = TMBarItem(title: "")
//        item.title = "Page \(index)"
//        item.image = UIImage(named: "image.png")
//
//        return item
        
        // MARK: - Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: "EAT딜")
        case 1:
            return TMBarItem(title: "스토리")
        case 2:
            return TMBarItem(title: "Top리스트")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }

    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    
}
