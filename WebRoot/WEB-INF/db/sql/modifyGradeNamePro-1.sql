DELIMITER $$

DROP PROCEDURE IF EXISTS `modifyGradeNamePro`$$

CREATE PROCEDURE `modifyGradeNamePro`()
BEGIN 
	DECLARE currentMonth, currentYear,gradeYear,gradeId,gradeType, betweenYear INT; 
	DECLARE gradeCreateYear VARCHAR(50); 
	DECLARE done INT DEFAULT 0; 
	DECLARE cur_1 CURSOR FOR SELECT id FROM palm_grade WHERE state=0; 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1; 
	SELECT MONTH(NOW()) INTO currentMonth; 
	SELECT YEAR(NOW()) INTO currentYear; 
	OPEN cur_1; 
	 REPEAT 
	 FETCH cur_1 INTO gradeId; 
	 IF NOT done THEN 
		SELECT createYear,TYPE INTO gradeCreateYear , gradeType FROM palm_grade WHERE id=gradeId; 
		IF LENGTH(gradeCreateYear) > 4 THEN 
							IF currentMonth = 8 THEN 
								SELECT (currentYear- CONVERT(LEFT(gradeCreateYear,4),SIGNED)) INTO betweenYear; 
								IF gradeType = '0' THEN 
									IF betweenYear > 2 THEN 
										UPDATE palm_grade SET NAME='大班' ,state=1 ,updateTime=NOW() WHERE id=gradeId; 
									ELSEIF betweenYear = 2 THEN 
										UPDATE palm_grade SET NAME='大班',updateTime=NOW() WHERE id=gradeId;
									ELSEIF betweenYear = 1 THEN 
										UPDATE palm_grade SET NAME='中班',updateTime=NOW() WHERE id=gradeId; 
									ELSE 
										UPDATE palm_grade SET NAME='小班',updateTime=NOW() WHERE id=gradeId; 
									END IF; 
								ELSEIF gradeType='1' THEN 
									IF betweenYear > 5 THEN 
											UPDATE palm_grade SET NAME='六年级' ,state=1 ,updateTime=NOW() WHERE id=gradeId; 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear),'年级'),updateTime=NOW() WHERE id=gradeId; 
									END IF; 
								ELSEIF gradeType = '2' THEN 
									IF betweenYear > 2 THEN 
											UPDATE palm_grade SET NAME='九年级',state=1 ,updateTime=NOW() WHERE id=gradeId; 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear+6),'年级'),updateTime=NOW() WHERE id=gradeId; 
									END IF; 
								ELSE 									
									IF betweenYear > 2 THEN 
											UPDATE palm_grade SET NAME='三年级',state=1,updateTime=NOW() WHERE id=gradeId;
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear),'年级'),updateTime=NOW() WHERE id=gradeId; 
									END IF; 
								END IF; 			
							END IF;					
		ELSEIF 	LENGTH(gradeCreateYear) = 4 THEN 
							IF currentMonth = 8 THEN 
								SELECT (currentYear- CONVERT(gradeCreateYear,SIGNED)) INTO betweenYear; 
								IF gradeType = '0' THEN 
									IF betweenYear > 2 THEN 
										UPDATE palm_grade SET NAME='大班' ,state=1 ,updateTime=NOW() WHERE id=gradeId; 
									ELSEIF betweenYear = 2 THEN 
										UPDATE palm_grade SET NAME='大班' ,updateTime=NOW() WHERE id=gradeId; 
									ELSEIF betweenYear = 1 THEN 
										UPDATE palm_grade SET NAME='中班' ,updateTime=NOW() WHERE id=gradeId;
									ELSE 
										UPDATE palm_grade SET NAME='小班' ,updateTime=NOW() WHERE id=gradeId;
									END IF;
								ELSEIF gradeType='1' THEN
									IF betweenYear > 5 THEN 
											UPDATE palm_grade SET NAME='六年级' ,state=1 ,updateTime=NOW() WHERE id=gradeId; 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear),'年级') ,updateTime=NOW() WHERE id=gradeId; 
									END IF; 
								ELSEIF gradeType = '2' THEN 
									IF betweenYear > 2 THEN 
											UPDATE palm_grade SET NAME='九年级' ,state=1 ,updateTime=NOW() WHERE id=gradeId; 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear+6),'年级') ,updateTime=NOW() WHERE id=gradeId; 
									END IF; 								
								ELSE 
									IF betweenYear > 2 THEN 
											UPDATE palm_grade SET NAME='三年级',state=1 ,updateTime=NOW() WHERE id=gradeId; 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear),'年级') ,updateTime=NOW() WHERE id=gradeId; 
									END IF;
								END IF; 
							END IF; 						
		END IF;
	END IF; 
	UNTIL done END REPEAT;
	CLOSE cur_1;
END$$

DELIMITER ;