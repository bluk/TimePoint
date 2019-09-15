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

import Dispatch

/// Represents a point in time.
public struct TimePoint: Hashable, Comparable {
    /// Returns the current point in time.
    public static func now() -> TimePoint {
        return TimePoint(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds)
    }

    /// Returns a point in time far in the future.
    ///
    /// - Warning: The value is considered a special value in all operations/functions.
    public static let distantFuture: TimePoint = TimePoint(uptimeNanoseconds: UInt64.max)

    /// Returns the time interval difference between the two points of time.
    /// - Warning: The time interval difference is clamped to Int64.max nanoseconds.
    /// - Parameter lhs: The left hand side value
    /// - Parameter rhs: The right hand side value
    /// - Returns: The time interval difference between the two points of time
    public static func - (lhs: TimePoint, rhs: TimePoint) -> TimePointInterval {
        switch (lhs.uptimeNanoseconds, rhs.uptimeNanoseconds) {
        case (UInt64.max, UInt64.max):
            return TimePointInterval(0)
        case (UInt64.max, _):
            return TimePointInterval(Int64.max)
        case (_, UInt64.max):
            return TimePointInterval(Int64.min)
        default:
            if lhs.uptimeNanoseconds > rhs.uptimeNanoseconds {
                let difference = lhs.uptimeNanoseconds - rhs.uptimeNanoseconds
                return TimePointInterval(Int64(clamping: difference))
            }

            let difference = rhs.uptimeNanoseconds - lhs.uptimeNanoseconds
            return TimePointInterval(Int64(clamping: difference) * -1)
        }
    }

    public static func + (lhs: TimePoint, rhs: TimePointInterval) -> TimePoint {
        if lhs.uptimeNanoseconds == UInt64.max {
            return lhs
        }

        if rhs.nanoseconds < 0 {
            if rhs.nanoseconds.magnitude > lhs.uptimeNanoseconds {
                return TimePoint(uptimeNanoseconds: 0)
            }

            let nanoSeconds = lhs.uptimeNanoseconds - rhs.nanoseconds.magnitude
            return TimePoint(uptimeNanoseconds: nanoSeconds)
        }

        let dispatchTime = lhs.makeDispatchTime() + rhs.makeDispatchTimeInterval()
        return TimePoint(uptimeNanoseconds: dispatchTime.uptimeNanoseconds)
    }

    public static func - (lhs: TimePoint, rhs: TimePointInterval) -> TimePoint {
        if lhs.uptimeNanoseconds == UInt64.max {
            return lhs
        }

        if rhs.nanoseconds < 0 {
            let lhsDiffFromMax = UInt64.max - lhs.uptimeNanoseconds
            let rhsMagnitude = rhs.nanoseconds.magnitude
            if lhsDiffFromMax < rhsMagnitude {
                return TimePoint.distantFuture
            }

            let nanoSeconds = UInt64(clamping: lhs.uptimeNanoseconds + rhsMagnitude)
            return TimePoint(uptimeNanoseconds: nanoSeconds)
        }

        if lhs.uptimeNanoseconds > rhs.nanoseconds {
            let nanoSeconds = lhs.uptimeNanoseconds - UInt64(rhs.nanoseconds)
            return TimePoint(uptimeNanoseconds: nanoSeconds)
        }

        return TimePoint(uptimeNanoseconds: 0)
    }

    public static func == (lhs: TimePoint, rhs: TimePoint) -> Bool {
        return lhs.uptimeNanoseconds == rhs.uptimeNanoseconds
    }

    public static func < (lhs: TimePoint, rhs: TimePoint) -> Bool {
        return lhs.uptimeNanoseconds < rhs.uptimeNanoseconds
    }

    public static func > (lhs: TimePoint, rhs: TimePoint) -> Bool {
        return lhs.uptimeNanoseconds > rhs.uptimeNanoseconds
    }

    /// Makes a TimePoint from a DispatchTime.
    ///
    /// - Parameter dispatchTime: The instance to convert
    /// - Returns: A TimePoint representation of the DispatchTime, if possible.
    public static func makeTimePoint(from dispatchTime: DispatchTime) -> TimePoint {
        return TimePoint(uptimeNanoseconds: dispatchTime.uptimeNanoseconds)
    }

    /// The number of nanoseconds since the machine was booted.
    public private(set) var uptimeNanoseconds: UInt64

    public init(uptimeNanoseconds: UInt64) {
        self.uptimeNanoseconds = uptimeNanoseconds
    }

    /// Makes a DispatchTime from this instance.
    public func makeDispatchTime() -> DispatchTime {
        return DispatchTime(uptimeNanoseconds: self.uptimeNanoseconds)
    }
}
