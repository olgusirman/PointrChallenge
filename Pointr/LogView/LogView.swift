import SwiftUI

// TODO: Create different buttons for different logs
// TODO: Keep these logs static and show it when the screen appears for the first time
struct LogView: View {
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var logModel: LogModel

    // MARK: - ViewModel
    //@StateObject var viewModel = LogModel()

    // MARK: - Error
    @State private var lastErrorMessage = "" {
      didSet {
        isDisplayingError = true
      }
    }
    @State var isDisplayingError = false

    // MARK: - View
    var body: some View {
        VStack {
            List(logModel.logs) { log in
                LogRowView(log: log)
            }
            .listStyle(.plain)
            .refreshable {
                Task {
                    logModel.clear()
                    try await logModel.executeLogs()
                }
            }
            .task {
                do {
                    try await logModel.executeLogs()
                } catch {
                    lastErrorMessage = error.localizedDescription
                }
            }
            Button("Dismiss") {
                dismiss()
            }
            .padding()
        }
        .alert("Error Happened", isPresented: $isDisplayingError, actions: {
          Button("Ok") {
            dismiss()
          }
        }, message: {
          Text(lastErrorMessage)
        })
    }
}
