import SwiftUI

struct ContentView: View {

    @EnvironmentObject var logModel: LogModel
    @State private var showingSheet = false

    var body: some View {
        VStack(spacing: 8) {
            Button("Log Default") {
                logModel.log(logType: .log)
            }
            .foregroundColor(Log.LogType.log.accentColor)
            Button("Log Info") {
                logModel.log(logType: .info)
            }
            .foregroundColor(Log.LogType.info.accentColor)
            Button("Log Warning") {
                logModel.log(logType: .warning)
            }
            .foregroundColor(Log.LogType.warning.accentColor)
            Button("Log Error") {
                logModel.log(logType: .error)
            }
            .foregroundColor(Log.LogType.error.accentColor)
            Button("Show Logger") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                LogView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
