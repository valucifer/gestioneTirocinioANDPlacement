INSERT INTO `mydb`.`Permissions` (`idPermissions`, `description`, `class`) VALUES ('1', 'L\'utente ha la tutti i permessi su tutti i sistemi', '1-1-1-1-1');
INSERT INTO `mydb`.`Account` (`idAccount`, `userName`, `password`, `typeOfAccount`, `FK_permission`) VALUES ('1', 'pippo', 'paperino', 'student', '1');
UPDATE `mydb`.`Department` SET `description`='DISTRA' WHERE `idDepartment`='1';
INSERT INTO `mydb`.`FisicPerson` (`idFisicPerson`, `name`, `lastName`, `phoneNum`, `city`, `address`, `CAP`, `sex`, `citizenship`, `CF`) VALUES ('1', 'Valentino', 'Vivone', '33135352', 'Battipaglia', 'Viale dei fiori', '89040', 'M', 'Italiano', 'SFAK231mKN');
INSERT INTO `mydb`.`Student` (`serialNumber`, `yearEnrollment`, `cycle`, `universityEmail`, `FK_Account`, `FK_FisicPerson`, `FK_Department`) VALUES ('1', '2008', 'Magistrale', 'v.vivone@studenti.unisa.it', '1', '1', '1');
INSERT INTO `mydb`.`StudentInformation` (`idStudentInformation`, `CurriculumVitaePATH`, `AccademicTranscriptPATH`) VALUES ('1', 'c:\\usr\\utenti\\platform\\1100052200\\cv.pdf', 'c:\\usr\\utenti\\platform\\1100052200\\AT.pdf');
INSERT INTO `mydb`.`StudentAttendence` (`SerialNum`, `Date`, `FK_Student`) VALUES ('1', '2015/12/01', '1');
UPDATE `mydb`.`Student` SET `FK_StudentStatus`='2', `FK_idStudentInformation`='1' WHERE `serialNumber`='1';



INSERT INTO `mydb`.`FisicPerson` (`idFisicPerson`, `name`, `lastName`, `phoneNum`, `city`, `CAP`, `sex`, `citizenship`, `CF`, `email`) VALUES ('2', 'Nello', 'Saulino', '23124323', 'Sabaudia', '89034', 'm', 'Italiano', 'NSW1231ea', 'a.saulino@gmail.com');
INSERT INTO `mydb`.`Account` (`idAccount`, `userName`, `password`, `typeOfAccount`, `FK_permission`) VALUES ('2', 'nello', 'saulino', 'student', '1-1-1-1-1');
INSERT INTO `mydb`.`Student` (`serialNumber`, `yearEnrollment`, `cycle`, `universityEmail`, `FK_Account`, `FK_FisicPerson`, `FK_Department`, `FK_StudentStatus`, `FK_idStudentInformation`) VALUES ('0512200013', '2008/01/02', '2', 'a.saulino@studenti.unisa.it', '1', '2', '1', '2', '1');
INSERT INTO `mydb`.`StudentInformation` (`idStudentInformation`, `CurriculumVitaePATH`) VALUES ('2', 'c:\\usr\\utenti\\platform\\1200052200\\cv.pdf');
UPDATE `mydb`.`Student` SET `FK_idStudentInformation`='2' WHERE `serialNumber`='1';
INSERT INTO `mydb`.`StudentAttendence` (`SerialNum`, `Date`, `FK_Student`) VALUES ('2', '2015/12/01', '0512200013');

INSERT INTO `mydb`.`StudentStatus` (`idStudentStatus`, `description`) VALUES ('0', 'Rifiutato');
