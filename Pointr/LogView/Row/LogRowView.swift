import SwiftUI

struct LogRowView: View {

    let log: Log

    var body: some View {
        HStack {
            Label {
                Text(log.message)
            } icon: {
                Image(systemName: log.type.systemImageName)
                    .foregroundColor(log.type.accentColor)
            }
            Spacer()
            Text(log.dateString)
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }

}

struct LogRowView_Previews: PreviewProvider {

    static var mockLog = Log(message: "Some log", type: .log, date: .previewMock)
    static var mockInfo = Log(message: "Some info", type: .info, date: .previewMock)
    static var mockWarning = Log(message: "Some warning", type: .warning, date: .previewMock)
    static var mockError = Log(message: "Some Error", type: .error, date: .previewMock)

    static var previews: some View {
        Group {
            LogRowView(log: mockLog)
            LogRowView(log: mockInfo)
            LogRowView(log: mockWarning)
            LogRowView(log: mockError)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

private extension Date {

    /// Thursday, 23 March 2023 21:26:50
    static var previewMock: Date {
        Date(timeIntervalSince1970: 1679606810)
    }

}
