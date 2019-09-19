public with sharing class RiotJSON {
    public RiotJSON() {}

    public class Player {
		public String platformId;
		public String accountId;
		public String summonerName;
		public String summonerId;
		public String currentPlatformId;
		public String currentAccountId;
		public String matchHistoryUri;
		public Integer profileIcon;
	}

	public Long gameId;
	public String platformId;
	public Long gameCreation;
	public Integer gameDuration;
	public Integer queueId;
	public Integer mapId;
	public Integer seasonId;
	public String gameVersion;
	public String gameMode;
	public String gameType;
	public List<Team> teams;
	public List<Participant> participants;
	public List<ParticipantIdentities> participantIdentities;

	public class Participant {
		public Integer participantId;
		public Integer teamId;
		public Integer championId;
		public Integer spell1Id;
		public Integer spell2Id;
		public String highestAchievedSeasonTier;
		public Stats stats;
	}

	public class Stats {
		public Integer participantId;
		public Boolean win;
		public Integer item0;
		public Integer item1;
		public Integer item2;
		public Integer item3;
		public Integer item4;
		public Integer item5;
		public Integer item6;
		public Integer kills;
		public Integer deaths;
		public Integer assists;
		public Integer largestKillingSpree;
		public Integer largestMultiKill;
		public Integer killingSprees;
		public Integer longestTimeSpentLiving;
		public Integer doubleKills;
		public Integer tripleKills;
		public Integer quadraKills;
		public Integer pentaKills;
		public Integer unrealKills;
		public Integer totalDamageDealt;
		public Integer magicDamageDealt;
		public Integer physicalDamageDealt;
		public Integer trueDamageDealt;
		public Integer largestCriticalStrike;
		public Integer totalDamageDealtToChampions;
		public Integer magicDamageDealtToChampions;
		public Integer physicalDamageDealtToChampions;
		public Integer trueDamageDealtToChampions;
		public Integer totalHeal;
		public Integer totalUnitsHealed;
		public Integer damageSelfMitigated;
		public Integer damageDealtToObjectives;
		public Integer damageDealtToTurrets;
		public Integer visionScore;
		public Integer timeCCingOthers;
		public Integer totalDamageTaken;
		public Integer magicalDamageTaken;
		public Integer physicalDamageTaken;
		public Integer trueDamageTaken;
		public Integer goldEarned;
		public Integer goldSpent;
		public Integer turretKills;
		public Integer inhibitorKills;
		public Integer totalMinionsKilled;
		public Integer neutralMinionsKilled;
		public Integer neutralMinionsKilledTeamJungle;
		public Integer neutralMinionsKilledEnemyJungle;
		public Integer totalTimeCrowdControlDealt;
		public Integer champLevel;
		public Integer visionWardsBoughtInGame;
		public Integer sightWardsBoughtInGame;
		public Integer wardsPlaced;
		public Integer wardsKilled;
		public Boolean firstBloodKill;
		public Boolean firstBloodAssist;
		public Boolean firstTowerKill;
		public Boolean firstTowerAssist;
		public Boolean firstInhibitorKill;
		public Boolean firstInhibitorAssist;
		public Integer combatPlayerScore;
		public Integer objectivePlayerScore;
		public Integer totalPlayerScore;
		public Integer totalScoreRank;
		public Integer playerScore0;
		public Integer playerScore1;
		public Integer playerScore2;
		public Integer playerScore3;
		public Integer playerScore4;
		public Integer playerScore5;
		public Integer playerScore6;
		public Integer playerScore7;
		public Integer playerScore8;
		public Integer playerScore9;
		public Integer perk0;
		public Integer perk0Var1;
		public Integer perk0Var2;
		public Integer perk0Var3;
		public Integer perk1;
		public Integer perk1Var1;
		public Integer perk1Var2;
		public Integer perk1Var3;
		public Integer perk2;
		public Integer perk2Var1;
		public Integer perk2Var2;
		public Integer perk2Var3;
		public Integer perk3;
		public Integer perk3Var1;
		public Integer perk3Var2;
		public Integer perk3Var3;
		public Integer perk4;
		public Integer perk4Var1;
		public Integer perk4Var2;
		public Integer perk4Var3;
		public Integer perk5;
		public Integer perk5Var1;
		public Integer perk5Var2;
		public Integer perk5Var3;
		public Integer perkPrimaryStyle;
		public Integer perkSubStyle;
		public Integer statPerk0;
		public Integer statPerk1;
		public Integer statPerk2;
	}

	public class Team {
		public Integer teamId;
		public String win;
		public Boolean firstBlood;
		public Boolean firstTower;
		public Boolean firstInhibitor;
		public Boolean firstBaron;
		public Boolean firstDragon;
		public Boolean firstRiftHerald;
		public Integer towerKills;
		public Integer inhibitorKills;
		public Integer baronKills;
		public Integer dragonKills;
		public Integer vilemawKills;
		public Integer riftHeraldKills;
		public Integer dominionVictoryScore;
		public List<Bans> bans;
	}

	public class Bans {
		public Integer championId;
		public Integer pickTurn;
	}

	public class ParticipantIdentities {
		public Integer participantId;
		public Player player;
	}

	public static RiotJSON parse(String json) {
		return (RiotJSON) System.JSON.deserialize(json, RiotJSON.class);
	}
}
