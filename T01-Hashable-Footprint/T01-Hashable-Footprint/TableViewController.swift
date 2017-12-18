//
//  TableViewController.swift
//  T01-Hashable-Footprint
//
//  Created by lili on 2017/12/11.
//  Copyright © 2017年 fun. All rights reserved.
//

import UIKit

let cellResueId = "citiesCell"

class TableViewController: UITableViewController {

    struct State: StateType {
        var dataSource = TableViewControllerDataSource(cities: [], selectedCitiesSet: [], owner: nil)
    }
    
    enum Action: ActionType {
        case loadCities
        case updateCitiesFromData(cities: [City])
        case tapCity(index: Int)
    }
    
    enum Command: CommandType {
        case loadCities(completion: ([City]) -> Void )
    }
    
    lazy var reducer: (State, Action) -> (State, Command?) = {
        [weak self] (state, action) in
        
        var state: State = state
        var command: Command? = nil
        
        switch action {
        case .loadCities:
            command = Command.loadCities { self?.store.dispatch(.updateCitiesFromData(cities: $0)) }
        case .updateCitiesFromData(let cities):
            state.dataSource = TableViewControllerDataSource(cities: cities, selectedCitiesSet: [], owner: state.dataSource.owner)
        case .tapCity(let index):
            var selectedCitiesSet: Set<City> = state.dataSource.selectedCitiesSet
            let tapCity = state.dataSource.cities[index]
            _ = selectedCitiesSet.remove(tapCity) ?? selectedCitiesSet.insert(tapCity).memberAfterInsert
            state.dataSource = TableViewControllerDataSource(cities: state.dataSource.cities, selectedCitiesSet: selectedCitiesSet, owner: state.dataSource.owner)
        }
        return (state, command)
    }
    
    var store: Store<State, Action, Command>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Footprint"

        let dataSource = TableViewControllerDataSource(cities: [], selectedCitiesSet: [], owner: self)
        store = Store<State, Action, Command>(reducer: reducer, inititalState: State(dataSource: dataSource))
        store.subscribe { [weak self] (state, previousState, command) in
            self?.stateDidChanged(state: state, previousState: previousState, command: command)
        }
        
        stateDidChanged(state: store.state, previousState: nil, command: nil)
        store.dispatch(.loadCities)
    }
    
    func stateDidChanged(state: State, previousState: State?, command: Command?) {
        if let command = command, case .loadCities(let handler) = command {
            CityStore.shared.getCities(completionHandler: handler)
        }
        
        if previousState == nil
            || previousState!.dataSource.cities != state.dataSource.cities
            || previousState!.dataSource.selectedCitiesSet != state.dataSource.selectedCitiesSet
        {
            tableView.dataSource = state.dataSource
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        store.dispatch(.tapCity(index: indexPath.row))
    }
}
