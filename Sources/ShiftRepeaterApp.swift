import SwiftUI

@main
struct ShiftRepeaterApp: App {
    @StateObject private var sender = ShiftSender()

    var body: some Scene {
        MenuBarExtra {
            Button(sender.isActive ? "✅ Attivo" : "⇧ Disattivo") {
                sender.isActive.toggle()
            }
            .keyboardShortcut("s")
            Divider()
            Button("Esci") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        } label: {
            Image(systemName: sender.isActive ? "shift.fill" : "shift")
        }
    }
}
