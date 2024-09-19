import SwiftUI

struct AddSleepView: View {
    @ObservedObject var sleepData: SleepData
    @Environment(\.presentationMode) var presentationMode
    
    @State private var date = Date()
    @State private var sleepTime = Date()
    @State private var wakeTime = Date()
    @State private var quality = 3
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                DatePicker("Sleep Time", selection: $sleepTime, displayedComponents: .hourAndMinute)
                DatePicker("Wake Time", selection: $wakeTime, displayedComponents: .hourAndMinute)
                Picker("Sleep Quality", selection: $quality) {
                    ForEach(1...5, id: \.self) { rating in
                        Text("\(rating)")
                    }
                }
            }
            .navigationTitle("Add Sleep Entry")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                let newEntry = SleepEntry(date: date, sleepTime: sleepTime, wakeTime: wakeTime, quality: quality)
                sleepData.addEntry(newEntry)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddSleepView_Previews: PreviewProvider {
    static var previews: some View {
        AddSleepView(sleepData: SleepData())
    }
}