-- Criar o banco de dados

USE desafio_dados;
GO

-- Tabela employee
CREATE TABLE employee (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10,2) CHECK (Salary > 2000.0),
    Super_ssn CHAR(9),
    Dno INT NOT NULL
);
GO

-- Adicionar valor padrão para Dno
ALTER TABLE employee ADD CONSTRAINT df_dno DEFAULT 1 FOR Dno;
GO

-- Adicionar FK para Super_ssn referenciando employee
ALTER TABLE employee ADD CONSTRAINT fk_employee FOREIGN KEY (Super_ssn)
REFERENCES employee(Ssn)
ON DELETE SET NULL
ON UPDATE CASCADE;
GO

-- Tabela departament
CREATE TABLE departament (
    Dname VARCHAR(15) NOT NULL UNIQUE,
    Dnumber INT NOT NULL PRIMARY KEY,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    Dept_create_date DATE,
    CONSTRAINT chk_date_dept CHECK (Dept_create_date < Mgr_start_date),
    CONSTRAINT fk_dept FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
        ON UPDATE CASCADE
);
GO

-- Tabela dept_locations
CREATE TABLE dept_locations (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dept_locations PRIMARY KEY (Dnumber, Dlocation),
    CONSTRAINT fk_dept_locations FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- Tabela project
CREATE TABLE project (
    Pname VARCHAR(15) NOT NULL UNIQUE,
    Pnumber INT NOT NULL PRIMARY KEY,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    CONSTRAINT fk_project FOREIGN KEY (Dnum) REFERENCES departament(Dnumber)
);
GO

-- Tabela works_on
CREATE TABLE works_on (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    CONSTRAINT pk_works_on PRIMARY KEY (Essn, Pno),
    CONSTRAINT fk_employee_works_on FOREIGN KEY (Essn) REFERENCES employee(Ssn),
    CONSTRAINT fk_project_works_on FOREIGN KEY (Pno) REFERENCES project(Pnumber)
);
GO

-- Tabela dependent
CREATE TABLE dependent (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(8),
    CONSTRAINT pk_dependent PRIMARY KEY (Essn, Dependent_name),
    CONSTRAINT fk_dependent FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);
GO

ALTER TABLE employee ADD CONSTRAINT fk_employee FOREIGN KEY (Super_ssn)
REFERENCES employee(Ssn);

ALTER TABLE employee ADD CONSTRAINT fk_employee FOREIGN KEY (Super_ssn)
REFERENCES employee(Ssn)
ON DELETE SET NULL;