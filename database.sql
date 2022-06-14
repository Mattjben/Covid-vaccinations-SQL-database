CREATE TABLE Locations(
    Iso_code VARCHAR(40),
    Locations VARCHAR(40),
    Last_observed_date TEXT,
    Source_website VARCHAR(200),
    PRIMARY KEY (
        Iso_code
    ),
    FOREIGN KEY (
        Source_website
    )
    REFERENCES Datasources (Source_website)

)
WITHOUT ROWID;

CREATE TABLE Vaccines_used(
    Iso_code VARCHAR(40),
    Vaccines_used VARCHAR(40),
    PRIMARY KEY (
        Iso_code,
        Vaccines_used
    ),
    FOREIGN KEY(
        Iso_code
    )
    REFERENCES Locations (Iso_code)
)
WITHOUT ROWID;

CREATE TABLE Datasources(
    Source_website VARCHAR(200),
    Source_name VARCHAR(40),
    PRIMARY KEY (
       Source_website
    )

)
WITHOUT ROWID;


CREATE TABLE Vaccinations_bymanufacturer(
    Iso_code VARCHAR(40),
    date TEXT,
    vaccine VARCHAR(40),
    total_vaccinations INTEGER,
    PRIMARY KEY (
       Iso_code,
       date,
       vaccine
    ),
    FOREIGN KEY(
        Iso_code
    )
    REFERENCES Locations (Iso_code)
)
WITHOUT ROWID;

CREATE TABLE Vaccinations_byAge(
    Iso_code VARCHAR(40),
    date DATE,
    age_group VARCHAR(40),
    people_vaccinated_per_hundred FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    total_boosters_per_hundred FLOAT,
    PRIMARY KEY (
       Iso_code,
       date,
       age_group
    ),
    FOREIGN KEY(
        Iso_code
    )
    REFERENCES Locations (Iso_code)
)
WITHOUT ROWID;

CREATE TABLE Vaccines_used_bydate(
    Iso_code VARCHAR(40),
    date DATE,
    Source_website VARCHAR(200),
    vaccine VARCHAR(40),
    PRIMARY KEY (
        Iso_code,
       date,
       vaccine
    ),
    FOREIGN KEY(
        Iso_code
    )
    REFERENCES Locations (Iso_code),
    FOREIGN KEY(
        Source_website
    )
    REFERENCES Datasources (Source_website)
)
WITHOUT ROWID;




CREATE TABLE Vaccinations_global(
    Iso_code VARCHAR(40),
    date DATE, 
    total_vaccinations INTEGER,
    people_vaccinated INTEGER,
    people_fully_vaccinated INTEGER,
    total_boosters INTEGER,
    daily_vaccinations_raw INTEGER,
    daily_vaccinations INTEGER,
    daily_people_vaccinated INTEGER,
    daily_vaccinations_per_million FLOAT,
    PRIMARY KEY (
       Iso_code,
       date
    ),
    FOREIGN KEY(
        Iso_code
    )
    REFERENCES Locations (Iso_code)
)
WITHOUT ROWID;

CREATE TABLE Vaccinations_us(
    Iso_code VARCHAR(40),
    date DATE, 
    total_vaccinations INTEGER,
    people_vaccinated INTEGER,
    people_fully_vaccinated INTEGER,
    total_boosters INTEGER,
    daily_vaccinations_raw INTEGER,
    daily_vaccinations INTEGER,
    total_distributed INTEGER,
    share_doses_used FLOAT,
    daily_vaccinations_per_million FLOAT,
    PRIMARY KEY (
       Iso_code,
       date
    ),
    FOREIGN KEY(
        Iso_code
    )
    REFERENCES Locations (Iso_code)
)
WITHOUT ROWID;

