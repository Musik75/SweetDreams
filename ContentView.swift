import SwiftUI

struct ContentView: View {
    @StateObject private var sleepData = SleepData()
    @State private var showingAddSleep = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Sleep Stats")) {
                    HStack {
                        Text("Average Duration:")
                        Spacer()
                        Text(formatDuration(sleepData.averageDuration))
                    }
                    HStack {
                        Text("Average Quality:")
                        Spacer()
                        Text(String(format: "%.1f", sleepData.averageQuality))
                    }
                }
                
                Section(header: Text("Sleep Entries")) {
                    ForEach(sleepData.entries) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.date, style: .date)
                            HStack {
                                Text("Duration: \(formatDuration(entry.duration))")
                                Spacer()
                                Text("Quality: \(entry.quality)")
                            }
                            .font(.caption)
                        }
                    }
                }
            }
            .navigationTitle("SweetDreams")
            .toolbar {
                Button(action: { showingAddSleep = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddSleep) {
                AddSleepView(sleepData: sleepData)
            }
        }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: duration) ?? ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}