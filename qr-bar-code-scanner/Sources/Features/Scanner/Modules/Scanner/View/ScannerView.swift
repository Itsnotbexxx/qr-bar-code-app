import SwiftUI
import AVKit

struct ScannerView<ViewModel: ScannerViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var cameraPermission: CameraPermission = .notDetermined
    @Environment(\.openURL) private var openURL
    @StateObject private var cameraDelegate = CameraScannerDelegate()
    @State private var scannedModel: HistoryModel?
    @State private var isSplashOn: Bool = false
    
    var body: some View {
        ZStack {
            CameraView(frameSize: UIScreen.main.bounds.size, session: $session)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                scannerFrame
                Text("QR Code")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.9))
                    .padding(12)
                    .background(Color(hex: "#E6E6E6"))
                    .cornerRadius(8)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .position(x: UIScreen.main.bounds.width / 2,
                      y: UIScreen.main.bounds.height / 2)
            
            topButtons
        }
        .onAppear(perform: checkPermissions)
        .alert(errorMessage, isPresented: $showError) {
            if cameraPermission == .denied {
                Button("Settings") {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        openURL(settingsURL)
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        .onChange(of: cameraDelegate.scannedModel) { newValue in
            if let model = newValue {
                scannedModel = model
                
                session.stopRunning()
                stopScanningAnimation()
                
                viewModel.resultSubject.send(.showScannedDetail(model: model))
            }
        }
    }
    
    private var scannerFrame: some View {
        // Размер области сканирования
        let frameSize: CGFloat = UIScreen.main.bounds.width * 0.7
        
        return ZStack {
            // Угловые бордюры
            ForEach(0..<4, id: \.self) { index in
                let rotation = Double(index) * 90
                
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .trim(from: 0.61, to: 0.64)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 3, lineCap: .square, lineJoin: .round))
                    .rotationEffect(.degrees(rotation))
                    .frame(width: frameSize, height: frameSize)
            }
            
            Rectangle()
                .fill(Color.red)
                .frame(height: 2.5)
                .shadow(color: Color.red.opacity(0.7), radius: 8, x: 0, y: isScanning ? 15 : -15)
                .offset(y: isScanning ? frameSize / 2 : -frameSize / 2)
        }
        .frame(width: frameSize, height: frameSize)
    }

    private var topButtons: some View {
        VStack {
            HStack(spacing: 16) {
                Button(action: {
                    toggleTorch()
                }) {
                    Image(isSplashOn ? "flash_on" : "flash_off")
                        .padding(12)
                        .background(Color.black.opacity(0.16))
                        .cornerRadius(8)
                }

                Spacer()
                
                Button(action: {
                    print("Gallery tapped")
                }) {
                    Image("gallery")
                        .padding(12)
                        .background(Color.black.opacity(0.16))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 50)
            .ignoresSafeArea(edges: .top)

            Spacer()
        }
    }
    
    private func checkPermissions() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    cameraPermission = .denied
                    presentError("Camera access denied")
                }
            case .restricted, .denied:
                cameraPermission = .denied
                presentError("Camera access denied")
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    DispatchQueue.global(qos: .background).async {
                        session.startRunning()
                    }
                    startScanningAnimation()
                }
            default:
                break
            }
        }
    }
    
    private func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
    
    private func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("error")
                
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("error")
                
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(cameraDelegate, queue: .main)
            session.commitConfiguration()
            
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            startScanningAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    private func startScanningAnimation() {
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
            isScanning = true
        }
    }
    
    private func stopScanningAnimation() {
        withAnimation(.easeInOut(duration: 0.85)) {
            isScanning = false
        }
    }
    
    private func toggleTorch() {
        guard let device = AVCaptureDevice.default(for: .video),
              device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            if device.torchMode == .on {
                device.torchMode = .off
                isSplashOn = false
            } else {
                try device.setTorchModeOn(level: 1.0)
                isSplashOn = true
            }
            
            device.unlockForConfiguration()
            
        } catch {
            print("Torch error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ScannerView(viewModel: ScannerViewModel())
}
