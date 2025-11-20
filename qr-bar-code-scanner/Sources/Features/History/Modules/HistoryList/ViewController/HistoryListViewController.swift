import SwiftUI
import Combine

final class HistoryListViewController: BaseViewController {
    private let viewModel: HistoryListViewModel
    private let viewBuilder: () -> any View
    private var editButton: UIBarButtonItem?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        viewModel: HistoryListViewModel,
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
        navigationItem.title = "Barcode Scanner & QR Reader"
        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        editButton?.tintColor = .black
        navigationItem.rightBarButtonItem = editButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func editTapped() {
        viewModel.isEdit.toggle()
        if viewModel.isEdit {
            editButton?.title = "Done"
        } else {
            editButton?.title = "Edit"
        }
    }
}
