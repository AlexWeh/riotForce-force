public with sharing class RiotMatchObjectParser {
    private RiotJSON Match;
    public Match__c riotMatch;
    public List<Player__c> playerList;
    public List<Player__c> playersToInsert;
    public List<Participant__c> participantList;
    public Team__c blueTeam;
    public Team__c redTeam;
    public List<Champion__c> championList;
    public List<String> championIds;


    public RiotMatchObjectParser(RiotJSON Match) {
        this.Match = Match;
    }

    public void initObjects() {
        championList = [SELECT Id, Name, Champion_ID__c FROM Champion__c];
        championIds = new List<String>();
        for (Champion__c champ : championList) {
            championIds.add(champ.id);
        }
        List<Match__c> existingMatches = [SELECT Id, Name FROM Match__c];
        List<String> existingMatchNames = new List<String>();
        for (Match__c match : existingMatches) {
            existingMatchNames.add(match.Name);
        }

        if (!existingMatchNames.contains(String.valueOf(Match.gameId))) {
            createTeam();
            createMatch();
            createPlayer();
            createParticipant();
        } else {
            System.debug('Match: ' + Match.gameId + ' already exists.');
        }
    }

    public void createMatch() {
        riotMatch = new Match__c(Name = String.valueOf(Match.gameId));

        riotMatch.Creation_Time__c = DateTime.newInstance(Match.gameCreation);
        riotMatch.Season__c = String.valueOf(Match.seasonId);
        riotMatch.Mode__c = String.valueOf(Match.gameMode);
        riotMatch.Queue__c = String.valueOf(Match.queueId);
        riotMatch.Map__c = String.valueOf(Match.mapId);
        riotMatch.Duration__c = Match.gameDuration;
        riotMatch.Platform__c = Match.platformId;
        riotMatch.Version__c = Match.gameVersion;
        riotMatch.Blue_Team__c = blueTeam.Id;
        riotMatch.Red_Team__c = redTeam.Id;
        riotMatch.Type__c = Match.gameType;
        riotMatch.Status__c = 'Game Finished';
        insertMatch(riotMatch);
    }

    public void insertMatch(Match__c match) {
        System.Savepoint sp = Database.setSavePoint();

        try {
            insert match;
        } catch (DMLException e) {
            System.debug(e);
            Database.rollback(sp);
        }

        System.debug('Created Match with Id: ' + match.Id);
    }

    public void createPlayer() {
        playerList = new List<Player__c>();
        playersToInsert = new List<Player__c>();

        List<Player__c> existingPlayers = [SELECT Id, Name, Summoner_ID__c FROM Player__c];
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
                playersToInsert.add(riotPlayer);
            } else {
                playerList.add(existingPlayers[existingPlayerIds.indexOf(idPlayer.player.summonerId)]);
            }
        }
        insertPlayer(playersToInsert);
    }

    public void insertPlayer(List<Player__c> playersToInsert) {
        Integer insertedPlayerPointer = 0;
        System.Savepoint sp = Database.setSavePoint();
        List<Database.SaveResult> saveResult = new List<Database.SaveResult>();

        try {
            saveResult = Database.insert(playersToInsert, false) ;
        } catch (DMLException e) {
            System.debug(e);
            Database.rollback(sp);
        }

        for (Player__c player : playerList) {
            System.debug(
                'Created or Added Player with Id: ' +
                player.Id +
                ' and Name: ' +
                player.Name
            );
        }

        for (Integer i = 0; i < playerList.size(); i++) {
            if (playersToInsert.contains(playerList[i])) {
                playerList[i] = playersToInsert[playersToInsert.indexOf(playerList[i])];
            }
        }

        for (Player__c player : playerList) {
            System.debug(
                'Created or Added Player with Id: ' +
                player.Id +
                ' and Name: ' +
                player.Name
            );
        }
    }

    public void createTeam() {
        List<Team__c> teamList = new List<Team__c>();
        List<Integer> pickTurnList = new List<Integer>();
        /*List<String> bannedChampionFields = new List<String>{
            'Banned_Champion_1__c',
            'Banned_Champion_2__c',
            'Banned_Champion_3__c',
            'Banned_Champion_4__c',
            'Banned_Champion_5__c',
            'Banned_Champion_6__c',
            'Banned_Champion_7__c',
            'Banned_Champion_8__c',
            'Banned_Champion_9__c',
            'Banned_Champion_10__c'
        };
        List<Integer> championBans = new List<Integer>();

        for (Integer i = 0; i < 10; i++) {
            championBans.add(null);
        }*/

        blueTeam = new Team__c(
            RecordTypeId =
                Schema.SObjectType.Team__c.getRecordTypeInfosByDeveloperName()
                    .get('Blue')
                    .getRecordTypeId()
        );
        redTeam = new Team__c(
            RecordTypeId =
                Schema.SObjectType.Team__c.getRecordTypeInfosByDeveloperName()
                    .get('Red')
                    .getRecordTypeId()
        );

        teamList.add(blueTeam);
        teamList.add(redTeam);

        if (Match.teams[0].win == 'Win') {
            blueTeam.Win__c = true;
            redTeam.Win__c = false;
        } else if (Match.teams[0].win == 'Fail') {
            blueTeam.Win__c = false;
            redTeam.Win__c = true;
        }

        for (Integer i = 0; i < Match.teams.size(); i++) {
            teamList[i].First_Blood__c = Match.teams[i].firstBlood;
            teamList[i].First_Tower__c = Match.teams[i].firstTower;
            teamList[i].First_Inhibitor__c = Match.teams[i].firstInhibitor;
            teamList[i].First_Baron__c = Match.teams[i].firstBaron;
            teamList[i].First_Dragon__c = Match.teams[i].firstDragon;
            teamList[i].First_Rift_Heral__c = Match.teams[i].firstRiftHerald;
            teamList[i].Tower_Kills__c = Match.teams[i].towerKills;
            teamList[i].Inhibitor_Kills__c = Match.teams[i].inhibitorKills;
            teamList[i].Baron_Kills__c = Match.teams[i].baronKills;
            teamList[i].Dragon_Kills__c = Match.teams[i].dragonKills;
            teamList[i].Vilemaw_Kills__c = Match.teams[i].vilemawKills;
            teamList[i].Rift_Herald_Kills__c = Match.teams[i].riftHeraldKills;
            teamList[i].Dominion_Victory_Score__c = Match.teams[i].dominionVictoryScore;
            /*for (RiotJSON.Bans ban : Match.teams[0].bans) {
                championBans.set(ban.pickTurn, ban.championId);
            }*/
        }

        /*for (Integer j = 0; j < 10; j++) {
            if (j < 5) {
                blueTeam.put(
                    bannedChampionFields[j],
                    findChampionId(championBans[j])
                );
            } else {
                redTeam.put(
                    bannedChampionFields[j],
                    findChampionId(championBans[j])
                );
            }
        }*/

        insertTeams(teamList);
    }

    /*public Id findChampionId(Integer id) {
        for (Champion__c champ : championList) {
            if (champ.Champion_ID__c == id) {
                return champ.id;
            }
        }
        return null;
    }*/

    public void insertTeams(List<Team__c> teamList) {
        System.Savepoint sp = Database.setSavePoint();

        try {
            insert teamList;
        } catch (DMLException e) {
            System.debug(e);
            Database.rollback(sp);
        }
        System.debug('Created Blue & Red Team');
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
            } else {
                riotParticipant.Team__c = redTeam.Id;
            }
            participantList.add(riotParticipant);
            counter++;
        }
        insertParticipant(participantList);
    }

    public void insertParticipant(List<Participant__c> participantList) {
        System.Savepoint sp = Database.setSavePoint();

        try {
            insert participantList;
        } catch (DMLException e) {
            System.debug(e);
            Database.rollback(sp);
        }
        for (Participant__c participant : participantList) {
            System.debug('Created Participant with Id: ' + participant.Id);
        }
    }

    public void createChampion() {
    }
}
