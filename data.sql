INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Agumon', '2020-02-03', 0, TRUE, 10.23),
('Gabumon', '2018-11-15', 2, TRUE, 8),
('Pikachu', '2021-01-07', 1, FALSE, 15.04),
('Devimon', '2017-05-12', 5, TRUE, 11),
('Charmander','2020-02-08',0, False, -11),
('Plantmon', '2021-11-15', 2, TRUE, -5.7),
('Squirtle', '1993-04-02', 3, False, -12.13),
('Angemon', '2005-06-12', 1, TRUE, -45),
('Boarmon', '2005-06-07', 7, TRUE, 20.4),
('Blossom','1998-10-13',3,true,17),
('Ditto','2022-05-14',4,true,22);

INSERT INTO owners(full_name,age) VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);
INSERT INTO species(name) VALUES ('Pokemon');
INSERT INTO species(name) VALUES ('Digimon');

--Modify inserted animals so it includes the species_id value
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

--Modify inserted animals to include owner information
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');

/*join data for visits*/
INSERT INTO vets (name,age,date_of_graduation) VALUES ('William Tatcher',45,'2000-04-23');
INSERT INTO vets (name,age,date_of_graduation) VALUES ('Maisy Smith',26,'2019-01-17');
INSERT INTO vets (name,age,date_of_graduation) VALUES ('Stephanie Mendez',64,'1981-05-04');
INSERT INTO vets (name,age,date_of_graduation) VALUES ('Jack Harkness',38,'2007-06-08');

-- Insert data into the specializations table
INSERT INTO specializations (vet_id, species_id) VALUES ((select id FROM vets WHERE name = 'William Tatcher' LIMIT 1), (SELECT id FROM species WHERE name = 'Pokemon' LIMIT 1));
INSERT INTO specializations (vet_id, species_id) VALUES ((select id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM species WHERE name = 'Pokemon' LIMIT 1)), ((SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM species WHERE name = 'Digimon' LIMIT 1));
INSERT INTO specializations (vet_id, species_id) VALUES ((select id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), (SELECT id FROM species WHERE name = 'Digimon' LIMIT 1));

-- insert data for visits
INSERT INTO visits (animals_id, vet_id,  visit_date)
VALUES 
((SELECT id FROM animals WHERE name = 'Agumon' LIMIT 1), (SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), '2020-05-24'),
((SELECT id FROM animals WHERE name = 'Agumon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), '2020-07-22'),
((SELECT id FROM animals WHERE name = 'Gabumon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), '2021-02-02'),
((SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-01-05'),
((SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-03-08'),
((SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-05-14'),
((SELECT id FROM animals WHERE name = 'Devimon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), '2021-05-04'),
((SELECT id FROM animals WHERE name = 'Charmander' LIMIT 1), (SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), '2021-02-24'),
((SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2019-12-21'),
((SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), '2020-08-10'),
((SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2021-04-07'),
((SELECT id FROM animals WHERE name = 'Squirtle' LIMIT 1), (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), '2021-09-29'),
((SELECT id FROM animals WHERE name = 'Angemon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), '2020-10-03'),
((SELECT id FROM animals WHERE name = 'Angemon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), '2020-11-04'),
((SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2019-01-24'),
((SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2019-05-15'),
((SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-02-27'),
((SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-08-03'),
((SELECT id FROM animals WHERE name = 'Blossom' LIMIT 1), (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), '2020-05-24'),
((SELECT id FROM animals WHERE name = 'Blossom' LIMIT 1), (SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), '2021-01-11');
