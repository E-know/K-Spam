//
//  SettingsView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/27/25.
//

import SwiftUI

struct SettingsView: MVIView {
    enum ChildViewAction {
        case popChildView
        case confirmScheduleTime(Date, Date)
        case confirmTravleDate(Date, Date)
        case report(ReportType, String)
    }
    
    private let intent: SettingsIntentProtocol
    let state: SettingsStateDataProtocol
    
    init() {
        let state = SettingsState()
        self.intent = SettingsIntent(state: state)
        self.state = state
    }
    
    var body: some View {
        NavigationStack(path: bind(\.path, intent.setNavigationPath)) {
            ScrollView {
                VStack(spacing: 26) {
                    AlarmView()
                        .padding(.horizontal, 16)
                    
                    FilterSettingsView()
                        .padding(.horizontal, 16)
                    
                    InformationView()
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: SettingsModels.NavigationPath.self) { value in
                switch value {
                    case .appInfo:
                        AppInfoView()
                    case .privacyPolicy:
                        PrivacyInfoView()
                    case .configureTime:
                        ConfigureTimeView(
                            startTime: state.filterStartTime,
                            endTime: state.filterEndTime
                        ) { action in
                            switch action {
                                case .popChildView:
                                    intent.popNavigation()
                                case let .confirmScheduleTime(startTime, endTime):
                                    intent.setConfigureTIme(request: .init(
                                        startTime: startTime,
                                        endTime: endTime
                                    ))
                                    intent.popNavigation()
                                default:
                                    break
                            }
                        }
                    case .configureTravel:
                        ConfigureDateView() { action in
                            switch action {
                                case .popChildView:
                                    intent.popNavigation()
                                case let .confirmTravleDate(startDate, endDate):
                                    intent.setConfigureDate(request: .init(startDate: startDate, endDate: endDate))
                                    intent.popNavigation()
                                default:
                                    break
                            }
                        }
                    case .report:
                        ReportView() { action in
                            if case let .report(reportType, message) = action {
                                intent.requestReportConfirm(request: .init(reportType: reportType, message: message))
                            }
                        }
                }
            }
        }
        .alert("설정으로 이동", isPresented: bind(\.alertRoutetoSettings, intent.setAlertRouteToSettings)) {
            Button("취소", role: .cancel) {}
            Button("이동") {
                intent.tapRouteToSettings()
            }
        } message: {
            Text("권한 설정을 위해 설정 앱으로 이동하시겠습니까?")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
            intent.getAlarmStatus()
        })
        .onChange(of: Storages.publicFilterVersion, initial: true) {
            intent.updatePublicFilterVersion(Storages.publicFilterVersion)
        }
        .onDisappear {
            intent.setNavigationPath([])
        }
        .onAppear {
            intent.getAlarmStatus()
        }
    }
    
    private func AlarmView() -> some View {
        VStack(alignment: .leading, spacing: 26) {
            Text("알림")
                .font(22, .bold)
                .padding(.vertical, 8)
            
            Toggle(isOn: bind(\.alarmSetting, intent.setAlarmSetting)) {
                VStack(alignment: .leading) {
                    Text("알림 설정")
                        .font(16)
                    
                    Text("K-Spam의 업데이트가 있을 때 알림을 받습니다.")
                        .font(12)
                        .foregroundStyle(Color.gray)
                }
            }
        }
    }
    
    private func InformationView() -> some View {
        VStack(alignment: .leading, spacing: 26) {
            Text("정보")
                .font(22, .bold)
                .padding(.vertical, 8)
            
            HStack {
                Text("앱 정보")
                    .font(16)
                
                Spacer()
                
                Button(action: { intent.tapAppInfo() }) {
                    Image(.rightArrow)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                }
            }
            
            HStack {
                Text("개인정보처리방침")
                    .font(16)
                
                Spacer()
                
                Button(action: { intent.tapPrivacyPolicy() }) {
                    Image(.rightArrow)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                }
            }
            
            HStack {
                Text("기능 요청 및 스팸 메세지 신고")
                    .font(16)
                
                Spacer()
                
                Button(action: { intent.routeToNavigate(.report)}) {
                    Image(.rightArrow)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                }
            }
            
            HStack {
                Text("소프트웨어 버전")
                    .font(16)
                
                Spacer()
                
                Text(state.appVersion)
                    .font(16)
            }
            
            HStack {
                Text("기본 필터 버전")
                    .font(16)
                
                Spacer()
                
                Text(state.publicFilterVersion)
                    .font(16)
            }
        }
    }
    
    private func FilterSettingsView() -> some View {
        VStack(alignment: .leading, spacing: 26) {
            Text("필터 활성화")
                .font(22, .bold)
            
            VStack {
                Toggle(isOn: bind(\.isBasicFilterEnabled, intent.setisBasicFilterEnabled)) {
                    VStack(alignment: .leading) {
                        Text("K-Spam 기본 필터 활성화")
                            .font(16)
                            .padding(.bottom, 2)
                        Text("K-Spam에서 설정한 기본 스팸 필터를 활성화 합니다.")
                            .font(12)
                            .foregroundStyle(.gray)
                    }
                }
            }
            
            VStack {
                Toggle(isOn: bind(\.isScheduledFilterEnabled, intent.setisScheduledFilterEnabled)) {
                    VStack(alignment: .leading) {
                        Text("예약 활성화")
                            .font(16)
                            .padding(.bottom, 2)
                        Text("특정 시간대에만 스팸 필터를 활성화합니다")
                            .font(12)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 1)
                        Text("• 비활성화 시 24시간 필터가 작동합니다.")
                            .font(10)
                            .foregroundStyle(.gray)
                    }
                }
                
                if state.isScheduledFilterEnabled {
                    HStack {
                        Text(state.startTimeString)
                        
                        Text("~")
                        
                        Text(state.endTimeString)
                    }
                }
            }
            
            VStack {
                Toggle(isOn: bind(\.isTravelNotificationEnabled, intent.setisTravelNotificationEnabled)) {
                    VStack(alignment: .leading){
                        Text("여행기간 중 비활성화")
                            .font(16)
                            .padding(.bottom, 2)
                        Text("여행 기간에는 스팸기능을 꺼두는 걸 추천드려요.")
                            .font(12)
                            .padding(.bottom, 1)
                        Text("• 해외에서 보내는 문자 메시지가 스팸으로 차단될 수 있어요.")
                            .font(10)
                            .foregroundStyle(.gray)
                    }
                }
                
                if state.isTravelNotificationEnabled {
                    HStack {
                        Text(state.startDateString)
                        
                        Text("-")
                        
                        Text(state.endDateString)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

#Preview {
    TabView {
        SettingsView()
    }
}
