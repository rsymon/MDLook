/*
 *  FeedbackStub.swift
 *  Local feedback stub for MDLook.
 *
 *  This file replaces the upstream private feedback placeholder.
 */

import Foundation

func sendFeedback(_ feedback: String) -> URLSessionTask? {
    return nil
}

extension AppDelegate {

    internal func nuSendFeedback(_ feedback: String) async -> FeedbackError {
        return FeedbackError(code: .badSession, text: "Feedback is disabled in MDLook.")
    }
}
