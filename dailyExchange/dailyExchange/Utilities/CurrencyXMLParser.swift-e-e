//
//  currencyXMLParserDelegate.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-19.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import Foundation

class CurrencyXMLParser: NSObject {
    private var parser: XMLParser?
    private var currencyListParserDelegate: CurrencyListParserDelegate?
    private var currencyValueParserDelegate: latestExchangeRateParserDelegate?
    
    func retreveCurrencyList(from file: URL,
                             completion: @escaping ([Currency]) -> () )
    {
        parser = XMLParser(contentsOf: file)
        currencyListParserDelegate = CurrencyListParserDelegate(with: completion)
        parser?.delegate = currencyListParserDelegate
        parser?.parse()
    }
    
    func retreveCurrencyValue(from data: Data, completion: @escaping (String) -> ()) {
        parser = XMLParser(data: data)
        currencyValueParserDelegate = latestExchangeRateParserDelegate(with: completion)
        parser?.delegate = currencyValueParserDelegate
        parser?.parse()
    }
}

class CurrencyListParserDelegate: NSObject, XMLParserDelegate {
    private let currencyElementName = "str:Code"
    private let fullNameElementName = "com:Name"
    
    private var currentTagName: String?
    private var fullName: String?
    private var id: String?
    
    private let completionHandler: (([Currency]) -> ())
    private var currencyList: [Currency]?
    
    init(with completionHandler: @escaping ([Currency]) -> ()) {
        self.completionHandler = completionHandler
        super.init()
    }
    
    public func parserDidStartDocument(_ parser: XMLParser)
    {
        currencyList = [Currency]()
    }
    
    public func parserDidEndDocument(_ parser: XMLParser)
    {
        completionHandler(currencyList ?? [Currency]())
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentTagName = elementName
        guard elementName == currencyElementName else
        {
            return
        }
        
        fullName = "" // reset fullName field
        
        // assign id
        let rawID = attributeDict["id"]
        
        if rawID != nil,
            rawID!.rangeOfCharacter(from: .decimalDigits) == nil,
            rawID!.trimmingCharacters(in: .whitespacesAndNewlines).count == 3
        {
            id = rawID!.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            id = nil
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let fullName = fullName,
            currentTagName == fullNameElementName
        {
            self.fullName = fullName + string
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        guard let fullName = fullName,
            let id = id,
            elementName == currencyElementName else
        {
            return
        }
        
        let currency = Currency(fullName: fullName.trimmingCharacters(in: .whitespacesAndNewlines), abriviation: id)
        currencyList?.append(currency)
    }
}

class latestExchangeRateParserDelegate: NSObject, XMLParserDelegate {
    private let currencyValueElementName = "generic:ObsValue"
    private var currencyValue: String?
    private let completionHandler: ((String) -> ())
    
    init(with completionHandler: @escaping (String) -> ()) {
        self.completionHandler = completionHandler
        super.init()
    }
    
    public func parserDidStartDocument(_ parser: XMLParser)
    {
       currencyValue = nil
    }
    
    public func parserDidEndDocument(_ parser: XMLParser)
    {
        completionHandler(currencyValue ?? "")
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        guard elementName == currencyValueElementName,
            let currencyValue = attributeDict["value"] else {
                return
        }
        self.currencyValue = currencyValue
    }
}


