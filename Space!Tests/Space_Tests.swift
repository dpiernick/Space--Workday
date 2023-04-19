//
//  Space_Tests.swift
//  Space!Tests
//
//  Created by Dave Piernick on 4/18/23.
//

import XCTest
@testable import Space_

final class Space_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShouldFetchWithTermAndLessThan100AndMoreItems() {
        let vm = ResultsViewModel(searchTerm: "moon")
        XCTAssertTrue(vm.shouldFetch())
    }
    
    func testShouldFetchNoTermAndLessThan100AndMoreItems() {
        let vm = ResultsViewModel(searchTerm: "")
        XCTAssertFalse(vm.shouldFetch())
    }
    
    func testShouldFetchWithTermAndLessThan100AndNoMoreItems() {
        let vm = ResultsViewModel(searchTerm: "moon")
        vm.totalItems = vm.items.count
        XCTAssertFalse(vm.shouldFetch())
    }
    
    func testShouldFetchNoTermAnd99PagesAndMoreItems() {
        let vm = ResultsViewModel(searchTerm: "moon")
        vm.pageToFetch = 99
        XCTAssertTrue(vm.shouldFetch())
    }
    
    func testShouldFetchNoTermAnd100PagesAndMoreItems() {
        let vm = ResultsViewModel(searchTerm: "moon")
        vm.pageToFetch = 100
        XCTAssertTrue(vm.shouldFetch())
    }
    
    func testShouldFetchNoTermAnd101PagesAndMoreItems() {
        let vm = ResultsViewModel(searchTerm: "moon")
        vm.pageToFetch = 101
        XCTAssertFalse(vm.shouldFetch())
    }
    
    func testURLwithValidTerm() {
        let vm = ResultsViewModel(searchTerm: "moon")
        XCTAssertNotNil(vm.encodedURL())
    }
    
    func testURLPercentEncoding() {
        let vm = ResultsViewModel(searchTerm: " ")
        XCTAssertNotNil(vm.encodedURL())
    }
    
    func testURLBlankSearchTerm() {
        let vm = ResultsViewModel(searchTerm: "")
        XCTAssertNotNil(vm.encodedURL())
    }
    
    func testFetchResults() {
        let vm = ResultsViewModel(searchTerm: "moon")
        Task {
            await vm.fetchNextPage()
            XCTAssertTrue(vm.items.count > 0)
        }
    }
    
    func testTableViewResults() async {
        let vc = await ResultsViewController(searchTerm: "moon")
        _ = await vc.view
        await vc.viewModel.fetchNextPage()
        let cells = await vc.tableView.visibleCells
        XCTAssertTrue(cells.count > 0)
    }

    func testSearchBarActive() {
        
    }

}
