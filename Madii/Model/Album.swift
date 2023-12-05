//
//  Album.swift
//  Madii
//
//  Created by 이안진 on 12/5/23.
//

import Foundation

struct Album: Identifiable {
    let id: Int
    let title: String
    let creator: String
    
    static let dummy2: [Album] = [Album(id: 2, title: "비 올 때 하기 좋은 소확행", creator: "에몽"),
                                  Album(id: 3, title: "샤브샤브 먹고 싶어", creator: "하노")]
    
    static let dummy3: [Album] = [Album(id: 1, title: "무더웠던 여름이 지나가고 다가오는 가을..?", creator: "구떠리"),
                                  Album(id: 2, title: "비 올 때 하기 좋은 소확행", creator: "에몽"),
                                  Album(id: 3, title: "샤브샤브 먹고 싶어", creator: "하노")]
    
    static let dummy4: [Album] = [Album(id: 1, title: "무더웠던 여름이 지나가고 다가오는 가을..?", creator: "구떠리"),
                                  Album(id: 2, title: "비 올 때 하기 좋은 소확행", creator: "에몽"),
                                  Album(id: 3, title: "겨울 필수 소확행 모음 ZIP", creator: "도요"),
                                  Album(id: 4, title: "샤브샤브 먹고 싶어", creator: "하노")]
}
