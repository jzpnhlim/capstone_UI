curl http://localhost:4000/v1/search?text=Information%20Technology%20Building%20113%20Doorway \
> pelias_output_113.json

curl http://localhost:4000/v1/search?text=Information%20Technology%20Building%20102%20Doorway \
> pelias_output_102.json

curl http://localhost:4000/v1/search?text=Information%20Technology%20Building%20120%20Doorway \
> pelias_output_120_.json

curl http://localhost:4000/v1/search?text=Information%20Technology%20Building%20128%20Doorway \
> pelias_output_128.json

curl http://localhost:4000/v1/search?text=Information%20Technology%20Building%20114%20Doorway \
> pelias_output_114.json

curl http://localhost:4000/v1/search?text=Information%20Technology%20Building%20134%20Doorway \
> pelias_output_134.json

curl http://localhost:8002/route \
--data '{"verbose":true,
         "locations":[
              {"lat":43.258514,"lon":-79.920569},
              {"lat":43.258656,"lon":-79.920623}
           ],
         "costing":"pedestrian",
         "directions_options":{"units":"kilometers"}
        }' | jq '.' \
> valhalla_output_113-102.json

curl http://localhost:8002/route \
--data '{"verbose":true,
         "locations":[
              {"lat":43.258728,"lon":-79.920740},
              {"lat":43.258791,"lon":-79.920933}
           ],
         "costing":"pedestrian",
         "directions_options":{"units":"kilometers"}
        }' | jq '.' \
> valhalla_output_120-128.json

curl http://localhost:8002/route \
--data '{"verbose":true,
         "locations":[
              {"lat":43.258547,"lon":-79.920571},
              {"lat":43.258776,"lon":-79.920910}
           ],
         "costing":"pedestrian",
         "directions_options":{"units":"kilometers"}
        }' | jq '.' \
> valhalla_output_114-134.json
