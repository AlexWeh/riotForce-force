public with sharing class RiotMatchIdRequester {
    public RiotMatchIdRequester() {}

    @AuraEnabled
    public static String makeRequest(String matchId, String key){
        String RIOT_MATCH_ENDPOINT = '/lol/match/v4/matches/';
        String API_KEY = 'RGAPI-c338eab5-0531-4ff6-84cd-93a945ad6950'; 
        RiotJSON Match;
        RiotMatchObjectParser matchObject;

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:RiotApiKey' + RIOT_MATCH_ENDPOINT + matchId + '?api_key=' + key);
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
