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
    private var battleSheet: [String] = []
    
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
    
    private func startBattle() -> String {
        battleSheet = []
        for index in 0..<battles {
            // Win by courage
            if abs((teamAutobots[index].courage ?? 0) - (teamDecepticons[index].courage ?? 0)) >= 4 {
                if teamAutobots[index].courage ?? 0 > teamDecepticons[index].courage ?? 0 {
                    battleSheet.append("A")
                } else {
                    battleSheet.append("D")
                }
                // Win by strength
            } else if abs((teamAutobots[index].strength ?? 0) - (teamDecepticons[index].strength ?? 0)) >= 3 {
                if teamAutobots[index].strength ?? 0 > teamDecepticons[index].strength ?? 0 {
                    battleSheet.append("A")
                } else {
                    battleSheet.append("D")
                }
                // Win by skill
            } else if abs((teamAutobots[index].skill ?? 0) - (teamDecepticons[index].skill ?? 0)) >= 3 {
                if teamAutobots[index].skill ?? 0 > teamDecepticons[index].skill ?? 0 {
                    battleSheet.append("A")
                } else {
                    battleSheet.append("D")
                }
                // Special win cases
            } else if teamAutobots[index].name == "Optimus Prime" || teamDecepticons[index].name == "Predaking" {
                if teamAutobots[index].name == "Optimus Prime" && teamDecepticons[index].name == "Predaking"{
                    battleSheet.append("T")
                } else if teamAutobots[index].name == "Optimus Prime" {
                    battleSheet.append("A")
                } else {
                    battleSheet.append("D")
                }
                // Win by Overall Rating
            } else {
                let (aStrength, aIntelligence, aSpeed, aEndurance, aFirepower) = (teamAutobots[index].strength ?? 0, teamAutobots[index].intelligence ?? 0, teamAutobots[index].speed ?? 0, teamAutobots[index].endurance ?? 0, teamAutobots[index].firepower ?? 0)
                let autobotOverallRating = aStrength + aIntelligence + aSpeed + aEndurance + aFirepower
                let (dStrength, dIntelligence, dSpeed, dEndurance, dFirepower) = (teamDecepticons[index].strength ?? 0, teamDecepticons[index].intelligence ?? 0, teamDecepticons[index].speed ?? 0, teamDecepticons[index].endurance ?? 0, teamDecepticons[index].firepower ?? 0)
                let decepticonOverallRating = dStrength + dIntelligence + dSpeed + dEndurance + dFirepower
                if autobotOverallRating > decepticonOverallRating {
                    battleSheet.append("A")
                } else if autobotOverallRating < decepticonOverallRating{
                    battleSheet.append("D")
                } else if autobotOverallRating == decepticonOverallRating{
                    battleSheet.append("T")
                }
            }
        }
        print(battleSheet)
        let (battlesString, resultString) = calculateResults()
        print("\(battlesString)\n\(resultString)")
        return ("\(battlesString)\n\(resultString)")
    }
    
    private func calculateResults() -> (String, String) {
        var battlesString = ""
        switch battles{
        case 0:
            battlesString = "No battles"
        case 1:
            battlesString = "1 battle"
        default:
            battlesString = "\(battles) battles"
        }
        
        var winningTeam = ""
        var losingTeam = ""
        var winningSurvivorsString = ""
        var losingSurvivorsString = ""
        var resultString = ""
        
        let aliveAutobots = battleSheet.filter({ return $0 == "A" })
        let aliveDecepticons = battleSheet.filter({ return $0 == "D" })
        if aliveAutobots.count == aliveDecepticons.count {
            winningTeam = "Tie"
            resultString = winningTeam
        } else {
            if aliveAutobots.count > aliveDecepticons.count {
                winningTeam = "Autobots"
                losingTeam = "Decepticons"
                let indexesOfWinningSurvivors = battleSheet.indexes(of: "A")
                for index in indexesOfWinningSurvivors{
                    winningSurvivorsString += "\(teamAutobots[index].name ?? ""), "
                }
                winningSurvivorsString = String(winningSurvivorsString.dropLast(2))
                let indexesOfLosingSurvivors = battleSheet.indexes(of: "D")
                for index in indexesOfLosingSurvivors{
                    losingSurvivorsString += "\(teamDecepticons[index].name ?? ""), "
                }
                losingSurvivorsString = String(losingSurvivorsString.dropLast(2))
            } else {
                winningTeam = "Decepticons"
                losingTeam = "Autobots"
                let indexesOfWinningSurvivors = battleSheet.indexes(of: "D")
                for index in indexesOfWinningSurvivors{
                    winningSurvivorsString += "\(teamDecepticons[index].name ?? ""), "
                }
                winningSurvivorsString = String(winningSurvivorsString.dropLast(2))
                let indexesOfLosingSurvivors = battleSheet.indexes(of: "A")
                for index in indexesOfLosingSurvivors{
                    losingSurvivorsString += "\(teamAutobots[index].name ?? ""), "
                }
                losingSurvivorsString = String(losingSurvivorsString.dropLast(2))
            }
            resultString = "Winning team (\(winningTeam)): \(winningSurvivorsString)\nSurvivors from the losing team (\(losingTeam)): \(losingSurvivorsString)"
        }
        return (battlesString, resultString)
    }
    
    func battle(transformers: [Transformer]) -> String {
        if checkEligibility(transformers: transformers) {
            sortTeams()
            scheduleBattles()
            return startBattle()
        }
        return ""
    }
}
