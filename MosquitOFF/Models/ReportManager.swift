//
//  ReportManager.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 06/05/2025.
//

import Foundation

class ReportManager {
    private let reportsKey = "storedReports"

    func saveReports(_ reports: [Report]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(reports) {
            UserDefaults.standard.set(encoded, forKey: reportsKey)
        }
    }

    func loadReports() -> [Report] {
        if let savedReports = UserDefaults.standard.data(forKey: reportsKey) {
            let decoder = JSONDecoder()
            if let loadedReports = try? decoder.decode([Report].self, from: savedReports) {
                return loadedReports
            }
        }
        return []
    }

    func deleteReport(id: UUID) {
        var reports = loadReports()
        reports.removeAll { $0.id == id }
        saveReports(reports)
    }
}

