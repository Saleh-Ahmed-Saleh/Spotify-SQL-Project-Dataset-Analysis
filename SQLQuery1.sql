Create Database SpotifyDB
Use SpotifyDB

select * from spotify

select max(duration_min), min(duration_min) from spotify


select * from spotify
where duration_min = 0


delete from spotify
where duration_min = 0

select * from spotify
where duration_min = 0




 --Retrieve the names of all tracks that have more than 1 billion streams.
Select *  from spotify 
where Stream > 1000000000
order by Stream desc





--List all albums along with their respective artists.

Select  Album, Artist from spotify 
Group by Album, Artist
Order by album desc


--Get the total number of comments for tracks where licensed = TRUE.

Select Sum(comments) as total_number_of_comments  from spotify 
where licensed = '1'

--Find all tracks that belong to the album type single.

Select *  from spotify 
where Album_type like 'single'

--Count the total number of tracks by each artist.
Select Artist , Count(Track) as Tracks  from spotify 
Group by Artist 
Order by Tracks desc


--Calculate the average danceability of tracks in each album.
Select Artist, Track, Album, Avg(Danceability) as Avg_Danceability from spotify
Group by Artist, Track, Album
Order by Avg_Danceability  desc


--Find the top 5 tracks with the highest energy values.
Select Top 5 Track, Avg(Energy) as Avg_Energy from spotify 
 Group by Track
 Order by Avg_Energy  desc
 



-- List all tracks along with their views and likes where official_video = TRUE. 
Select Track, Views, Likes From spotify 
Where official_video Like '1'
Order by  Likes desc
	

--For each album, calculate the total views of all associated tracks.
Select album, Track, Sum( Views) as Total_Views From spotify 
Group by album, Track
Order by Total_Views desc



--Retrieve the track names that have been streamed on Spotify more than YouTube.
Select * From

(
Select	Track ,
		COALESCE(Sum (CASE WHEN most_playedon ='Spotify' Then Stream  End ),0) as Stream_On_Spotify,
		COALESCE(Sum (CASE WHEN most_playedon = 'Youtube' Then  Stream   End ),0) as  Stream_On_Youtube   
From spotify 
Group By Track  
) as t1

Where Stream_On_Spotify > Stream_On_Youtube and Stream_On_Youtube <> 0



--Find the top 3 most-viewed tracks for each artist using window functions.

Select * From 
(
Select * ,Row_Number() over (Partition by Artist Order by  Views desc  ) rnk
From 
(Select Artist , Track , Views From spotify
 
) b
) a
Where rnk <= 3 and Artist is not null






--Write a query to find tracks where the liveness score is above the average.
Select track, artist, Liveness From spotify

Where Liveness > (Select Avg(Liveness) From spotify )
Order by Liveness desc

 


--Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
--First Solution by Cte Method
With Cte as (
Select Album, Max(Energy) as highest_energy, Min(Energy) as lowest_energy
 From spotify
 Group by Album
)
Select Album, ( highest_energy- lowest_energy) as Energy_Difference  From Cte 
Order by Energy_Difference desc



--Second Solution

Select   Album, ( Max(Energy)- Min(Energy) ) as  Energy_Difference   From spotify 
Group by   Album
Order by  Energy_Difference  desc



--Find tracks where the energy-to-liveness ratio is greater than 1.2.

Select Track, ( Energy / Liveness ) as ratio  From spotify 
Where ( Energy / Liveness ) > 1.2
Order by  ratio  desc

 

--Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.


 
Select Track, Views, Sum(likes) Over (Order by Views desc ) as cumulative_likes From spotify 

 
