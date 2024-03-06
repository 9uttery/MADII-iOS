//
//  Album.swift
//  Madii
//
//  Created by 이안진 on 12/5/23.
//

import Foundation

struct Album: Identifiable, Hashable {
    let id: Int
    var backgroundColorNum: Int = 1
    var iconNum: Int = 1
    var title: String
    var creator: String = ""
    var description: String = ""
    
    static let dummy1: Album = .init(id: 0, title: "기분 좋을 때 할 일", creator: "구떠리",
                                     description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요.")
    
    static let dummy2: [Album] = [Album(id: 2, title: "비 올 때 하기 좋은 소확행", creator: "에몽"),
                                  Album(id: 3, title: "샤브샤브 먹고 싶어", creator: "하노")]
    
    static let dummy3: [Album] = [Album(id: 1, title: "무더웠던 여름이 지나가고 다가오는 가을..?", creator: "구떠리"),
                                  Album(id: 2, title: "비 올 때 하기 좋은 소확행", creator: "에몽"),
                                  Album(id: 3, title: "샤브샤브 먹고 싶어", creator: "하노")]
    
    static let dummy4: [Album] = [Album(id: 1, title: "무더웠던 여름이 지나가고 다가오는 가을..?", creator: "구떠리", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 2, title: "비 올 때 하기 좋은 소확행", creator: "에몽", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 3, title: "겨울 필수 소확행 모음 ZIP", creator: "도요", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 4, title: "샤브샤브 먹고 싶어", creator: "하노", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행")]
                                        
    static let dummy5: [Album] = [Album(id: 1, title: "무더웠던 여름이 지나가고 다가오는 가을..?", creator: "구떠리", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 2, title: "비 올 때 하기 좋은 소확행", creator: "에몽", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 3, title: "겨울 필수 소확행 모음 ZIP", creator: "도요", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 4, title: "샤브샤브 먹고 싶어", creator: "하노", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 5, title: "무더웠던 여름이 지나가고 다가오는 가을..?", creator: "구떠리", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요.")]
    
    static let dummy10: [Album] = [Album(id: 1, title: "무더웠던 여름이 지나가고 다가오는 가을..?", creator: "구떠리", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 2, title: "비 올 때 하기 좋은 소확행", creator: "에몽", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 3, title: "겨울 필수 소확행 모음 ZIP", creator: "도요", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 4, title: "샤브샤브 먹고 싶어", creator: "하노", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 5, title: "무더웠던 여름이 지나가고 다가오는 가을..?", creator: "구떠리", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 6, title: "비 올 때 하기 좋은 소확행", creator: "에몽", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 7, title: "겨울 필수 소확행 모음 ZIP", creator: "도요", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 8, title: "샤브샤브 먹고 싶어", creator: "하노", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 9, title: "무더웠던 여름이 지나가고 다가오는 가을..?", creator: "구떠리", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요."),
                                  Album(id: 10, title: "비 올 때 하기 좋은 소확행", creator: "에몽", description: "이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요.")]
}
