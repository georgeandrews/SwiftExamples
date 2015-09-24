//
//  UrlMetrics.swift
//  iMoz
//
//  Created by George Andrews on 7/15/15.
//  Copyright (c) 2015 CVTC Mobile Developer Program. All rights reserved.
//

import Foundation

class UrlMetrics {
    
    static let responseFields: [String: String] = [
        "ut": "Title",
        "uu": "Canonical URL",
        "ufq": "Subdomain",
        "upl": "RootDomain",
        "ueid": "External Equity Links",
        "feid": "Subdomain External Links",
        "peid": "Root Domain External Links",
        "ujid": "Equity Links",
        "uifq": "Subdomains Linking",
        "uipl": "Root Domains Linking",
        "uid": "Links",
        "fid": "Subdomain, Subdomains Linking",
        "pid": "Root Domain, Root Domains Linking",
        "umrp": "MozRank: URL",
        "fmrp": "MozRank: Subdomain",
        "pmrp": "MozRank: Root Domain",
        "utrp": "MozTrust",
        "ftrp": "MozRank: Subdomain",
        "ptrp": "MozRank: Root Domain",
        "uemrp": "MozRank: External Equity",
        "fejp": "MozRank: Subdomain, External Equity",
        "pejp": "MozRank: Root Domain, External Equity",
        "pjp": "MozRank: Subdomain Combined",
        "fjp": "MozRank: Root Domain Combined",
        "fspsc": "Subdomain Spam Score",
        "fspf": "Bit field of triggered spam flags",
        "flan": "Language of subdomain",
        "fsps": "HTTP status code of the spam crawl",
        "jsplc": "Epoch time when subdomain last crawled",
        "fspp": "List of pages used for subdomain's spam crawl",
        "ffb": "Facebook account",
        "ftw": "Twitter handle",
        "fg+": "Google+ account",
        "fem": "Email address",
        "us": "HTTP Status Code",
        "fuid": "Links to Subdomain",
        "puid": "Links to Root Domain",
        "fipl": "Root Domains Linking to Subdomain",
        "upa": "Page Authority",
        "pda": "Domain Authority",
        "ued": "External Links",
        "fed": "External links to subdomain",
        "ped": "External links to root domain",
        "pib": "Linking C Blocks",
        "ulc": "Time last crawled"
    ]
    
}

enum ResponseField: String {
    
    case uu = "uu", umrp = "umrp", utrp = "utrp", fspsc = "fspsc", upa = "upa", pda = "pda", ueid = "ueid"
    
    static let stringValues = [uu.rawValue, umrp.rawValue, utrp.rawValue, fspsc.rawValue, upa.rawValue, pda.rawValue, ueid.rawValue]
    
}