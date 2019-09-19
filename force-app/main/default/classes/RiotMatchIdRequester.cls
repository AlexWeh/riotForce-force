public with sharing class RiotMatchIdRequester {

    private static String RIOT_MATCH_ENDPOINT = '/lol/match/v4/matches/';
    private static String API_KEY = 'RGAPI-a3ee7775-25e6-4fc1-90e8-b86523d07c5e'; 
    private RiotJSON Match;
    private RiotMatchObjectParser matchObject;

    public RiotMatchIdRequester() {}

    public void makeRequest(String matchId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:RiotApiKey' + RIOT_MATCH_ENDPOINT + matchId + '?api_key=' + API_KEY);
        request.setMethod('GET');
        //request.setHeader('X-Riot-Token','{!$Credential.Password}');
        System.debug(request.getEndpoint());
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200){
            Match = (RiotJSON) JSON.deserialize(response.getBody(), RiotJSON.class);
            matchObject = new RiotMatchObjectParser(Match);
            matchObject.initObjects();
        }

        else {
            System.debug('Response Code:' + response.getStatusCode());
            System.debug(response.getBody());
        }
    }
}
