//
//  currencyXMLParserDelegate.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-19.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import Foundation

class CurrencyXMLParser: NSObject, XMLParserDelegate {
    private let currencyElementName = "str:Code"
    private let fullNameElementName = "com:Name"
    
    private var currencyList: [Currency]?
    private var completionBlock: (([Currency]) -> ())?
    private var currentTagName: String?
    private var id: String?
    private var fullName: String?
    private var parser: XMLParser?
    
    func retreveCurrencyList(from file: URL,
                             completion: @escaping ([Currency]) -> () )
    {
        completionBlock = completion
        parser = XMLParser(contentsOf: file)
        parser?.delegate = self
        parser?.parse()
    }
    
    public func parserDidStartDocument(_ parser: XMLParser)
    {
        currencyList = [Currency]()
    }
    
    public func parserDidEndDocument(_ parser: XMLParser)
    {
        guard let currencyList = currencyList else {
            fatalError("A fatal Error Occurred")
        }
        completionBlock!(currencyList)
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
