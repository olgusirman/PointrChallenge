import SwiftUI

struct LogView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = LogModel()

    var body: some View {
        VStack {
            List {
                // TODO: Pass log count here
                // TODO: Pass appropriate icons here
                Section(header: Text("Logs"), footer: Text("Pass log count here")) {
                    ForEach(viewModel.logs) { log in
                        Label(log.message, systemImage: "eye.trianglebadge.exclamationmark" )
                    }
                }
            }
            .listStyle(.plain)
            Button("Dismiss") {
                dismiss()
            }
            .padding()
        }
    }
}
