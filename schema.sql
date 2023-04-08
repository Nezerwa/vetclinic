/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id Serial PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);
-- edit animal table and add species column
ALTER TABLE animals ADD species VARCHAR(50);

CREATE TABLE owners(
    id Serial PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE species(
    id Serial PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
-- edit animal table and remove species column
ALTER TABLE animals DROP COLUMN species;
--edit animal table and add species_id column
ALTER TABLE animals ADD species_id INT;
--edit animal table and add owner_id column
ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD FOREIGN KEY(owner_id) REFERENCES owners(id);

/*"join table" for visits*/
CREATE TABLE vets (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT,
  age INTEGER,
  date_of_graduation DATE
);

/*species and vets many-to-many relationship */
CREATE TABLE specializations (
  vet_id INTEGER REFERENCES vets(id),
  species_id INTEGER REFERENCES species(id),
  PRIMARY KEY (vet_id, species_id)
);
ALTER TABLE animals ADD CONSTRAINT animals_id_unique UNIQUE (id);

/*animals and vets many-to-many relationship */
CREATE TABLE visits (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    animals_id integer REFERENCES animals(id),
    vet_id integer REFERENCES vets(id),
    visit_date DATE
);