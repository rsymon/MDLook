/*
 *  MDLookConfig.swift
 *  Local fork configuration.
 *
 *  This file replaces the upstream private codes placeholder.
 */

import Foundation

enum MDLookConfig {

    /*
     Replace this with your Apple Developer Team ID before enabling App Groups
     for a signed local build, for example: ABCDE12345.
     */
    static let developerTeamID = "TEAMID_PLACEHOLDER"

    static let appGroupSuffix = ".me.rsy42.mdlook"
    static let appGroupIdentifier = developerTeamID + appGroupSuffix
}

enum MNU_SECRETS {
    static let PID = MDLookConfig.developerTeamID
}
