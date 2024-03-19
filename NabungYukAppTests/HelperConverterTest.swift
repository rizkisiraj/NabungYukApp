//
//  HelperConverterTest.swift
//  NabungYukAppTests
//
//  Created by Rizki Siraj on 18/03/24.
//

import XCTest
@testable import NabungYukApp

final class HelperConverterTest: XCTestCase {

    let helper = Helpers.shared
    
    func testShouldFormatNumberToRupiah() throws {
        let amountToConvert = 100000
        let convertedAmount = helper.formatNumberToRupiah(number: amountToConvert)
        
        XCTAssertEqual(convertedAmount, "Rp100.000")
    }
    
    func testNumberShouldBeZero() throws {
        let amountToConvert = -1
        let convertedAmount = helper.formatNumberToRupiah(number: amountToConvert)
        
        XCTAssertEqual(convertedAmount, "Rp0")
    }
    
    func testDivideBySameNumber_ShouldReturnOne() throws {
        let process = 10
        let target = 10
        
        let result = helper.generatePercentage(target: target, process: process)
        XCTAssertEqual(result, 1)
    }
    
    func testInputNegativeNumber_ShouldReturnZero() throws {
        let process = -1
        let target = 10
        
        let result = helper.generatePercentage(target: target, process: process)
        XCTAssertEqual(result, 0)
    }

    func testProcessHigherThanTarget_ShouldReturnOne() throws {
        let process = 100
        let target = 50
        
        let result = helper.generatePercentage(target: target, process: process)
        XCTAssertEqual(result, 1)
    }
    
    func testInputProperNumber_ShouldReturnDuaHariLagi() {
        let target = 200000
        let savingPerPeriod = 100000
        let period = PeriodSelection.daily
        
        let result = helper.timeToReachTarget(target: target, savingsPerPeriod: savingPerPeriod, period: period)
        XCTAssertEqual(result, "2 hari lagi")
    }
}
