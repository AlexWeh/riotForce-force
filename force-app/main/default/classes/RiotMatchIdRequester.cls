public with sharing class RiotMatchIdRequester {
    public RiotMatchIdRequester() {}

    @AuraEnabled
    public static String makeRequest(String matchId, String userID){
        String RIOT_MATCH_ENDPOINT = '/lol/match/v4/matches/';
        RiotJSON Match;
        RiotMatchObjectParser matchObject;
        System.debug('ID: ' + userID);
        String API_Key = '';
        API_Key = [SELECT Id, API_Key__c FROM User WHERE Id=:userID LIMIT 1].API_Key__c;
        System.debug('API Key: ' + API_Key);
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:RiotApiKey' + RIOT_MATCH_ENDPOINT + matchId + '?api_key=' + API_Key);
        request.setMethod('GET');
        //request.setHeader('X-Riot-Token','{!$Credential.Password}');
        System.debug(request.getEndpoint());
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200){
            Match = (RiotJSON) JSON.deserialize(response.getBody(), RiotJSON.class);
            matchObject = new RiotMatchObjectParser(Match);
            matchObject.initObjects();
            return response.toString() + ' success';
        }

        else {
            System.debug('Response Code:' + response.getStatusCode());
            System.debug(response.getBody());
            return response.toString() + ' error';
        }
    }
}
