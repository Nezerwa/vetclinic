SELECT * FROM animals WHERE name like '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
SELECT * FROM animals WHERE species = 'unspecified';

--start a transaction
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
--ROLLBACK transaction
ROLLBACK;

--start a transaction

BEGIN;
--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE name like '%mon';
--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
--commit the transaction
COMMIT;
--verify the change after we made commit
SELECT * FROM animals;
-- start a transaction
BEGIN; 
--delete all records in animal table.
DELETE * FROM animals;
--verify that records are deleted.
SELECT * FROM animals;
--revert the changes
ROLLBACK;
--verify that records in animal table still exist.
SELECT * FROM animals;
--begin a transaction
BEGIN;
--Delete all animals born after Jan 1st, 2022.
DELETE  FROM animals WHERE date_of_birth > '2022-01-01';
--create a save point called save_1
SAVEPOINT save_1;
-- update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg= (weight_kg * -1);
--rollback to savepoint save_1
ROLLBACK TO save_1;
--Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg= (weight_kg * -1) WHERE weight_kg < 0;
--commit the transaction
COMMIT;
--query to count how many animals are there
SELECT COUNT(*) FROM animals;
--query to count how many animals have never tried to escape
SELECT COUNT(*)FROM animals WHERE escape_attempts = 0;
--query to calculate the average of weights for animals
SELECT AVG(weight_kg) FROM animals;
--query that shows Who escapes the most, neutered or not neutered animals
SELECT neutered, AVG(escape_attempts) AS escapes FROM animals GROUP BY neutered;
--query that shows the minimum and maximum weight of each type of animal.
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
-- query that shows the average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species, AVG(escape_attempts) AS escapes FROM animals WHERE date_of_birth  BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


-- query that shows animals belong to Melody Pond
SELECT animals.name FROM animals 
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';
--query that shows List of all animals that are pokemon 
SELECT animals.name FROM 
 animals JOIN species ON
 animals.species_id = species.id
 WHERE species.id = 1;
 -- query that shows List all owners and their animals 
 SELECT full_name, name 
 FROM owners FULL OUTER JOIN
  animals ON owners.id = animals.owner_id;
 -- query that calculates How many animals are there per species
 SELECT COUNT(species_id), (species.name)  
 FROM animals JOIN species ON
  animals.species_id = species.id 
  GROUP BY species.name;
  -- query that List all Digimon owned by Jennifer Orwell
SELECT (animals.name) AS animalName, (species.name) AS speciesName, full_name FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.id = 2 AND owner_id = 2;
-- Update List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.* FROM animals
 JOIN owners ON animals.owner_id = owners.id
 WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name, COUNT(owner_id) AS Total_animals FROM owners
JOIN animals ON  owners.id = animals.owner_id
GROUP BY full_name
ORDER BY COUNT(name) DESC;

/*join table queries*/
--Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.visit_date FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'William Tatcher' ORDER BY visits.visit_date DESC LIMIT 1;
--How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name) FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id GROUP BY vets.name HAVING vets.name = 'Stephanie Mendez';
--List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name AS specialties FROM vets FULL JOIN specializations ON vets.id = specializations.vet_id FULL JOIN species ON species.id = specializations.species_id;
--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.visit_date FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id WHERE visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30' AND vets.name = 'Stephanie Mendez';
--What animal has the most visits to vets?
SELECT animals.name, COUNT(animals.id) FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id GROUP BY animals.name ORDER BY COUNT(animals_id) DESC LIMIT 1;
--Who was Maisy Smith's first visit?
SELECT animals.name, visits.visit_date FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Maisy Smith' ORDER BY visits.visit_date ASC LIMIT 1;
--Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, vets.name AS vet_name, vets.age, vets.date_of_graduation, visits.visit_date FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id ORDER BY visits.visit_date DESC LIMIT 1;
--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animals_id) FROM visits JOIN vets ON vets.id = visits.vet_id JOIN animals ON animals.id = visits.animals_id JOIN specializations ON specializations.vet_id = vets.id WHERE specializations.species_id <> animals.species_id;
--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(visits.animals_id) as count FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY count DESC LIMIT 1;
