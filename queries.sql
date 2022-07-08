/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';

SELECT * FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/12/31';

SELECT * FROM animals WHERE neutered=true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered=true;

SELECT * FROM animals WHERE NOT name='Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

SELECT COUNT(name) FROM animals;

SELECT COUNT(name) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts)
  FROM animals
  GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg)
  FROM animals
  GROUP BY species;


SELECT name, full_name
FROM animals
INNER JOIN owners 
    ON animals.owner_id = owners.id
WHERE owners.id = 4;

SELECT animals.name AS animal, species.name AS specie
FROM animals
INNER JOIN species 
    ON species_id = species.id 
WHERE species.id = 1;

SELECT animals.name AS animal, owners.full_name AS owner_name
FROM animals
RIGHT JOIN owners 
    ON owner_id = owners.id;

SELECT COUNT(animals.species_id), species.name
FROM animals
RIGHT JOIN species 
    ON species_id = species.id
GROUP BY species.name;

SELECT name, full_name
FROM animals
INNER JOIN owners 
    ON animals.owner_id = owners.id
WHERE owners.id = 2 AND species_id = 2;

SELECT name, full_name
FROM animals
INNER JOIN owners 
    ON animals.owner_id = owners.id
WHERE owners.id = 5 AND escape_attempts = 0;

SELECT COUNT(owner_id) AS number_animals, owners.full_name
FROM animals
INNER JOIN owners 
    ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY COUNT(owner_id) DESC;

SELECT vets.name, animals.name, visit_date
FROM vets
INNER JOIN visits
    ON vets.id = vet_id
INNER JOIN animals
    ON animals.id = animal_id
WHERE vets.id = 1
ORDER BY visit_date DESC LIMIT 1;

SELECT vets.name, COUNT(*) AS animals_see
FROM vets
INNER JOIN visits
    ON vets.id = vet_id
WHERE vets.id = 3
GROUP BY vets.name;

SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations
    ON vets.id = specializations.vet_id
FULL JOIN species
    ON species.id = specializations.species_id;

SELECT vets.name, animals.name, visits.visit_date
FROM vets
INNER JOIN visits
    ON vets.id = visits.vet_id
INNER JOIN animals
    ON animals.id = visits.animal_id
WHERE vets.id = 3 AND visits.visit_date BETWEEN '2020-04-1' AND '2020-08-30';

SELECT animals.name, COUNT(visits.animal_id) AS number_visits
FROM animals
INNER JOIN visits
    ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(visits.animal_id) DESC LIMIT 1;

SELECT vets.name, animals.name, visits.visit_date AS date
FROM vets
INNER JOIN visits
    ON vets.id = visits.vet_id
INNER JOIN animals
    ON animals.id = visits.animal_id
WHERE vets.id = 2
ORDER BY date LIMIT 1; 

SELECT vets.name, animals.name, visits.visit_date
FROM vets
INNER JOIN visits
    ON vets.id = visits.vet_id
INNER JOIN animals
    ON animals.id = visits.animal_id
ORDER BY visits.visit_date DESC LIMIT 1;

SELECT COUNT(*)
FROM visits
INNER JOIN vets
    ON visits.vet_id = vets.id
INNER JOIN animals
    ON visits.animal_id = animals.id
LEFT JOIN specializations
    ON vets.id = specializations.vet_id
WHERE vets.id != (
    SELECT id FROM vets
    WHERE name = 'Stephanie Mendez'
)
AND specializations.species_id != animals.species_id
OR specializations.species_id IS NULL;

SELECT species.name, COUNT(species.name)
FROM visits
INNER JOIN vets
    ON visits.vet_id = vets.id
INNER JOIN animals
    ON visits.animal_id = animals.id
INNER JOIN species
    ON animals.species_id = species.id
WHERE vets.id = 2
GROUP BY species.name
ORDER BY COUNT(species.name) DESC LIMIT 1;
