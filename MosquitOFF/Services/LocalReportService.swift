//
//  LocalReportService.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 06/05/2025.
//

import Foundation

class LocalReportService {
    
    private let reportsKey = "reports"  // Clave para acceder a los reportes en UserDefaults
    
    // Función para guardar un nuevo reporte
    func saveReport(_ report: Report) {
        var reports = fetchReports()  // Cargar los reportes existentes
        reports.append(report)  // Añadir el nuevo reporte
        if let encoded = try? JSONEncoder().encode(reports) {
            UserDefaults.standard.set(encoded, forKey: reportsKey)  // Guardar los reportes en UserDefaults
        }
    }
    
    // Función para obtener los reportes guardados
    func fetchReports() -> [Report] {
        guard let data = UserDefaults.standard.data(forKey: reportsKey),
              let reports = try? JSONDecoder().decode([Report].self, from: data) else {
            return []  // Si no hay datos, devolver un arreglo vacío
        }
        return reports
    }
}
