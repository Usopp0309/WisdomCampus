DELIMITER $$

DROP FUNCTION IF EXISTS `getUpperNum`$$

CREATE DEFINER=`palmSchool`@`121.199.27.191` FUNCTION `getUpperNum`(`in_num` INTEGER) RETURNS VARCHAR(5) CHARSET utf8
BEGIN
	DECLARE out_num VARCHAR(5);
 	IF in_num = 0 THEN  		SET out_num = '一';	
 	ELSEIF in_num = 1 THEN 		SET out_num = '二'; 	
 	ELSEIF in_num = 2 THEN 		SET out_num='三'; 	
 	ELSEIF in_num = 3 THEN 		SET out_num='四'; 	
 	ELSEIF in_num = 4 THEN 		SET out_num='五'; 	
 	ELSEIF in_num = 5 THEN 		SET out_num='六'; 	
 	ELSEIF in_num = 6 THEN 		SET out_num='七'; 	
 	ELSEIF in_num = 7 THEN 		SET out_num='八'; 	
 	ELSEIF in_num = 8 THEN 		SET out_num='九'; 	
 	END IF; 			
RETURN out_num; 

END$$

DELIMITER ;