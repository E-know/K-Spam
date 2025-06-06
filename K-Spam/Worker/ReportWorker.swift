//
//  ReportWorker.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

struct ReportWorker {
    private let repository: ReportRepositoryProtocol
    
    init(repository: ReportRepositoryProtocol = ReportRepository()) {
        self.repository = repository
    }
    
    func report(reportType: ReportType, message: String) async throws -> TelegramBotResponse? {
        guard message.isEmpty == false else { return nil }
        
        return try await repository.report(reportType: reportType, message: message)
    }
}

