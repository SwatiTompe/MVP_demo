

import UIKit

class PersonViewController: UIViewController, PersonView {
    private var presenter: PersonPresenter!
    private var persons: [Person] = []

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Initialize Presenter
        presenter = PersonPresenter(view: self)
        presenter.loadPersons()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - PersonView Methods
    func displayPersons(_ persons: [Person]) {
        self.persons = persons
        tableView.reloadData()
    }

    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension PersonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let person = persons[indexPath.row]
        cell.textLabel?.text = "\(person.name), Age: \(person.age)"
        return cell
    }
}
