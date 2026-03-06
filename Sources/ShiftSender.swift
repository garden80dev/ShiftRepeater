import Foundation
import CoreGraphics

/// Sends repeated Shift key press/release events to the frontmost app.
final class ShiftSender: ObservableObject {
    @Published var isActive = false {
        didSet {
            if isActive { startRepeating() }
            else { stopRepeating() }
        }
    }

    /// Interval in milliseconds between each Shift press
    @Published var intervalMs: Double = 1000

    private var timer: DispatchSourceTimer?

    private func startRepeating() {
        stopRepeating()

        let timer = DispatchSource.makeTimerSource(queue: .global(qos: .userInteractive))
        timer.schedule(
            deadline: .now(),
            repeating: .milliseconds(Int(intervalMs)),
            leeway: .milliseconds(5)
        )
        timer.setEventHandler { [weak self] in
            self?.sendShift()
        }
        timer.resume()
        self.timer = timer
    }

    private func stopRepeating() {
        timer?.cancel()
        timer = nil
    }

    private func sendShift() {
        // kVK_Shift = 0x38 (56)
        let keyCode: CGKeyCode = 0x38

        // Key down
        if let keyDown = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: true) {
            keyDown.flags = .maskShift
            keyDown.post(tap: .cghidEventTap)
        }

        // Small delay then key up
        usleep(30_000) // 30ms hold

        if let keyUp = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: false) {
            keyUp.flags = []
            keyUp.post(tap: .cghidEventTap)
        }
    }

    func updateInterval(_ ms: Double) {
        intervalMs = ms
        if isActive {
            startRepeating()
        }
    }

    deinit {
        stopRepeating()
    }
}
