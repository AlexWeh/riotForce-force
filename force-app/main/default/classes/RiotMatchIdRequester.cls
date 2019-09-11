public with sharing class RiotMatchIdRequester {

    private static String RIOT_MATCH_ENDPOINT = '/lol/match/v4/matches/';

    public RiotMatchIdRequester() {}

    public void makeRequest(String Id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:RiotApiKey' + RIOT_MATCH_ENDPOINT);
        request.setMethod('GET');
        request.setHeader('X-Riot-Token','{!$Credential.Password}');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200){
            response.getBody();
        }
    }
}
