//
//  EnumImage.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

enum Constants {
    enum Image {
        static let search = UIImage(systemName: "magnifyingglass")
        static let delete = UIImage(systemName: "xmark")
        static let heart = UIImage(systemName: "heart")
        static let heartFill = UIImage(systemName: "heart.fill")
        static let empty = UIImage(named: "empty")
        static let camera = UIImage(named: "camera")
        static let onboardingLogoImage = UIImage(named: "sesacShopping")
        static let onboardingImage = UIImage(named: "onboarding")
    }
    enum Mock {
        enum Setting {
            static let title: [String] = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "처음부터 시작하기"]
        }
        
        enum ProfileImages {
            static let profileImageList = ["profile1", "profile2", "profile3", "profile4", "profile5", "profile6", "profile7", "profile8", "profile9", "profile10", "profile11","profile12","profile13","profile14"]
        }
    }
    
    enum Button {
        enum FilterButton: String, CaseIterable {
            case accuracy = "정확도"
            case date = "날짜순"
            case highPrice = "가격높은순"
            case lowPrice = "가격낮은순"
        }
    }
    
    enum Sort: String, CaseIterable{
        case accuracy = "sim"
        case date = "date"
        case highPrice = "dsc" // 가격 높은 순
        case lowPrice = "asc" // 저렴한 순
    }

}
