SELECT name, COUNT(musical_genre_id) FROM musical_genres mg 
  JOIN performers_genres pg ON mg.id  = pg.musical_genre_id 
 GROUP BY name;

SELECT a.name, COUNT(album_id) FROM albums a 
  JOIN tracks t ON t.album_id = a.id 
 WHERE date_release BETWEEN '2019-01-01' AND '2020-12-31'
 GROUP BY a.name;

SELECT a.name, AVG(duration) FROM albums a 
  JOIN tracks t ON t.album_id = a.id 
 GROUP BY a.name
 ORDER BY AVG DESC;

SELECT p.name FROM performers p 
  JOIN performers_albums pa ON pa.performer_id = p.id
  JOIN albums a ON pa.album_id = a.id
 WHERE a.date_release NOT BETWEEN '2020-01-01' AND '2020-12-31';

SELECT mc.name, t.name, p.name FROM music_collections mc 
  JOIN music_collection_tracks mct ON mct.music_collection_id  = mc.id 
  JOIN tracks t ON mct.track_id  = t.id 
  JOIN albums a ON t.album_id = a.id 
  JOIN performers_albums pa ON pa.album_id = a.id 
  JOIN performers p ON pa.performer_id = p.id
 WHERE p.name IN ('burzum');

SELECT a.name, p.name, COUNT(mg.id) FROM albums a 
  JOIN performers_albums pa ON pa.album_id = a.id 
  JOIN performers p ON pa.performer_id = p.id 
  JOIN performers_genres pg ON pg.performer_id = p.id 
  JOIN musical_genres mg ON pg.musical_genre_id = mg.id
 GROUP BY a.name, p.name
HAVING COUNT(mg.id) > 1;

SELECT t.name FROM tracks t 
LEFT JOIN music_collection_tracks mct ON mct.track_id = t.id 
LEFT JOIN music_collections mc ON mct.music_collection_id = mc.id 
 WHERE mc.name IS NULL;

SELECT p.name, t.name, t.duration FROM performers p 
  JOIN performers_albums pa ON pa.performer_id = p.id 
  JOIN albums a ON pa.album_id = a.id 
  JOIN tracks t ON t.album_id = a.id 
 WHERE t.duration = (SELECT MIN(duration) FROM tracks);

SELECT a.name, COUNT(t.album_id) FROM albums a
  JOIN tracks t ON t.album_id = a.id
 GROUP BY a.name, t.album_id
HAVING COUNT(t.album_id) = 
       (SELECT COUNT(t.album_id) FROM albums a 
          JOIN tracks t ON t.album_id = a.id
      GROUP BY t.album_id
      ORDER BY COUNT
         LIMIT 1);
