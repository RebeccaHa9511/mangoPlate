//
//  MainVCDelegates.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/11.
//

import UIKit
import Kingfisher


//extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewFlowLayout {
//    
//    func changeHeight() {
//        self.collectionViewheight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
//    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return restInfos.count
//    }
    
    
//    //KingFisher 사용해서 이미지 캐싱 및 다운로드 해보기
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCollectionViewCell", for: indexPath) as! PlacesCollectionViewCell
//        
//        if indexPath.row < restInfos.count {
//            let restInfo = restInfos[indexPath.row]
//            
//            //🚨 옵셔널값 대응 필요.
//            let url = URL(string: restInfo.urlString!)
//            cell.imageView.kf.setImage(with: url)
//            let name = restInfo.detail.place_name
//            cell.restTitle.text = name
//            cell.places.text = restInfo.distance(latitude: Double(y)!, longitude: Double(x)!) + "km"
//        }
//        
//        return cell
//    }
//    
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if self.collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.bounds.size.height {
//            
//            if isAvailable {
//                isAvailable = false
//                self.page = self.page + 1
//                
//                print("현재 페이지 \(page)")
//                kakaoLocalDataManager.fetchRestaurants(x: x, y: y, page: self.page, delegate: self)
//            }
//
//        }
//    }
//}
