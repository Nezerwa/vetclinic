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

