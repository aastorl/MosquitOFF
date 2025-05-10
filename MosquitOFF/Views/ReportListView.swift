//
//  ReportListView.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 06/05/2025.
//

import SwiftUI

struct ReportListView: View {
    private let reportManager = ReportManager()  // Servicio para obtener los reportes
    
    var body: some View {
        List(reportManager.loadReports()) { report in
            VStack(alignment: .leading) {
                Text(report.type)
                    .font(.headline)
                Text(report.description)
                    .font(.subheadline)
                Text("Fecha: \(formatDate(report.timestamp))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Reportes Enviados")
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
