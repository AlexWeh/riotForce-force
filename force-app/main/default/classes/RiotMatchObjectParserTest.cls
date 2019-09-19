@isTest
public with sharing class RiotMatchObjectParserTest {
    public RiotMatchObjectParserTest() {
        StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'RiotMatchMock' LIMIT 1];
        String body = sr.Body.toString();
        RiotJSON match = createRiotJson(body);
        RiotMatchObjectParser parser = new RiotMatchObjectParser(match);
    }

	public RiotJSON createRiotJson(String body){
        RiotJSON Match = (RiotJSON) JSON.deserialize(body, RiotJSON.class);
		return Match;
	}
}
