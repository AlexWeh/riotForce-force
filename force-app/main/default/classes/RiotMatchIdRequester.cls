public with sharing class RiotMatchIdRequester {

    private static String RIOT_MATCH_ENDPOINT = '/lol/match/v4/matches/';
    private static String API_KEY = 'RGAPI-5b828344-d4e2-4f1e-a94d-1308f88e3c73'; 
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
            matchObject = new matchObject(Match);
            matchObject.initsObjects();
        }
        
        else {
            System.debug('Response Code:' + response.getStatusCode());
            System.debug(response.getBody());
        }
    }
}
