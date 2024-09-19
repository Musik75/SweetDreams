import Foundation

struct SleepEntry: Identifiable {
    let id = UUID()
    let date: Date
    let sleepTime: Date
    let wakeTime: Date
    let quality: Int
    
    var duration: TimeInterval {
        return wakeTime.timeIntervalSince(sleepTime)
    }
}

class SleepData: ObservableObject {
    @Published var entries: [SleepEntry] = []
    
    func addEntry(_ entry: SleepEntry) {
        entries.append(entry)
    }
    
    var averageDuration: TimeInterval {
        guard !entries.isEmpty else { return 0 }
        let totalDuration = entries.reduce(0) { $0 + $1.duration }
        return totalDuration / Double(entries.count)
    }
    
    var averageQuality: Double {
        guard !entries.isEmpty else { return 0 }
        let totalQuality = entries.reduce(0) { $0 + $1.quality }
        return Double(totalQuality) / Double(entries.count)
    }
}