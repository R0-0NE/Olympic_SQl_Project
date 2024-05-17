SELECT * FROM athlete;

#1) How many olympics games have been held?
SELECT COUNT(DISTINCT(Games)) FROM athlete;

#2) List down all Olympics games held so far.
SELECT DISTINCT Games FROM athlete;

#3) Mention the total no of nations who participated in each olympics game?
SELECT COUNT(DISTINCT Team) AS 'No.of Nations'FROM athlete;

#4) Which year saw the highest and lowest no of countries participating in olympics?
SELECT Year, COUNT(DISTINCT Team) AS c FROM athlete
GROUP BY Year ORDER BY c DESC LIMIT 1; #highest year-2008
SELECT Year, COUNT(DISTINCT Team) AS c FROM athlete
GROUP BY Year ORDER BY c ASC LIMIT 1;  #lowest year-1896

#5)List down total gold, silver and broze medals won by each country.
SELECT Team, COUNT(Medal='Gold'),COUNT(Medal='Silver'),COUNT(Medal='Bronze') FROM athlete
 GROUP BY Team ORDER BY COUNT(Medal='Gold') DESC;

#6)Which Sports were just played only once in the olympics
SELECT COUNT(DISTINCT Games),Sport FROM athlete GROUP BY Sport HAVING COUNT(DISTINCT Games)=1;

#7)Fetch the total no of sports played in each olympic games.
SELECT COUNT(DISTINCT Sport) , Games FROM athlete GROUP BY Games;

#8)Fetch details of the oldest athletes to win a gold medal.
SELECT Name ,Age,Medal FROM athlete WHERE Medal='Gold' ORDER BY Age DESC LIMIT 1;

#9)Fetch the top 5 athletes who have won the most gold medals?
SELECT COUNT(1),Name FROM athlete WHERE Medal='Gold' GROUP BY Name ORDER BY COUNT(1) DESC LIMIT 5;

#10)Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
SELECT Team, COUNT(Medal) AS 'No.of Medals' FROM athlete GROUP BY Team ORDER BY COUNT(Medal) DESC LIMIT 5;

#11)In which Sport/event, India has won highest medals.
SELECT Team,Sport,COUNT(Medal) FROM athlete WHERE Team='India' GROUP BY Sport ORDER BY COUNT(Medal) DESC;

#12)Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.
SELECT Games,Team,Sport,COUNT(Medal) FROM athlete WHERE Team='India' AND Medal!='NA' AND Sport='Hockey'
GROUP BY Games ORDER BY COUNT(Medal);

#13)Which countries have never won gold medal but have won silver/bronze medals?
SELECT DISTINCT Team,Medal FROM athlete WHERE Medal <> 'Gold' AND Medal <>'NA';

#14)Identify which sport played most consecutively in summer olympics
SELECT Sport,COUNT(Sport) FROM athlete WHERE Season='Summer' GROUP BY Sport ORDER BY COUNT(Sport)DESC;

#15)Fetch details of all countries which have won most of silver & bronze medal and atleast 1 gold medal
SELECT Team, SUM(Silver),SUM(Bronze),SUM(Gold)
FROM
(
SELECT *,
		CASE Medal WHEN 'Silver' THEN 1 ELSE 0 END AS Silver,
		CASE Medal WHEN 'Bronze' THEN 1 ELSE 0 END AS Bronze,
        CASE Medal WHEN 'Gold' THEN 1 ELSE 0 END AS Gold
FROM athlete
)innerT
GROUP BY Team HAVING SUM(Gold)>0 ORDER BY SUM(Silver) DESC;

#16) Which player has won most no.of Golds?
SELECT Name,SUM(Gold)
FROM
(
SELECT *,
		CASE Medal WHEN 'Gold' THEN 1 ELSE 0 END AS Gold 
FROM athlete
)innert
GROUP BY Name ORDER BY SUM(Gold) DESC LIMIT 1;

#17)Which sport has maximum events?
SELECT Sport,COUNT(*) FROM athlete GROUP BY Sport ORDER BY COUNT(*)DESC;

#18)Which Year has maximum events?
SELECT Year,COUNT(Games) FROM athlete GROUP BY Year ORDER BY COUNT(Games)DESC;

