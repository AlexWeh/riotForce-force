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

    public void createMatch(){
        String name = String.valueOf(Match.gameId);
        DateTime gameCreationTime = DateTime.newInstance(Match.gameCreation);
        String mapIdString = String.valueOf(Match.mapId);
        String gameModeString = String.valueOf(Match.gameMode);
        String queueIdString = String.valueOf(Match.queueId);
        String seasonIdString = String.valueOf(Match.seasonId);

        Match__c riotMatch =  new Match__c(Name = name);
        
        riotMatch.Creation_Time__c = gameCreationTime;
        riotMatch.Duration__c = Match.gameDuration;
        riotMatch.Map__c = mapIdString;
        riotMatch.Mode__c = gameModeString;
        riotMatch.Platform__c = Match.platformId;
        riotMatch.Queue__c = queueIdString;
        riotMatch.Season__c = seasonIdString;
        riotMatch.Type__c = Match.gameType;
        riotMatch.Version__c = Match.gameVersion;
    }

    public void createPlayer(){
        List<Player__c> playerList = new List<Player__c>();
        for (RiotJSON.ParticipantIdentities idPlayer : Match.participantIdentities) {
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
