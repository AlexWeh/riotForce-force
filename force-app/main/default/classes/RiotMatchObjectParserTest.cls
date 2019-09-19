@isTest
public with sharing class RiotMatchObjectParserTest {
    public RiotMatchObjectParserTest() {
    }

    @isTest
    public static void test(){
        StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'RiotMatchMock' LIMIT 1];
        RiotJSON match = (RiotJSON) JSON.deserialize(sr.Body.toString(), RiotJSON.class);
        RiotMatchObjectParser parser = new RiotMatchObjectParser(match);
        parser.initObjects();
    }
}
