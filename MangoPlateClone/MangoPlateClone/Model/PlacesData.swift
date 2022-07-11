//
//  PlacesData.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/06.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let getFoodKr: GetFoodKr
}

// MARK: - GetFoodKr
struct GetFoodKr: Codable {
    let header: Header
    let item: [Item]
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Header
struct Header: Codable {
    let code, message: String
}

// MARK: - Item
struct Item: Codable {
    let ucSeq: Int?
    let mainTitle, gugunNm: String?
    let lat, lng: Double?
    let place, title, subtitle, addr1: String?
    let addr2, cntctTel: String?
    let homepageURL: String?
    let usageDayWeekAndTime, rprsntvMenu: String?
    let mainImgNormal, mainImgThumb: String?
    let itemcntnts: String?

    enum CodingKeys: String, CodingKey {
        case ucSeq = "UC_SEQ"
        case mainTitle = "MAIN_TITLE"
        case gugunNm = "GUGUN_NM"
        case lat = "LAT"
        case lng = "LNG"
        case place = "PLACE"
        case title = "TITLE"
        case subtitle = "SUBTITLE"
        case addr1 = "ADDR1"
        case addr2 = "ADDR2"
        case cntctTel = "CNTCT_TEL"
        case homepageURL = "HOMEPAGE_URL"
        case usageDayWeekAndTime = "USAGE_DAY_WEEK_AND_TIME"
        case rprsntvMenu = "RPRSNTV_MENU"
        case mainImgNormal = "MAIN_IMG_NORMAL"
        case mainImgThumb = "MAIN_IMG_THUMB"
        case itemcntnts = "ITEMCNTNTS"
    }
}




