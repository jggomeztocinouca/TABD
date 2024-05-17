-- 1. Creación de la estructura
MERGE (philip:Person {name: "Philip"})
MERGE (mark:Person {name: "Mark"})
MERGE (bruno:Person {name: "Bruno"})
MERGE (zushiZam:Restaurant {name: "Zushi Zam"})
MERGE (iSushi:Restaurant {name: "iSushi"})
MERGE (newYork:Location {name: "New York"})
MERGE (sushi:Cuisine {name: "Sushi"})

MERGE (philip)-[:IS_FRIEND_OF]->(mark)
MERGE (philip)-[:IS_FRIEND_OF]->(bruno)
MERGE (mark)-[:LIKES]->(zushiZam)
MERGE (bruno)-[:LIKES]->(iSushi)
MERGE (zushiZam)-[:SERVES]->(sushi)
MERGE (iSushi)-[:SERVES]->(sushi)
MERGE (zushiZam)-[:LOCATED_IN]->(newYork)
MERGE (iSushi)-[:LOCATED_IN]->(newYork)

-- 2. Muestra el contenido del grafo.
MATCH (n) RETURN n

-- 3. Muestra los amigos de “Philip” que les guste un restaurante que sirva “Sushi”.
MATCH (philip:Person {name: "Philip"})-[:IS_FRIEND_OF]->(friend)-[:LIKES]->(restaurant:Restaurant)-[:SERVES]->(cuisine:Cuisine {name: "Sushi"})
RETURN friend.name as Friend, restaurant.name as Restaurant

-- 4. Muestra todos los restaurantes cuyo nombre contenga la palabra “ushi”.
MATCH (restaurant:Restaurant)
WHERE restaurant.name CONTAINS "ushi"
RETURN restaurant.name

-- 5. Muestra todos los restaurantes que sirvan “Sushi”.
MATCH (restaurant:Restaurant)-[:SERVES]->(cuisine:Cuisine {name: "Sushi"})
RETURN restaurant.name

-- 6. Añade un nuevo restaurante que se encuentre en “New York”. Elige el nombre del restaurante
-- y la especialidad que sirve.
MERGE (newYork:Location {name: "New York"})
MERGE (cafe:Cuisine {name: "Café con laxantes"})
MERGE (esi:Restaurant {name: "Cafetería ESI"})
MERGE (esi)-[:LOCATED_IN]->(newYork)
MERGE (esi)-[:SERVES]->(cafe)

-- 7. Modifica el nombre del restaurante “Zushi Zam” a “Zushi”.
MATCH (restaurant:Restaurant {name: "Zushi Zam"})
SET restaurant.name = "Zushi"

-- 8. Añade al nodo “New York” la propiedad “country” con el valor USA.
MATCH (location:Location {name: "New York"})
SET location.country = "USA"

-- 9. Añade una nueva especialidad “Sashimi” a los restaurantes que le gusten a los amigos de Philip que sirvan “Sushi”
-- y que estén localizados en “New York”.
MERGE (sashimi:Cuisine {name: "Sashimi"})
WITH sashimi
MATCH (philip:Person {name: "Philip"})-[:IS_FRIEND_OF]->()-[:LIKES]->(restaurant:Restaurant)-[:LOCATED_IN]->(location:Location {name: "New York"})
MATCH (restaurant)-[:SERVES]->(cuisine:Cuisine {name: "Sushi"})
MERGE (restaurant)-[:SERVES]->(sashimi)

-- 10.Muestra desde “Philip” los nodos que estén hasta tres saltos de distancia.
MATCH path = (philip:Person {name: "Philip"})-[*1..3]->(n)
RETURN path

-- 11.Borra únicamente el nodo “New York” y sus relaciones
MATCH (newYork:Location {name: "New York"})
DETACH DELETE newYork
