import SwiftUI
import Combine

final class ScannerViewController: BaseViewController {
    private let viewModel: ScannerViewModel
    private let viewBuilder: () -> any View
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        viewModel: ScannerViewModel,
        @ViewBuilder viewBuilder: @escaping () -> some View
    ) {
        self.viewModel = viewModel
        self.viewBuilder = viewBuilder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        add(viewBuilder())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

