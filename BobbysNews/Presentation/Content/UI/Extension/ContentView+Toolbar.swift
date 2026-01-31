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
                    .accessibilityIdentifier(Accessibility.apiKeyAddEditButton.id)
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
                    .accessibilityIdentifier(Accessibility.countryPicker.id)
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
                        viewModel.showResetConfirmationDialog = true
                        viewModel.sensoryFeedbackTrigger(feedback: .press(.button))
                    }
                    .accessibilityIdentifier(Accessibility.resetButton.id)
                }
            } label: {
                Image(systemName: "gearshape")
            }
            .alert(
                "ApiKeyAlert",
                isPresented: $viewModel.showEditAlert
            ) {
                TextField(
                    "ApiKeyAlertPlaceholder",
                    text: $viewModel.selectedApiKey
                )

                Button("GoToGNews") {
                    viewModel.showWebView = true
                    viewModel.sensoryFeedbackTrigger(feedback: .press(.button))
                }
                .accessibilityIdentifier(Accessibility.showWebViewButton.id)

                Button(role: .confirm) {
                    apiKey = viewModel.selectedApiKey

                    Task {
                        await viewModel.fetchTopHeadlines(state: .isLoading)
                    }
                }
                .disabled(viewModel.selectedApiKeyConfirmDisabled)
                .accessibilityIdentifier(Accessibility.apiKeyAlertConfirmButton.id)

                Button(role: .cancel) {
                    viewModel.selectedApiKey = ""
                    viewModel.sensoryFeedbackTrigger(feedback: .press(.button))
                }
            }
            .confirmationDialog(
                "ResetConfirmationDialog",
                isPresented: $viewModel.showResetConfirmationDialog,
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
                .accessibilityIdentifier(Accessibility.resetButtonConfirmationDialog.id)
            }
            .popoverTip(viewModel.settingsTip)
            .accessibilityIdentifier(Accessibility.settingsMenu.id)
        }
    }
}
