/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 5.7.12-log : Database - studentreg
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`studentreg` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `studentreg`;

/*Table structure for table `tblcontact` */

DROP TABLE IF EXISTS `tblcontact`;

CREATE TABLE `tblcontact` (
  `ContactID` varchar(30) NOT NULL,
  `Id` varchar(50) DEFAULT NULL,
  `Contact` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ContactID`),
  KEY `tblcontact_ibfk_1` (`Id`),
  CONSTRAINT `tblcontact_ibfk_1` FOREIGN KEY (`Id`) REFERENCES `tblstudinfo` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblcontact` */

/*Table structure for table `tblcourse` */

DROP TABLE IF EXISTS `tblcourse`;

CREATE TABLE `tblcourse` (
  `CourseID` int(11) NOT NULL AUTO_INCREMENT,
  `CourseCode` varchar(30) DEFAULT NULL,
  `CourseDescription` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblcourse` */

/*Table structure for table `tblstudinfo` */

DROP TABLE IF EXISTS `tblstudinfo`;

CREATE TABLE `tblstudinfo` (
  `Id` varchar(50) NOT NULL,
  `Fname` varchar(50) DEFAULT NULL,
  `Mi` char(2) DEFAULT NULL,
  `Lname` varchar(50) DEFAULT NULL,
  `Birthday` date DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tblstudinfo` */

insert  into `tblstudinfo`(`Id`,`Fname`,`Mi`,`Lname`,`Birthday`,`Address`) values 
('123','Jerry','O','Mates','2001-02-02','Polomolok South Cotabato'),
('2','Cybelle','N','Mates','2019-05-25','Polomolok, South Cotabato.  Philippines');

/* Function  structure for function  `sample_func` */

/*!50003 DROP FUNCTION IF EXISTS `sample_func` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `sample_func`(_input varchar(50)) RETURNS varchar(50) CHARSET utf8
BEGIN
	DECLARE input VArchar(50);
	SET  input=  (SELECT _input);
	return input;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sprocAddStudent` */

/*!50003 DROP PROCEDURE IF EXISTS  `sprocAddStudent` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sprocAddStudent`(
    paramId VARCHAR(50),
     paramFname VARCHAR(50),
      paramMi CHAR(2),
       paramlname VARCHAR(50),
        parambday DATE,
         paramAddress VARCHAR(100)
    
    
    )
BEGIN
	INSERT INTO tblstudinfo () VALUES (paramId,paramFname,paramMi,paramlname,parambday,paramAddress);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `SprocInsertStudent` */

/*!50003 DROP PROCEDURE IF EXISTS  `SprocInsertStudent` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SprocInsertStudent`(
    Id Varchar(50),
    Fname VARCHAR(50),
    Mi CHAR(2),
    Lname VARCHAR(50),
    Birthday Date,
    Address VARCHAR(100)
)
BEGIN
	
INSERT INTO `studentreg`.`tblstudinfo` () VALUES
						  (
						    Id,
						    Fname,
						    Mi,
						    Lname,
						    Birthday,
						    Address
						  ) ;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sprocsave` */

/*!50003 DROP PROCEDURE IF EXISTS  `sprocsave` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sprocsave`(
	    paramid VARCHAR(50),
	    paramfname VARCHAR(50),
	    parammi CHAR(2),
	    paramlname VARCHAR(50),
	    parambday DATE,
	    paramaddress VARCHAR(100)
    )
BEGIN
		INSERT INTO `studentreg`.`tblstudinfo` (
			  `Id`,
			  `Fname`,
			  `Mi`,
			  `Lname`,
			  `Birthday`,
			  `Address`
			)
			VALUES
			  (
			    paramid,
			   paramfname,
			    parammi,
			    paramlname,
			    parambday,
			   paramaddress
			  );
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sprocStudentList` */

/*!50003 DROP PROCEDURE IF EXISTS  `sprocStudentList` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sprocStudentList`()
BEGIN
		select * from tblstudinfo;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sproc_addition` */

/*!50003 DROP PROCEDURE IF EXISTS  `sproc_addition` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sproc_addition`(
num1 double(8,2),
num2 DOUBLE(8,2),
param CHAR(2)
)
BEGIN
	DECLARE ans DOUBLE(8,2);
	
	if (param = '+') THEN
		SET ans = num1 + num2;
		
	ELSEIF(param = '-') THEN
		SET ans = num1 - num2;
	
	ELSEIF(param = '*') THEN
		SET ans = num1 * num2;
		
	ELSEIF(param = '/') THEN
		SET ans = num1 / num2;
			
	END IF;	
	
	
	SELECT ans;
	
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sproc_area` */

/*!50003 DROP PROCEDURE IF EXISTS  `sproc_area` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sproc_area`(param char(10))
BEGIN
			IF param = 'DELETE' then
			DELETE FROM `tblcontact` WHERE `Id` = '00002222';
			ELSE
			
			INSERT INTO `tblstudinfo` () VALUES ('00002222','s','s','s','10-10-10','s');
	
			INSERT INTO `tblcontact` () VALUES ('0000011','00002222','09115441');
			END IF;
		
	
	
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sproc_ContactDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sproc_ContactDetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sproc_ContactDetails`()
BEGIN
SELECT `ContactID`,A.`Id`, `Fname`,`Lname`,`Contact` FROM `tblcontact` A INNER JOIN `tblstudinfo` B ON A.`Id` = B.`Id`;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `Sproc_DeleteRecord` */

/*!50003 DROP PROCEDURE IF EXISTS  `Sproc_DeleteRecord` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Sproc_DeleteRecord`(paramId varchar(50))
BEGIN
				DELETE
				FROM
				  `studentreg`.`tblstudinfo`
				WHERE `Id` =paramId;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `Sproc_FillList` */

/*!50003 DROP PROCEDURE IF EXISTS  `Sproc_FillList` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Sproc_FillList`(
	
    )
BEGIN
		SELECT * FROM `tblstudinfo` A INNER JOIN `tblcontact` B ON A.Id = B.Id;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `Sproc_InsertRecord` */

/*!50003 DROP PROCEDURE IF EXISTS  `Sproc_InsertRecord` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Sproc_InsertRecord`(
	paraId varchar(50),
	paramFname varchar(50),
	paramMi char(2),
	paramLname varchar(50),
	paramBirthday date,
	paramAddress varchar(100),
	paramconid varchar(50),
	paramcon varchar(50)
    )
BEGIN
		INSERT INTO `studentreg`.`tblstudinfo` ()
						VALUES
						  (
						    paraId,
						    paramFname,
						    paramMi,
						    paramLname,
						    paramBirthday,
						    paramAddress
						  );
						  
		INSERT INTO `tblcontact` () VALUES (paramconid,paraId,paramcon);
						  
						  
		/*CALL `Sproc_FillList`();*/
		SELECT 'New Record added';
		
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sproc_performcrud` */

/*!50003 DROP PROCEDURE IF EXISTS  `sproc_performcrud` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sproc_performcrud`(
    paramid varchar(50),
    paramfname VARCHAR(50),
    parammi CHAR(2),
    paramlname VARCHAR(50),
    parambday date,
    paramaddress VARCHAR(100),
    paramcheck char(100)
  
    )
BEGIN
	
		if paramcheck = 'SAVE' THEN
			CALL `sprocsave`(paramid,paramfname,parammi,paramlname,parambday,paramaddress);
		ELSEIF paramcheck = 'UPDATE' THEN
			CALL `sproc_update`(paramid,paramfname,parammi,paramlname,parambday,paramaddress);
		END IF;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sproc_sample_2` */

/*!50003 DROP PROCEDURE IF EXISTS  `sproc_sample_2` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sproc_sample_2`()
BEGIN
	
	DECLARE ans double(8,2);
	
	SET ans = 1+7;
	SELECT ans;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sproc_update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sproc_update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sproc_update`(
	    paramid VARCHAR(50),
	    paramfname VARCHAR(50),
	    parammi CHAR(2),
	    paramlname VARCHAR(50),
	    parambday DATE,
	    paramaddress VARCHAR(100)
    )
BEGIN
		UPDATE
  `studentreg`.`tblstudinfo`
SET
  `Fname` = paramfname,
  `Mi` = parammi,
  `Lname` = paramlname,
  `Birthday` = parambday,
  `Address` = paramaddress
WHERE `Id` = paramid;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `Sproc_UpdateRecord` */

/*!50003 DROP PROCEDURE IF EXISTS  `Sproc_UpdateRecord` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `Sproc_UpdateRecord`(
    ParamId varchar(50),
    ParamFname varchar(50),
    ParamMi CHAR(2),
    ParamLname VARCHAR(50),
    ParamBirthday date,
    ParamAddress VARCHAR(100)
    )
BEGIN
	
	UPDATE
  `studentreg`.`tblstudinfo`
SET
  
  `Fname` = ParamFname,
  `Mi` = ParamMi,
  `Lname` = ParamLname,
  `Birthday` = ParamBirthday,
  `Address` = ParamAddress
WHERE `Id` = ParamId;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sproc_update_student` */

/*!50003 DROP PROCEDURE IF EXISTS  `sproc_update_student` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sproc_update_student`(
	paramId varchar(50),
        paramFname VARCHAR(50),
	paramMi CHAR(2),
	paramLname VARCHAR(50),
	paramBirthday DATE,
	paramAddress VARCHAR(100)
	
    )
BEGIN
		UPDATE
			  `studentreg`.`tblstudinfo`
			SET
			  
			  `Fname` = paramFname,
			  `Mi` = paramMi,
			  `Lname` = paramLname,
			  `Birthday` = paramBirthday,
			  `Address` = paramAddress
			WHERE `Id` = paramId;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `sproc_Variables` */

/*!50003 DROP PROCEDURE IF EXISTS  `sproc_Variables` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sproc_Variables`(
    
    )
BEGIN
	DECLARE sample1 VARCHAR(20);
	
	SET sample1 = 'Welcome to DBMS';
	
	SET @sample2 = 'Parameter';
	
	SELECT CONCAT(sample1,'',CURRENT_TIME(),' ',@sample2);
	END */$$
DELIMITER ;

/*Table structure for table `view_twotables` */

DROP TABLE IF EXISTS `view_twotables`;

/*!50001 DROP VIEW IF EXISTS `view_twotables` */;
/*!50001 DROP TABLE IF EXISTS `view_twotables` */;

/*!50001 CREATE TABLE  `view_twotables`(
 `Id` varchar(50) ,
 `Fname` varchar(50) ,
 `Mi` char(2) ,
 `Lname` varchar(50) ,
 `Birthday` date ,
 `Address` varchar(100) ,
 `ContactID` varchar(30) ,
 `Contact` varchar(50) 
)*/;

/*Table structure for table `viewspeccol` */

DROP TABLE IF EXISTS `viewspeccol`;

/*!50001 DROP VIEW IF EXISTS `viewspeccol` */;
/*!50001 DROP TABLE IF EXISTS `viewspeccol` */;

/*!50001 CREATE TABLE  `viewspeccol`(
 `Id` varchar(50) ,
 `Fname` varchar(50) ,
 `Mi` char(2) ,
 `Lname` varchar(50) ,
 `Contact` varchar(50) 
)*/;

/*View structure for view view_twotables */

/*!50001 DROP TABLE IF EXISTS `view_twotables` */;
/*!50001 DROP VIEW IF EXISTS `view_twotables` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_twotables` AS (select distinct `tblstudinfo`.`Id` AS `Id`,`tblstudinfo`.`Fname` AS `Fname`,`tblstudinfo`.`Mi` AS `Mi`,`tblstudinfo`.`Lname` AS `Lname`,`tblstudinfo`.`Birthday` AS `Birthday`,`tblstudinfo`.`Address` AS `Address`,`tblcontact`.`ContactID` AS `ContactID`,`tblcontact`.`Contact` AS `Contact` from (`tblstudinfo` join `tblcontact`)) */;

/*View structure for view viewspeccol */

/*!50001 DROP TABLE IF EXISTS `viewspeccol` */;
/*!50001 DROP VIEW IF EXISTS `viewspeccol` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewspeccol` AS (select `tblstudinfo`.`Id` AS `Id`,`tblstudinfo`.`Fname` AS `Fname`,`tblstudinfo`.`Mi` AS `Mi`,`tblstudinfo`.`Lname` AS `Lname`,`tblcontact`.`Contact` AS `Contact` from (`tblstudinfo` join `tblcontact`)) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
