//  Copyright 2019 Bryant Luk
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import XCTest

import TimePoint

public final class TimePointIntervalTests: XCTestCase {
    // MARK: Subtraction operator between two Times

    func testMaxTimeMinusMaxTime() {
        let interval = TimePoint(uptimeNanoseconds: .max) - TimePoint(uptimeNanoseconds: .max)
        XCTAssertEqual(interval, TimePointInterval.nanoseconds(0))
    }

    func testMaxTimeMinusAnyTimeOtherThanMaxTime() {
        let interval = TimePoint(uptimeNanoseconds: .max)
            - TimePoint(uptimeNanoseconds: UInt64.random(in: 0..<UInt64.max))
        XCTAssertEqual(interval, TimePointInterval.nanoseconds(.max))
    }

    func testAnyTimeOtherThanMaxTimeMinusMaxTime() {
        let interval = TimePoint(uptimeNanoseconds: UInt64.random(in: 0..<UInt64.max))
            - TimePoint(uptimeNanoseconds: .max)
        XCTAssertEqual(interval, TimePointInterval.nanoseconds(.min))
    }

    func testMaxTimeMinusMinTime() {
        let interval = TimePoint(uptimeNanoseconds: .max) - TimePoint(uptimeNanoseconds: .min)
        XCTAssertEqual(interval, TimePointInterval.nanoseconds(.max))
    }

    func testMinTimeMinusMaxTime() {
        let interval = TimePoint(uptimeNanoseconds: .min) - TimePoint(uptimeNanoseconds: .max)
        XCTAssertEqual(interval, TimePointInterval.nanoseconds(.min))
    }

    func testNowTimeMinusMinTime() {
        let interval = TimePoint.now() - TimePoint(uptimeNanoseconds: .min)
        XCTAssertGreaterThan(interval, TimePointInterval.nanoseconds(0))
    }

    func testMaxTimeMinusNowTime() {
        let interval = TimePoint(uptimeNanoseconds: .max) - TimePoint.now()
        XCTAssertGreaterThan(interval, TimePointInterval.nanoseconds(0))
    }

    func testNowTimeMinusMaxTime() {
        let interval = TimePoint.now() - TimePoint(uptimeNanoseconds: .max)
        XCTAssertLessThan(interval, TimePointInterval.nanoseconds(0))
    }

    func testMinTimeMinusNowTime() {
        let interval = TimePoint(uptimeNanoseconds: .min) - TimePoint.now()
        XCTAssertLessThan(interval, TimePointInterval.nanoseconds(0))
    }

    // MARK: Addition and subtraction for Time at max

    func testMaxTimePlusMaxTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .max) + TimePointInterval.nanoseconds(.max)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .max))
    }

    func testMaxTimeMinusMaxTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .max) - TimePointInterval.nanoseconds(.max)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .max))
    }

    func testMaxMinusOneTimePlusMaxTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .max - 1) + TimePointInterval.nanoseconds(.max)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .max))
    }

    func testMaxMinusOneTimeMinusMaxTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .max - 1) - TimePointInterval.nanoseconds(.max)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: UInt64(UInt64.max - 1 - Int64.max.magnitude)))
    }

    func testMaxTimePlusMinTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .max) + TimePointInterval.nanoseconds(.min)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .max))
    }

    func testMaxTimeMinusMinTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .max) - TimePointInterval.nanoseconds(.min)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .max))
    }

    func testMaxMinusOneTimePlusMinTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .max - 1) + TimePointInterval.nanoseconds(.min)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: UInt64(UInt64.max - 1 - Int64.min.magnitude)))
    }

    func testMaxMinusOneTimeMinusMinTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .max - 1) - TimePointInterval.nanoseconds(.min)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .max))
    }

    // MARK: Addition and subtraction for Time at min

    func testMinTimePlusMaxTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .min) + TimePointInterval.nanoseconds(.max)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .max))
    }

    func testMinTimeMinusMaxTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .min) - TimePointInterval.nanoseconds(.max)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .min))
    }

    func testMinPlusOneTimePlusMaxTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .min + 1) + TimePointInterval.nanoseconds(.max)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .max))
    }

    func testMinPlusOneTimeMinusMaxTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .min + 1) - TimePointInterval.nanoseconds(.max)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .min))
    }

    func testMinTimePlusMinTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .min) + TimePointInterval.nanoseconds(.min)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .min))
    }

    func testMinTimeMinusMinTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .min) - TimePointInterval.nanoseconds(.min)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: Int64.min.magnitude))
    }

    func testMinPlusOneTimePlusMinTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .min + 1) + TimePointInterval.nanoseconds(.min)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: .min))
    }

    func testMinPlusOneTimeMinusMinTimeInterval() {
        let time = TimePoint(uptimeNanoseconds: .min + 1) - TimePointInterval.nanoseconds(.min)
        XCTAssertEqual(time, TimePoint(uptimeNanoseconds: Int64.min.magnitude + 1))
    }
}
