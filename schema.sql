/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals
ADD species VARCHAR;

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR,
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT;

ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
ADD owner_id INT;

ALTER TABLE animals
ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    species_id INT,
    vet_id INT
);

ALTER TABLE specializations
ADD FOREIGN KEY (vet_id) REFERENCES vets(id);

ALTER TABLE specializations
ADD FOREIGN KEY (species_id) REFERENCES species(id);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT
);

ALTER TABLE visits ADD visit_date DATE;

ALTER TABLE visits
ADD FOREIGN KEY (vet_id) REFERENCES vets(id);

ALTER TABLE visits
ADD FOREIGN KEY (animal_id) REFERENCES animals(id);