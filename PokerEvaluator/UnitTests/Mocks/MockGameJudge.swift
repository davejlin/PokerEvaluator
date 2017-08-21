//
//  MockGameJudge.swift
//  PokerEvaluator
//
//  Created by Lin David, US-20 on 8/21/17.
//  Copyright © 2017 Lin David, US-20. All rights reserved.
//

import Foundation

class MockGameJudge: GameJudgeProtocol {
    var isGetSortedWinnerIdsCalled = false
    var returnArr = [Int]()
    func getSortedWinnerIds(for game: [Hand]) -> [Int] {
        isGetSortedWinnerIdsCalled = true
        return returnArr
    }
}
