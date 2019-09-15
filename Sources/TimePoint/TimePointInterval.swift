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

import struct Dispatch.DispatchTime
import enum Dispatch.DispatchTimeInterval

/// Represents an interval of time.
public struct TimePointInterval: Hashable, Comparable {
    public static func nanoseconds(_ value: Int64) -> TimePointInterval {
        return TimePointInterval(value)
    }

    public static func microseconds(_ value: Int64) -> TimePointInterval {
        return TimePointInterval(value * 1000)
    }

    public static func milliseconds(_ value: Int64) -> TimePointInterval {
        return TimePointInterval(value * 1_000_000)
    }

    public static func seconds(_ value: Int64) -> TimePointInterval {
        return TimePointInterval(value * 1_000_000_000)
    }

    public static func minutes(_ value: Int64) -> TimePointInterval {
        return TimePointInterval(value * 1_000_000_000 * 60)
    }

    public static func hours(_ value: Int64) -> TimePointInterval {
        return TimePointInterval(value * 1_000_000_000 * 60 * 60)
    }

    public static func == (lhs: TimePointInterval, rhs: TimePointInterval) -> Bool {
        return lhs.nanoseconds == rhs.nanoseconds
    }

    public static func < (lhs: TimePointInterval, rhs: TimePointInterval) -> Bool {
        return lhs.nanoseconds < rhs.nanoseconds
    }

    public static func > (lhs: TimePointInterval, rhs: TimePointInterval) -> Bool {
        return lhs.nanoseconds > rhs.nanoseconds
    }

    public static func += (lhs: inout TimePointInterval, rhs: TimePointInterval) {
        lhs = TimePointInterval(lhs.nanoseconds + rhs.nanoseconds)
    }

    public static func + (lhs: TimePointInterval, rhs: TimePointInterval) -> TimePointInterval {
        var lhsCopy = lhs
        lhsCopy += rhs
        return lhsCopy
    }

    public static func -= (lhs: inout TimePointInterval, rhs: TimePointInterval) {
        lhs = TimePointInterval(lhs.nanoseconds - rhs.nanoseconds)
    }

    public static func - (lhs: TimePointInterval, rhs: TimePointInterval) -> TimePointInterval {
        var lhsCopy = lhs
        lhsCopy -= rhs
        return lhsCopy
    }

    public static func /= <T>(lhs: inout TimePointInterval, rhs: T) where T: BinaryInteger {
        lhs = TimePointInterval(lhs.nanoseconds / Int64(rhs))
    }

    public static func / <T>(lhs: TimePointInterval, rhs: T) -> TimePointInterval where T: BinaryInteger {
        var lhsCopy = lhs
        lhsCopy /= rhs
        return lhsCopy
    }

    public static func *= <T>(lhs: inout TimePointInterval, rhs: T) where T: BinaryInteger {
        lhs = TimePointInterval(lhs.nanoseconds * Int64(rhs))
    }

    public static func * <T>(lhs: TimePointInterval, rhs: T) -> TimePointInterval where T: BinaryInteger {
        var lhsCopy = lhs
        lhsCopy *= rhs
        return lhsCopy
    }

    public static func * <T>(lhs: T, rhs: TimePointInterval) -> TimePointInterval where T: BinaryInteger {
        var rhsCopy = rhs
        rhsCopy *= lhs
        return rhsCopy
    }

    /// Makes a TimePointInterval from a DispatchTimeInterval.
    ///
    /// - Parameter dispatchTimeInterval: The instance to convert
    /// - Returns: A TimePointInterval representation of the DispatchTimeInterval, if possible.
    public static func makeTimePointInterval(from dispatchTimeInterval: DispatchTimeInterval) -> TimePointInterval? {
        switch dispatchTimeInterval {
        case let .nanoseconds(value):
            return TimePointInterval.nanoseconds(Int64(value))
        case let .microseconds(value):
            return TimePointInterval.microseconds(Int64(value))
        case let .milliseconds(value):
            return TimePointInterval.milliseconds(Int64(value))
        case let .seconds(value):
            return TimePointInterval.seconds(Int64(value))
        case .never:
            return nil
        @unknown default:
            return nil
        }
    }

    /// The number of nanoseconds representing the time interval
    public private(set) var nanoseconds: Int64

    init(_ nanoseconds: Int64) {
        self.nanoseconds = nanoseconds
    }

    /// Makes a DispatchTimeInterval from this instance.
    public func makeDispatchTimeInterval() -> DispatchTimeInterval {
        return DispatchTimeInterval.nanoseconds(Int(self.nanoseconds))
    }
}
