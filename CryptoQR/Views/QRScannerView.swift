//
//  QRScannerView.swift
//  CryptoQR
//
//  Created by Rohan  Gupta on 19/10/22.
//

import SwiftUI
import CodeScanner

struct QRScannerView: View {
    
    @State private var showScanner = true

    @ObservedObject var scannerViewModel: ScannerViewModel = ScannerViewModel()
    
    var body: some View {
        VStack {
            Text(scannerViewModel.homeUIModel.title)
                .font(scannerViewModel.homeUIModel.titleFont)
                .foregroundColor(scannerViewModel.homeUIModel.titleForegroundColor)

            Spacer()
            
            if scannerViewModel.scannedCode != nil {
                VStack(spacing: 10) {
                    Text(scannerViewModel.scannedCode!)

                    HStack(spacing: 3) {
                        Text("The address is")
                        Text(scannerViewModel.homeUIModel.validationResultText)
                            .foregroundColor(scannerViewModel.homeUIModel.validationResultColor)
                    }

                    if scannerViewModel.homeUIModel.addressType != nil {
                        Text(scannerViewModel.homeUIModel.addressTypeDescription!)
                    }
                }
                .font(scannerViewModel.homeUIModel.resultFont)
                .foregroundColor(scannerViewModel.homeUIModel.resultForegroundColor)
                .padding()
                .background {
                    scannerViewModel.homeUIModel.validationResultColor.opacity(0.5)
                }
                .cornerRadius(scannerViewModel.homeUIModel.cornerRadius)
            }
            
            Spacer()

            Button {
                withAnimation {
                    showScanner = true
                }
            } label: {
                Text(scannerViewModel.homeUIModel.scanButtonLabel)
                    .font(scannerViewModel.homeUIModel.resultFont)
                    .foregroundColor(scannerViewModel.homeUIModel.scanButtonForegroundColor)
                    .padding()
                    .background {
                        scannerViewModel.homeUIModel.scanButtonBackgroundColor
                    }
                    .cornerRadius(scannerViewModel.homeUIModel.cornerRadius)
            }
            .accessibilityIdentifier("scanButton")

        }
        .sheet(isPresented: $showScanner) {
            CodeScannerView(codeTypes: [.qr], showViewfinder: true, simulatedData: "bc1pmzfrwwndsqmk5yh69yjr5lfgfg4") { response in
                if case let .success(result) = response {
                    scannerViewModel.processScannedCode(result.string)
                    showScanner = false
                }
            }
        }
    }
    
}

struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerView()
    }
}
