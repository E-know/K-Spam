//
//  PublicFilterEntity.swift
//  K-Spam
//
//  Created by Inho Choi on 6/6/25.
//


struct PublicFilterEntity: Decodable {
    let word: PublicFilterWordEntity
    let number: PublicFilterNumberEntity
    let version: String
    
    func toDomain() -> PublicFilterData {
        return PublicFilterData(
            version: version,
            word: PublicFilterWord(
                whiteList: word.whiteList,
                blackList: word.blackList
            ),
            number: PublicFilterNumber(
                whiteList: number.whiteList,
                blackList: number.blackList
            )
        )
    }
}

struct PublicFilterWordEntity: Decodable {
    let whiteList: [String]
    let blackList: [String]
}

struct PublicFilterNumberEntity: Decodable {
    let whiteList: [String]
    let blackList: [String]
}
