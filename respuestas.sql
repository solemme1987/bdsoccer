-- 1. Write a query in SQL to find the number of venues for EURO cup 2016.
SELECT count(venue_id) FROM soccer_venue;
+-----------------+
| count(venue_id) |
+-----------------+
|              10 |
+-----------------+


-- 2.Write a query in SQL to find the number goals scored in EURO cup 2016 within normal play Schedule

select count(goal_type) from goal_details where goal_type="N";
+----------------+
| count(goal_id) |
+----------------+
|             97 |
+----------------+

-- 3 Write a query in SQL to find the number of matches ended with draws.

select  count(results) from match_mast where results="DRAW";
+----------------+
| count(results) |
+----------------+
|             11 |
+----------------+

-- 4 Write a query in SQL to find the number of self-goals scored in EURO cup 2016. 
select count(goal_type) from goal_details where goal_type='O';
+------------------+
| count(goal_type) |
+------------------+
|                3 |
+------------------+

-- 5 Write a query in SQL to count the number of matches ended with a results in group stage.
select  count(play_stage) from match_mast where play_stage="G";
+-------------------+
| count(play_stage) |
+-------------------+
|                36 |
+-------------------+


-- 6  Write a query in SQL to find the number of matches were decided on penalties in the Round of 16
SELECT  count(decided_by) from match_mast where decided_by ='P' AND   play_stage ='R';
+-------------------+
| count(decided_by) |
+-------------------+
|                 1 |
+-------------------+

-- 7  Write a query in SQL to find the match no, date of play, and goal scored for that match in which no stoppage time have been added in 1st half of play. 
SELECT  match_no ,play_date, goal_score , stop1_sec from match_mast where stop1_sec=0;
+----------+------------+------------+-----------+
| match_no | play_date  | goal_score | stop1_sec |
+----------+------------+------------+-----------+
|        4 | 2016-06-12 | 1-1        |         0 |
+----------+------------+------------+-----------+

-- 8 Write a query in SQL to find the number of matches ending with only one goal win except those matches which was decided by penalty shootout. 
select count(match_no) from match_mast where  goal_score='1-0' OR goal_score='0-1' AND decided_by !='P';
+-----------------+
| count(match_no) |
+-----------------+
|              13 |
+-----------------+


-- 9 Write a query in SQL to find the total number of palyers replaced within normal time of play.
select count(in_out) from player_in_out where  play_schedule='NT' and in_out='O';
+---------------+
| count(in_out) |
+---------------+
|           275 |
+---------------+

-- 10 Write a query in SQL to find the number of penalty shots taken by the teams.
 SELECT  team_id, count(team_id), sum(kick_no)from  penalty_shootout group by (team_id);
+---------+----------------+--------------+
| team_id | count(team_id) | sum(kick_no) |
+---------+----------------+--------------+
|    1208 |              9 |           90 |
|    1211 |              9 |           81 |
|    1213 |              9 |           50 |
|    1214 |              5 |           25 |
|    1221 |              5 |           25 |
+---------+----------------+--------------+

 SELECT  team_id Equipo, sum(kick_no) Total from  penalty_shootout group by (team_id);
+--------+-------+
| Equipo | Total |
+--------+-------+
|   1208 |    90 |
|   1211 |    81 |
|   1213 |    50 |
|   1214 |    25 |
|   1221 |    25 |
+--------+-------+

-- 11 Write a query in SQL to find the winner of EURO cup 2016. 
 SELECT soccer_country.country_name Pais_campeon
 FROM match_details
 INNER JOIN  soccer_country ON soccer_country.country_id = match_details.team_id
 WHERE  match_details.play_stage='F'
 AND match_details.win_loos='w';
+--------------+
| Pais_campeon |
+--------------+
| Portugal     |
+--------------+


-- 12 Write a query in SQL to find the match no in which Germany played against Poland
 SELECT match_no
 FROM match_details
 INNER JOIN  soccer_country ON match_details.team_id = soccer_country.country_id
 WHERE  soccer_country.country_name='Germany' or soccer_country.country_name='Poland'
 GROUP BY match_no
 HAVING COUNT(DISTINCT team_id)=2;
+----------+
| match_no |
+----------+
|       18 |
+----------+

SELECT match_no
FROM match_details
WHERE team_id=(
SELECT country_id
FROM soccer_country
WHERE country_name='Germany')
OR team_id=(
SELECT country_id
FROM soccer_country
WHERE country_name='Poland')
GROUP BY match_no
HAVING COUNT(DISTINCT team_id)=2;

-- 13 Write a query in SQL to display the list of players scored number of goals in every matches.

SELECT player_name Jugador, count(goal_id) Goles
FROM goal_details 
JOIN  player_mast ON  goal_details.player_id=player_mast.player_id
GROUP BY (player_name);
+-----------------------+-------+
| Jugador               | Goles |
+-----------------------+-------+
| ArmandoSadiku         |     1 |
| AlessandroSchopf      |     1 |
| RomeluLukaku          |     2 |
| AxelWitsel            |     1 |
| RadjaNainggolan       |     2 |
| TobyAlderweireld      |     1 |
| MichyBatshuayi        |     1 |
| EdenHazard            |     1 |
| YannickCarrasco       |     1 |
| LukaModric            |     1 |
| IvanPeriSic           |     2 |
| IvanRakitic           |     1 |
| NikolaKalinic         |     1 |
| MilanSkoda            |     1 |
| TomasNecid            |     1 |
| EricDier              |     1 |
| JamieVardy            |     1 |
| DanielSturridge       |     1 |
| WayneRooney           |     1 |
| OlivierGiroud         |     3 |
| DimitriPayet          |     3 |
| AntoineGriezmann      |     6 |
| PaulPogba             |     1 |
| ThomasMuller          |     1 |
| BastianSchweinsteiger |     1 |
| MarioGomez            |     2 |
| JeromeBoateng         |     1 |
| JulianDraxler         |     1 |
| Mesutozil             |     1 |
| AdamSzalai            |     1 |
| ZoltanStieber         |     1 |
| ZoltanGera            |     1 |
| BalazsDzsudzsak       |     2 |
| BirkirBjarnason       |     2 |
| GylfiSigurdsson       |     1 |
| BirkirSaevarsson      |     1 |
| JonDadiBodvarsson     |     2 |
| ArnorIngviTraustason  |     1 |
| KolbeinnSigthorsson   |     2 |
| EmanueleGiaccherini   |     1 |
| GrazianoPelle         |     2 |
| Eder                  |     2 |
| GiorgioChiellini      |     1 |
| LeonardoBonucci       |     1 |
| GarethMcAuley         |     2 |
| NiallMcGinn           |     1 |
| ArkadiuszMilik        |     1 |
| JakubBlaszczykowski   |     2 |
| RobertLewandowski     |     1 |
| Nani                  |     3 |
| CristianoRonaldo      |     3 |
| RicardoQuaresma       |     1 |
| RenatoSanches         |     1 |
| WesHoolahan           |     1 |
| CiaranClark           |     1 |
| RobbieBrady           |     2 |
| BogdanStancu          |     2 |
| VasiliBerezutski      |     1 |
| DenisGlushakov        |     1 |
| OndrejDuda            |     1 |
| VladimirWeiss         |     1 |
| MarekHamsik           |     1 |
| GerardPique           |     1 |
| AlvaroMorata          |     3 |
| Nolito                |     1 |
| FabianSchar           |     1 |
| AdmirMehmedi          |     1 |
| XherdanShaqiri        |     1 |
| BurakYilmaz           |     1 |
| OzanTufan             |     1 |
| GarethBale            |     3 |
| HalRobson-Kanu        |     2 |
| AaronRamsey           |     1 |
| NeilTaylor            |     1 |
| AshleyWilliams        |     1 |
| SamVokes              |     1 |
+-----------------------+-------+

 
-- 14 Write a query in SQL to find the goalkeeper of the team Germany who didn't concede any goal in their group stage matches.
SELECT  player_name Arquero, goal_score Goles_recibidos, play_stage Etapa
FROM match_details
JOIN  player_mast ON player_mast.player_id =match_details.player_gk
JOIN  soccer_country ON soccer_country.country_id=match_details.team_id
WHERE play_stage='G'
AND goal_score=0
AND soccer_country.country_name="Germany"
GROUP BY player_name;
+-------------+-----------------+-------+
| Arquero     | Goles_recibidos | Etapa |
+-------------+-----------------+-------+
| ManuelNeuer |               0 | G     | 
+-------------+-----------------+-------+



-- 15 Write a query in SQL to find the match no. and teams who played the match where highest number of penalty shots had been taken
+---------+-------------+----------+
SELECT match_no PARTIDO,soccer_country.country_name EQUIPO
from penalty_shootout
JOIN soccer_country ON penalty_shootout.team_id=soccer_country.country_id
GROUP BY match_no,country_name
ORDER BY count(kick_no)desc
LIMIT 2;
+---------+---------+
| PARTIDO | EQUIPO  |
+---------+---------+
|      47 | Germany |
|      47 | Italy   |
+---------+---------+


-- 16  Write a query in SQL to find the venues where penalty shootout matches played. 
SELECT venue_name Estadio, soccer_city.city Ciudad
FROM  penalty_shootout
JOIN  match_mast ON match_mast.match_no=penalty_shootout.match_no
JOIN soccer_venue ON match_mast.venue_id=soccer_venue.venue_id
JOIN soccer_city ON soccer_city.city_id = soccer_venue.city_id
GROUP BY venue_name,city;
+-----------------------+---------------+
| Estadio               | Ciudad        |
+-----------------------+---------------+
| StadeGeoffroyGuichard | Saint-Etienne |
| StadeVElodrome        | Marseille     |
| StadedeBordeaux       | Bordeaux      |
+-----------------------+---------------+


-- 17 Write a query in SQL to find the name of the venue with city where the EURO cup 2016 final match was played.
SELECT venue_name Estadio_de_la_final, soccer_city.city Ciudad_de_la_final
FROM  match_mast
JOIN soccer_venue ON match_mast.venue_id=soccer_venue.venue_id
JOIN soccer_city ON soccer_city.city_id = soccer_venue.city_id
AND  match_mast.play_stage='F';

+---------------------+--------------------+
| Estadio_de_la_final | Ciudad_de_la_final |
+---------------------+--------------------+
| StadedeFrance       | Saint-Denis        |
+---------------------+--------------------+


-- 18 Write a query in SQL to find the total number of goals scored by each player within normal play schedule and arrange the result set according to the heighest to lowest scorer
SELECT  player_name Jugador,  count(goal_id) AS  Goles
FROM  goal_details
JOIN player_mast ON player_mast.player_id=goal_details.player_id
WHERE goal_schedule ='NT'
GROUP BY player_name
ORDER BY goles DESC ;

+----------------------+-------+
| Jugador              | Goles |
+----------------------+-------+
| AntoineGriezmann     |     5 |
| OlivierGiroud        |     3 |
| GarethBale           |     3 |
| AlvaroMorata         |     3 |
| CristianoRonaldo     |     3 |
| Nani                 |     3 |
| BogdanStancu         |     2 |
| MarioGomez           |     2 |
| JakubBlaszczykowski  |     2 |
| RomeluLukaku         |     2 |
| BalazsDzsudzsak      |     2 |
| RobbieBrady          |     2 |
| RadjaNainggolan      |     2 |
| IvanPeriSic          |     2 |
| GarethMcAuley        |     2 |
| BirkirBjarnason      |     2 |
| DimitriPayet         |     2 |
| KolbeinnSigthorsson  |     2 |
| HalRobson-Kanu       |     2 |
| AshleyWilliams       |     1 |
| PaulPogba            |     1 |
| BurakYilmaz          |     1 |
| OzanTufan            |     1 |
| NikolaKalinic        |     1 |
| JonDadiBodvarsson    |     1 |
| AlessandroSchopf     |     1 |
| ZoltanGera           |     1 |
| LeonardoBonucci      |     1 |
| Mesutozil            |     1 |
| SamVokes             |     1 |
| YannickCarrasco      |     1 |
| RenatoSanches        |     1 |
| RobertLewandowski    |     1 |
| XherdanShaqiri       |     1 |
| JeromeBoateng        |     1 |
| ArnorIngviTraustason |     1 |
| JulianDraxler        |     1 |
| TobyAlderweireld     |     1 |
| MichyBatshuayi       |     1 |
| EdenHazard           |     1 |
| WayneRooney          |     1 |
| GiorgioChiellini     |     1 |
| MarekHamsik          |     1 |
| FabianSchar          |     1 |
| OndrejDuda           |     1 |
| EricDier             |     1 |
| LukaModric           |     1 |
| ArkadiuszMilik       |     1 |
| ThomasMuller         |     1 |
| GerardPique          |     1 |
| WesHoolahan          |     1 |
| CiaranClark          |     1 |
| EmanueleGiaccherini  |     1 |
| AdamSzalai           |     1 |
| ZoltanStieber        |     1 |
| VladimirWeiss        |     1 |
| NeilTaylor           |     1 |
| DenisGlushakov       |     1 |
| AdmirMehmedi         |     1 |
| JamieVardy           |     1 |
| Eder                 |     1 |
| IvanRakitic          |     1 |
| MilanSkoda           |     1 |
| TomasNecid           |     1 |
| Nolito               |     1 |
| AxelWitsel           |     1 |
| GylfiSigurdsson      |     1 |
| BirkirSaevarsson     |     1 |
| ArmandoSadiku        |     1 |
| AaronRamsey          |     1 |
+----------------------+-------+


-- 19  Write a query in SQL to find the scorer of only goal along with his country and jersey number in the final of EURO cup 2016.
 SELECT  player_mast.player_name Jugador, player_mast.jersey_no Numero, soccer_country.country_name Pais
 FROM goal_details
 JOIN player_mast ON  player_mast.player_id=goal_details.player_id
 JOIN soccer_country ON soccer_country.country_id= goal_details.team_id
 where play_stage='f';
 +---------+--------+----------+
| Jugador | Numero | Pais     |
+---------+--------+----------+
| Eder    |      9 | Portugal |
+---------+--------+----------+


-- 20 Write a query in SQL to find the name and country of the referee who managed the opening match.
 
SELECT  referee_mast.referee_name Arbitro, soccer_country.country_name Nacionalidad
from match_mast
JOIN referee_mast ON referee_mast.referee_id=match_mast.referee_id
JOIN soccer_country ON soccer_country.country_id=referee_mast.country_id
WHERE  match_no=1;
+--------------+--------------+
| Arbitro      | Nacionalidad |
+--------------+--------------+
| ViktorKassai | Hungary      |
+--------------+--------------+


-- 21 Write a query in SQL to find the name and country of the referee who assisted the referee in the final match.
SELECT ass_ref_name Arbitros_asistentes_final, soccer_country.country_name Nacionalidad
from match_details
JOIN asst_referee_mast ON asst_referee_mast.ass_ref_id=match_details.ass_ref
JOIN soccer_country ON soccer_country.country_id=asst_referee_mast.country_id
WHERE  match_details.play_stage='F';
+---------------------------+--------------+
| Arbitros_asistentes_final | Nacionalidad |
+---------------------------+--------------+
| SimonBeck                 | England      |
| JakeCollin                | England      |
+---------------------------+--------------+



-- 22 Write a query in SQL to find the stadium hosted the final match of EURO cup 2016 along with the capacity, and audance for that match. 

SELECT soccer_venue.venue_name Estadio_de_la_final, soccer_venue.aud_capacity Capasidad, match_mast.audence Audiencia
FROM  match_mast
JOIN soccer_venue ON match_mast.venue_id=soccer_venue.venue_id
WHERE  match_mast.play_stage='F';

+---------------------+-----------+-----------+
| Estadio_de_la_final | Capasidad | Audiencia |
+---------------------+-----------+-----------+
| StadedeFrance       |     80100 |     75868 |
+---------------------+-----------+-----------+


-- 23  Write a query in SQL to find the player who was the first player to be sent off at the tournament EURO cup 2016.
/* , player_booked.sent_off Expulsado? */
SELECT   player_mast.player_name Jugador,sent_off Expulsado
FROM    player_booked
JOIN    match_mast ON match_mast.match_no=player_booked.match_no
JOIN    player_mast ON player_mast.player_id=player_booked.player_id
WHERE   sent_off='Y'
AND match_mast.match_no=(SELECT  min(match_mast.match_no)from match_mast);
+---------------+-----------+
| Jugador       | Expulsado |
+---------------+-----------+
| OlivierGiroud | Y         |
+---------------+-----------+

-- 24 Write a query in SQL to find the yellow cards received by each country
  SELECT soccer_country.country_name Equipo, COUNT(match_no) Tarjetas_Amarillas
  FROM   player_booked
  JOIN   soccer_country ON soccer_country.country_id = player_booked.team_id
  WHERE  sent_off!='y'
  GROUP BY soccer_country.country_name
  ORDER BY Tarjetas_amarillas  DESC ;
  +-------------------+--------------------+
| Equipo            | Tarjetas_Amarillas |
+-------------------+--------------------+
| Italy             |                 16 |
| Portugal          |                 13 |
| France            |                 12 |
| Hungary           |                 12 |
| Iceland           |                 12 |
| Wales             |                 11 |
| Germany           |                 11 |
| Poland            |                 10 |
| Romania           |                 10 |
| Albania           |                 10 |
| Belgium           |                  9 |
| Slovakia          |                  9 |
| Croatia           |                  8 |
| RepublicofIreland |                  8 |
| Turkey            |                  7 |
| NorthernIreland   |                  6 |
| Austria           |                  6 |
| Spain             |                  5 |
| Switzerland       |                  5 |
| Ukraine           |                  5 |
| CzechRepublic     |                  4 |
| England           |                  3 |
| Sweden            |                  3 |
| Russia            |                  2 |
+-------------------+--------------------+




-- 25 Write a query in SQL to find the match where no stoppage time added in 1st half of play.
SELECT  *FROM match_mast WHERE stop1_sec=0;
+----------+------------+------------+---------+------------+------------+----------+------------+---------+--------------+-----------+-----------+
| match_no | play_stage | play_date  | results | decided_by | goal_score | venue_id | referee_id | audence | plr_of_match | stop1_sec | stop2_sec |
+----------+------------+------------+---------+------------+------------+----------+------------+---------+--------------+-----------+-----------+
|        4 | G          | 2016-06-12 | DRAW    | N          | 1-1        |    20005 |      70011 |   62343 |       160128 |         0 |       185 |
+----------+------------+------------+---------+------------+------------+----------+------------+---------+--------------+-----------+-----------+
