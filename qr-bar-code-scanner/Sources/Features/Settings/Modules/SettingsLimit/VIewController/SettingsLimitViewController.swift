import SwiftUI
import Combine

final class SettingsLimitViewController: BaseViewController {
    private let viewModel: SettingsLimitViewModel
    private let viewBuilder: () -> any View
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        viewModel: SettingsLimitViewModel,
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
        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = .black
    }
}
