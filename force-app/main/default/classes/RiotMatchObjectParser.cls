public with sharing class RiotMatchObjectParser {
    private RiotJSON Match;
    public Match__c riotMatch;
    public List<Player__c> playerList;
    public List<Participant__c> participantList;
    public Team__c blueTeam;
    public Team__c redTeam;

    public RiotMatchObjectParser(RiotJSON Match) {
        this.Match = Match;
    }

    public void initObjects() {
        createTeam();
        createMatch();
        createPlayer();
        createParticipant();
        System.debug('Ende');
    }

    public void createMatch() {
        List<Match__c> existingMatches = [SELECT Id, Name FROM Match__c];
        List<String> existingMatchNames = new List<String>();

        for (Match__c match : existingMatches) {
            existingMatchNames.add(match.Name);
        }

        if (!existingMatchNames.contains(String.valueOf(Match.gameId))) {
            riotMatch = new Match__c(Name = String.valueOf(Match.gameId));

            riotMatch.Creation_Time__c = DateTime.newInstance(
                Match.gameCreation
            );
            riotMatch.Season__c = String.valueOf(Match.seasonId);
            riotMatch.Mode__c = String.valueOf(Match.gameMode);
            riotMatch.Queue__c = String.valueOf(Match.queueId);
            riotMatch.Map__c = String.valueOf(Match.mapId);
            riotMatch.Duration__c = Match.gameDuration;
            riotMatch.Platform__c = Match.platformId;
            riotMatch.Version__c = Match.gameVersion;
            riotMatch.Type__c = Match.gameType;
            riotMatch.Blue_Team__c = blueTeam.Id;
            insertMatch(riotMatch);
        } else {
            System.debug('Match: ' + Match.gameId + ' already exists.');
        }
    }

    public void insertMatch(Match__c match) {
        System.Savepoint sp = Database.setSavePoint();

        try {
            insert match;
        } catch (DMLException e) {
            System.debug(e);
            Database.rollback(sp);
        }
    }

    public void createPlayer() {
        Integer counter = 0;
        playerList = new List<Player__c>();
        List<Player__c> existingPlayers = [
            SELECT Id, Summoner_ID__c
            FROM Player__c
        ];
        List<String> existingPlayerIds = new List<String>();

        for (Player__c player : existingPlayers) {
            existingPlayerIds.add(player.Summoner_ID__c);
        }

        for (RiotJSON.ParticipantIdentities idPlayer : Match.participantIdentities) {
            if (!existingPlayerIds.contains(idPlayer.player.summonerId)) {
                Player__c riotPlayer = new Player__c(
                    Name = idPlayer.player.summonerName
                );

                riotPlayer.Profile_Icon_ID__c = idPlayer.player.profileIcon;
                riotPlayer.Summoner_ID__c = idPlayer.player.summonerId;
                riotPlayer.Account_ID__c = idPlayer.player.accountId;
                riotPlayer.Platform__c = idPlayer.player.platformId;
                playerList.add(riotPlayer);
            } else {
                playerList.add(existingPlayers[counter]);
                //System.debug('Player: ' + idPlayer.player.summonerName + ', ' + idPlayer.player.summonerId + ' already exists.');
            }
            counter++;
        }
        insertPlayer(playerList);
    }

    public void insertPlayer(List<Player__c> playerList) {
        System.Savepoint sp = Database.setSavePoint();

        try {
            insert playerList;
        } catch (DMLException e) {
            System.debug(e);
            Database.rollback(sp);
        }
    }

    public void createTeam() {
        blueTeam = new Team__c(Team__c = 'Blue');
        redTeam = new Team__c(Team__c = 'Red');

        if (Match.teams[0].win == 'Win') {
            blueTeam.Win__c = true;
            blueTeam.Win__c = false;
        }else if (Match.teams[0].win == 'Fail') {
            blueTeam.Win__c = false;
            blueTeam.Win__c = true;
        }
        

        insertTeams(blueTeam, redTeam);
    }

    public void insertTeams(Team__c blueTeam, Team__c redTeam){
        List<Team__c> tempTeams = new List<Team__c>();
        System.Savepoint sp = Database.setSavePoint();

        try {
            insert tempTeams;
        } catch (DMLException e) {
            System.debug(e);
            Database.rollback(sp);
        }
	} 

    public void createParticipant() {
        Integer counter = 0;
        participantList = new List<Participant__c>();
        for (RiotJson.Participant participant : Match.participants) {

            Participant__c riotParticipant = new Participant__c(
                Participant_ID__c = String.valueOf(participant.participantId)
            );
            riotParticipant.Spell_1__c = String.valueOf(participant.spell1Id);
            riotParticipant.Spell_2__c = String.valueOf(participant.spell2Id);
            riotParticipant.Player__c = playerList[counter].Id;
            if (participant.teamId == 100) {
                riotParticipant.Team__c = blueTeam.Id;
            }else {
                riotParticipant.Team__c = redTeam.Id;
            }
            counter ++;
        }
        insertParticipant(participantList);
    }

    public void insertParticipant(List<Participant__c> participantList){
        System.Savepoint sp = Database.setSavePoint();

        try {
            insert participantList;
        } catch (DMLException e) {
            System.debug(e);
            Database.rollback(sp);
        }
	} 

    public void createChampion() {
    }

	
}