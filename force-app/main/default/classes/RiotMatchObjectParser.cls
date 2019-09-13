public with sharing class RiotMatchObjectParser {

private RiotJSON Match;

    public RiotMatchObjectParser(RiotJSON Match) {
        this.Match = Match;
    }

    public void initsObject(){
        createMatch();
        createPlayer();
        createParticipant();
        createTeam();
    }

    public Match__c createMatch(){
        Match__c riotMatch =  new Match__c(Name = Match.gameId.toString());
        
        riotMatch.Creation_Time__c = Match.gameCreation;
        riotMatch.Durcation__c = Match.gameDuration;
        riotMatch.Map__c = Match.mapId;
        riotMatch.Mode__c = Match.gameMode;
        riotMatch.Platform__c = Match.platformId;
        riotMatch.Queue__c = Match.queueId;
        riotMatch.Season__c = Match.seasonId;
        riotMatch.Type__c = Match.gameType;
        riotMatch.Version__c = Match.gameVersion;
    }

    public void createPlayer(){
        List<Player__c> playerList = new List<Player__c>();
        for (Match.ParticipantIdentities idPlayer : Match.participantIdentities) {
            Player__c riotPlayer = new Player__c(Name = idPlayer.player.summonerName);
            riotPlayer.Account_ID__c = idPlayer.player.accountId;
            riotPlayer.Platform__c = idPlayer.player.platformId;
            riotPlayer.Profile_Icon_ID__c = idPlayer.player.profileIcon;
            riotPlayer.Summoner_ID__c = idPlayer.player.summonerId;
            playerList.add(riotPlayer);
        }
    }

    public void createParticipant(){

    }

    public void createTeam(){

    }

    public void createChampion(){

    }
}
