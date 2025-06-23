//
//  ContentView+Toolbar.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.06.25.
//

import SwiftUI

extension ContentView {
    // MARK: - Layouts

    @ToolbarContentBuilder
    func Toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .title) {
            Text(category.localized)
                .popoverTip(viewModel.categoriesTip)
                .onAppear {
                    viewModel.showCategoriesTip()
                }
        }

        ToolbarItem(placement: .primaryAction) {
            Menu {
                ControlGroup {
                    Label(
                        !viewModel.selectedApiKey.isEmpty
                            ? viewModel.selectedApiKey : String(localized: "EmptyApiKey"),
                        systemImage: "key"
                    )
                    .fixedSize()

                    Button(
                        viewModel.selectedApiKey.isEmpty ? "Add" : "Edit",
                        systemImage: viewModel.selectedApiKey.isEmpty ? "plus" : "pencil"
                    ) {
                        viewModel.showEditAlert = true
                        viewModel.sensoryFeedbackTrigger(feedback: .press(.button))
                    }
                    .accessibilityIdentifier("ApiKeyAddEditButton")
                }

                Section {
                    Picker(
                        Locale.current.localizedString(forRegionCode: viewModel.selectedCountry)
                            ?? String(localized: "EmptyCountry"),
                        systemImage: "flag",
                        selection: $viewModel.selectedCountry
                    ) {
                        ForEach(
                            viewModel.countriesSorted,
                            id: \.self
                        ) {
                            Text(Locale.current.localizedString(forRegionCode: $0) ?? "")
                                .tag($0)
                        }
                    }
                    .accessibilityIdentifier("CountryPicker")
                    .pickerStyle(.menu)
                }

                Section {
                    Toggle(
                        "Translate",
                        systemImage: "translate",
                        isOn: $viewModel.translate
                    )
                    .disabled(viewModel.translateDisabled)
                }

                Section {
                    Button(
                        "Reset",
                        systemImage: "trash",
                        role: .destructive
                    ) {
                        viewModel.showConfirmationDialog = true
                        viewModel.sensoryFeedbackTrigger(feedback: .press(.button))
                    }
                    .accessibilityIdentifier("ResetButton")
                }
            } label: {
                Image(systemName: "gearshape")
            }
            .alert(
                "ApiKey",
                isPresented: $viewModel.showEditAlert
            ) {
                TextField(
                    "ApiKeyPlaceholder",
                    text: $viewModel.selectedApiKey
                )

                Button("GoToGNews") {
                    viewModel.showWebView = true
                    viewModel.sensoryFeedbackTrigger(feedback: .press(.button))
                }
                .accessibilityIdentifier("ShowWebViewButton")

                Button(role: .confirm) {
                    apiKey = viewModel.selectedApiKey

                    Task {
                        await viewModel.fetchTopHeadlines(state: .isLoading)
                    }
                }
                .accessibilityIdentifier("ApiKeyDoneButton")

                Button(role: .cancel) {
                    viewModel.sensoryFeedbackTrigger(feedback: .press(.button))
                }
            }
            .confirmationDialog(
                "ResetConfirmationDialog",
                isPresented: $viewModel.showConfirmationDialog,
                titleVisibility: .visible
            ) {
                Button(
                    "Reset",
                    role: .destructive
                ) {
                    Task {
                        await viewModel.reset()
                        apiKey = ""
                    }
                }
                .accessibilityIdentifier("ResetConfirmationDialogButton")
            }
            .popoverTip(viewModel.settingsTip)
            .accessibilityIdentifier("SettingsMenu")
        }
    }
}
