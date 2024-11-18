//
//  presenter.swift
//  MVP_demo
//
//  Created by Admin on 18/11/24.
//

import Foundation

protocol PersonView: AnyObject {
    func displayPersons(_ persons: [Person])
    func displayError(_ error: String)
}

class PersonPresenter {
    weak var view: PersonView?

    init(view: PersonView) {
        self.view = view
    }

    func loadPersons() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            view?.displayError("File not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let persons = try JSONDecoder().decode([Person].self, from: data)
            view?.displayPersons(persons)
        } catch {
            view?.displayError("Failed to load data")
        }
    }
}
