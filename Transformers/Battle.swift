//
//  Battle.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-11.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import Foundation
import UIKit

class Battle {
    // MARK: - Singleton Implementation
    private init() {}
    static let shared = Battle()
    
    // MARK: - Properies
    private var teamAutobots: [Transformer] = []
    private var teamDecepticons: [Transformer] = []
    private var battles: Int = 0
    
    // MARK: - Methods
    private func checkEligibility(transformers: [Transformer]) -> Bool {
        prepareTeams(transformers: transformers)
        if teamAutobots.count < 1 || teamDecepticons.count < 1 {
            print("Not enough players to play")
            return false
        } else {
            print("Teams have enough players")
            return true
        }
    }
    
    private func prepareTeams(transformers: [Transformer]){
        teamAutobots = transformers.filter({ return $0.team == "A" })
        teamDecepticons = transformers.filter({ return $0.team == "D" })
    }
    
    private func sortTeams(){
        teamAutobots.sort { (transformer1, transformer2) -> Bool in
            return (transformer1.rank ?? 0) > (transformer2.rank ?? 0)
        }
        teamDecepticons.sort { (transformer1, transformer2) -> Bool in
            return (transformer1.rank ?? 0) > (transformer2.rank ?? 0)
        }
        print("Teams Ready!\n\nTeam Autobots:\n\(teamAutobots)\nTeam Decepticons:\(teamDecepticons)")
    }
    
    private func scheduleBattles(){
        if teamAutobots.count == teamDecepticons.count {
            battles = teamAutobots.count
        } else if teamAutobots.count < teamDecepticons.count {
            battles = teamAutobots.count
        } else if teamAutobots.count > teamDecepticons.count {
            battles = teamDecepticons.count
        }
        print("\(battles) battles scheduled!")
    }
    
    private func startBattle(){
        for index in 1...battles {
            if abs((teamAutobots[index].courage ?? 0) - (teamDecepticons[index].courage ?? 0)) >= 4 {
                // ...
            }
        }
    }
    
    func battle(transformers: [Transformer]){
        if checkEligibility(transformers: transformers) {
            sortTeams()
            scheduleBattles()
            startBattle()
        }
    }
}
