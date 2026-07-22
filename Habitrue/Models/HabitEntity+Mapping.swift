//
//  HabitEntity+Mapping.swift
//  Habitrue
//
//  Created by Project on 21/07/26.
//

import SwiftUI
import CoreData

extension HabitEntity {
    func toHabit() -> Habit {
        Habit(
            id: id ?? UUID(),
            title: title ?? "",
            subtitleLocalized: subtitleLocalized ?? "",
            emoji: emoji ?? "🎯",
            prompt: prompt ?? "",
            frequency: HabitFrequency(raw: frequencyRaw ?? "daily", timesPerWeek: Int(timesPerWeekValue)),
            color: Color(hex: colorHex ?? "007AFF"),
            isDone: isDone
        )
    }

    func update(from habit: Habit) {
        id = habit.id
        title = habit.title
        subtitleLocalized = habit.subtitleLocalized
        emoji = habit.emoji
        prompt = habit.prompt
        frequencyRaw = habit.frequency.rawKey
        timesPerWeekValue = Int16(habit.frequency.timesPerWeekValue)
        colorHex = habit.color.hexString
        isDone = habit.isDone
        if createdAt == nil { createdAt = Date() }
    }
}
