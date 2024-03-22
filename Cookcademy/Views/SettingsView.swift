//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Brenna Pacheco on 22/03/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var listBackgroundColor = AppColor.background
    @State private var listTextColor = AppColor.foreground
    @State private var hideOptionalSteps: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                ColorPicker("Background color", selection: $listBackgroundColor).listRowBackground(listBackgroundColor)
                ColorPicker("Text Color", selection: $listTextColor).listRowBackground(listBackgroundColor)
                Toggle("Hide Optional Steps", isOn: $hideOptionalSteps).listRowBackground(listBackgroundColor)
            }
            .foregroundStyle(listTextColor)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
