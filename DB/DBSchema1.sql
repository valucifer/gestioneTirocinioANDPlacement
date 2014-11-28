SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Permissions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Permissions` (
  `idPermissions` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `class` VARCHAR(45) NULL,
  PRIMARY KEY (`idPermissions`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Account` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `idAccount` BIGINT NOT NULL COMMENT 'Identificativo univoco per qualsiasi utente si voglia loggare al sistema',
  `userName` VARCHAR(45) NOT NULL COMMENT 'Nome con il quale l\'utente viene riconosciuto da un',
  `password` VARCHAR(45) NOT NULL,
  `typeOfAccount` VARCHAR(45) NULL,
  `FK_permission` INT NOT NULL,
  PRIMARY KEY (`idAccount`),
  INDEX `fk_Account_Permissions_idx` (`FK_permission` ASC),
  CONSTRAINT `fk_Account_Permissions`
    FOREIGN KEY (`FK_permission`)
    REFERENCES `mydb`.`Permissions` (`idPermissions`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Tabella adibita alla gestione dei dati principali per l\'aces /* comment truncated */ /*so al sistema*/';


-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Department` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `idDepartment` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`idDepartment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FisicPerson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`FisicPerson` ;

CREATE TABLE IF NOT EXISTS `mydb`.`FisicPerson` (
  `idFisicPerson` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `phoneNum` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `CAP` VARCHAR(45) NULL,
  `sex` CHAR NULL,
  `citizenship` VARCHAR(45) NULL,
  `CF` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idFisicPerson`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StudentStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`StudentStatus` ;

CREATE TABLE IF NOT EXISTS `mydb`.`StudentStatus` (
  `idStudentStatus` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`idStudentStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ClaimStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ClaimStatus` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ClaimStatus` (
  `idClaimStatus` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`idClaimStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Professor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Professor` (
  `idProfessor` INT NOT NULL,
  `position` VARCHAR(45) NULL,
  `officePhoneNum` VARCHAR(45) NULL,
  `officeHours` VARCHAR(45) NULL,
  `officeEmail` VARCHAR(45) NULL,
  `FK_Account` BIGINT NOT NULL,
  `FK_FisicPerson` INT NOT NULL,
  `FK_Department` INT NOT NULL,
  PRIMARY KEY (`idProfessor`),
  INDEX `fk_Professor_Account1_idx` (`FK_Account` ASC),
  INDEX `fk_Professor_FisicPerson1_idx` (`FK_FisicPerson` ASC),
  INDEX `fk_Professor_Department1_idx` (`FK_Department` ASC),
  CONSTRAINT `fk_Professor_Account1`
    FOREIGN KEY (`FK_Account`)
    REFERENCES `mydb`.`Account` (`idAccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professor_FisicPerson1`
    FOREIGN KEY (`FK_FisicPerson`)
    REFERENCES `mydb`.`FisicPerson` (`idFisicPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professor_Department1`
    FOREIGN KEY (`FK_Department`)
    REFERENCES `mydb`.`Department` (`idDepartment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Organization` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Organization` (
  `idOrganization` INT NOT NULL AUTO_INCREMENT,
  `companyName` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `FK_Account` BIGINT NOT NULL,
  `FK_FisicPerson` INT NULL,
  `FK_Professor` INT NOT NULL,
  PRIMARY KEY (`idOrganization`, `companyName`),
  INDEX `fk_Organization_Account1_idx` (`FK_Account` ASC),
  INDEX `fk_Organization_FisicPerson1_idx` (`FK_FisicPerson` ASC),
  INDEX `fk_Organization_Professor1_idx` (`FK_Professor` ASC),
  CONSTRAINT `fk_Organization_Account1`
    FOREIGN KEY (`FK_Account`)
    REFERENCES `mydb`.`Account` (`idAccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Organization_FisicPerson1`
    FOREIGN KEY (`FK_FisicPerson`)
    REFERENCES `mydb`.`FisicPerson` (`idFisicPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Organization_Professor1`
    FOREIGN KEY (`FK_Professor`)
    REFERENCES `mydb`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ClaimTraining`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ClaimTraining` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ClaimTraining` (
  `idClaimTraining` INT NOT NULL,
  `description` LONGTEXT NULL,
  `title` VARCHAR(45) NULL,
  `FK_ClaimStatus` INT NOT NULL,
  `FK_Professor` INT NOT NULL,
  `FKOrganization` INT NULL,
  PRIMARY KEY (`idClaimTraining`),
  INDEX `fk_ClaimTraining_ClaimStatus1_idx` (`FK_ClaimStatus` ASC),
  INDEX `fk_ClaimTraining_Professor1_idx` (`FK_Professor` ASC),
  INDEX `fk_ClaimTraining_Organization1_idx` (`FKOrganization` ASC),
  CONSTRAINT `fk_ClaimTraining_ClaimStatus1`
    FOREIGN KEY (`FK_ClaimStatus`)
    REFERENCES `mydb`.`ClaimStatus` (`idClaimStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ClaimTraining_Professor1`
    FOREIGN KEY (`FK_Professor`)
    REFERENCES `mydb`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ClaimTraining_Organization1`
    FOREIGN KEY (`FKOrganization`)
    REFERENCES `mydb`.`Organization` (`idOrganization`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StudentInformation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`StudentInformation` ;

CREATE TABLE IF NOT EXISTS `mydb`.`StudentInformation` (
  `idStudentInformation` INT NULL,
  `CurriculumVitaePATH` VARCHAR(200) NULL,
  `AccademicTranscriptPATH` VARCHAR(200) NULL,
  PRIMARY KEY (`idStudentInformation`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Student` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Student` (
  `serialNumber` VARCHAR(45) NOT NULL,
  `coverLetter` LONGTEXT NULL,
  `yearEnrollment` DATE NULL,
  `cycle` INT NULL,
  `universityEmail` VARCHAR(45) NULL,
  `FK_Account` BIGINT NOT NULL,
  `FK_FisicPerson` INT NOT NULL,
  `FK_Department` INT NOT NULL,
  `FK_StudentStatus` INT NULL,
  `FK_ClaimTraining` INT NULL,
  `FK_idStudentInformation` INT NULL,
  PRIMARY KEY (`serialNumber`),
  INDEX `fk_Student_Account1_idx` (`FK_Account` ASC),
  INDEX `fk_Student_Department1_idx` (`FK_Department` ASC),
  INDEX `fk_Student_FisicPerson1_idx` (`FK_FisicPerson` ASC),
  INDEX `fk_Student_StudentStatus1_idx` (`FK_StudentStatus` ASC),
  INDEX `fk_Student_ClaimTraining1_idx` (`FK_ClaimTraining` ASC),
  INDEX `fk_Student_StudentInformation1_idx` (`FK_idStudentInformation` ASC),
  CONSTRAINT `fk_Student_Account1`
    FOREIGN KEY (`FK_Account`)
    REFERENCES `mydb`.`Account` (`idAccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_Department1`
    FOREIGN KEY (`FK_Department`)
    REFERENCES `mydb`.`Department` (`idDepartment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_FisicPerson1`
    FOREIGN KEY (`FK_FisicPerson`)
    REFERENCES `mydb`.`FisicPerson` (`idFisicPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_StudentStatus1`
    FOREIGN KEY (`FK_StudentStatus`)
    REFERENCES `mydb`.`StudentStatus` (`idStudentStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_ClaimTraining1`
    FOREIGN KEY (`FK_ClaimTraining`)
    REFERENCES `mydb`.`ClaimTraining` (`idClaimTraining`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_StudentInformation1`
    FOREIGN KEY (`FK_idStudentInformation`)
    REFERENCES `mydb`.`StudentInformation` (`idStudentInformation`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Staff` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `idStaff` INT NOT NULL,
  `officePhoneNum` VARCHAR(45) NULL,
  `officeEmail` VARCHAR(45) NULL,
  `FK_Department` INT NOT NULL,
  `FK_Account` BIGINT NOT NULL,
  `FK_FisicPerson` INT NOT NULL,
  PRIMARY KEY (`idStaff`),
  INDEX `fk_Staff_Department1_idx` (`FK_Department` ASC),
  INDEX `fk_Staff_Account1_idx` (`FK_Account` ASC),
  INDEX `fk_Staff_FisicPerson1_idx` (`FK_FisicPerson` ASC),
  CONSTRAINT `fk_Staff_Department1`
    FOREIGN KEY (`FK_Department`)
    REFERENCES `mydb`.`Department` (`idDepartment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Staff_Account1`
    FOREIGN KEY (`FK_Account`)
    REFERENCES `mydb`.`Account` (`idAccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Staff_FisicPerson1`
    FOREIGN KEY (`FK_FisicPerson`)
    REFERENCES `mydb`.`FisicPerson` (`idFisicPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StudentAttendence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`StudentAttendence` ;

CREATE TABLE IF NOT EXISTS `mydb`.`StudentAttendence` (
  `SerialNum` INT NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NULL,
  `FK_Student` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SerialNum`),
  INDEX `fk_StudentAttendence_Student1_idx` (`FK_Student` ASC),
  CONSTRAINT `fk_StudentAttendence_Student1`
    FOREIGN KEY (`FK_Student`)
    REFERENCES `mydb`.`Student` (`serialNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OfferTraining`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`OfferTraining` ;

CREATE TABLE IF NOT EXISTS `mydb`.`OfferTraining` (
  `idOfferTraining` INT NOT NULL AUTO_INCREMENT,
  `description` LONGTEXT NULL,
  `FK_Organization` INT NULL,
  `FK_Professor` INT NOT NULL,
  `FK_Department` INT NULL,
  PRIMARY KEY (`idOfferTraining`),
  INDEX `fk_OfferTraining_Organization1_idx` (`FK_Organization` ASC),
  INDEX `fk_OfferTraining_Professor1_idx` (`FK_Professor` ASC),
  INDEX `fk_OfferTraining_Department1_idx` (`FK_Department` ASC),
  CONSTRAINT `fk_OfferTraining_Organization1`
    FOREIGN KEY (`FK_Organization`)
    REFERENCES `mydb`.`Organization` (`idOrganization`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OfferTraining_Professor1`
    FOREIGN KEY (`FK_Professor`)
    REFERENCES `mydb`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OfferTraining_Department1`
    FOREIGN KEY (`FK_Department`)
    REFERENCES `mydb`.`Department` (`idDepartment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RejectedTrainingMessage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RejectedTrainingMessage` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RejectedTrainingMessage` (
  `idRejectedTrainingMessage` INT NOT NULL AUTO_INCREMENT,
  `description` LONGTEXT NULL,
  `FK_Student` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRejectedTrainingMessage`),
  INDEX `fk_RejectedTrainingMessage_Student1_idx` (`FK_Student` ASC),
  CONSTRAINT `fk_RejectedTrainingMessage_Student1`
    FOREIGN KEY (`FK_Student`)
    REFERENCES `mydb`.`Student` (`serialNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
