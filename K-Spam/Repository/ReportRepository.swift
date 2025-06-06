//
//  ReportRepositoryProtocol.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//


protocol ReportRepositoryProtocol {
    func report(reportType: ReportType, message: String) async throws -> TelegramBotResponse
}

struct ReportRepository: ReportRepositoryProtocol {
    private let service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func report(reportType: ReportType, message: String) async throws -> TelegramBotResponse {
        let text = """
            [K-Spam Report]
            \(reportType.title)
            [Message]
            \(message)
            [Filter Info]
            AppVersion: \(Storages.appVersion)
            PublicFilter: \(Storages.publicFilterVersion)
            """
        
        let entity: TelegramBotEntity = try await service.request(target: ReportAPI.report(text))
        
        return entity.toDomain()
    }
}
