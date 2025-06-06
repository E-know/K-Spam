//
//  PublicFilter.swift
//  K-Spam
//
//  Created by Inho Choi on 6/6/25.
//


struct PublicFilterData {
    let version: String
    let word: PublicFilterWord
    let number: PublicFilterNumber
}

struct PublicFilterWord {
    let whiteList: [String]
    let blackList: [String]
}

struct PublicFilterNumber {
    let whiteList: [String]
    let blackList: [String]
}
