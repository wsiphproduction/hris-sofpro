--PLEASE FOLLOW THE STEPS FROM [1] - [4]
--[1] FIND TABLE CONSTRAINTS=========================================================================
SELECT TABLE_NAME,
       CONSTRAINT_TYPE,CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='shifts';

-- DELETE THE CONSTRAINT KEY==========================================================================
--[2] ALTER TABLE shifts DROP CONSTRAINT PK__shifts__3213E83FA1E15211

-- SELECT ALL DUPLICATE SHIFTS =======================================================================
SELECT user_id,date, COUNT(*)  
FROM shifts
GROUP BY user_id,date
HAVING COUNT(*) > 1
ORDER BY date DESC

--[3] DELETE DUPLICATE SHIFTS ========================================================================
-- DECLARE VARIABLES ***********************
DECLARE @DUPLICATE_SHIFTS TABLE(ID INT IDENTITY(1,1),USER_ID VARCHAR(60), DATE VARCHAR(60), TOTAL INT)
DECLARE @COUNTER AS INT, @LAST_INDEX AS INT, @NUM_DELETE AS INT, @USER_ID AS VARCHAR(60), @DATE AS VARCHAR(60), @TOTAL AS INT

SET @COUNTER = 1

-- FIND THE DUPLICATE SHIFTS ***************
INSERT INTO @DUPLICATE_SHIFTS(USER_ID,DATE,TOTAL)
SELECT user_id,date, COUNT(*)  
FROM shifts
GROUP BY user_id,date
HAVING COUNT(*) > 1

-- PROCESS ********************************
-- DELETE DUPLICATE
-- DELETE TSS_DATA
SELECT @LAST_INDEX = COUNT(*) FROM @DUPLICATE_SHIFTS
WHILE (@COUNTER <= @LAST_INDEX)
BEGIN
	SELECT @USER_ID = user_id, @DATE = date, @TOTAL = TOTAL FROM @DUPLICATE_SHIFTS WHERE ID = @COUNTER 
	SET @NUM_DELETE = @TOTAL - 1

	-- DELETE DOUBLE SHIFTS
	DELETE TOP(@NUM_DELETE) FROM shifts WHERE user_id = @USER_ID AND date = @DATE

	-- DELETE TSS_DATA
	DELETE FROM tss_data WHERE user_id = @USER_ID AND date = @DATE

	SET @COUNTER = @COUNTER + 1
END

--[4] ADD CONSTRAINT TO SHIFT_TABLE ==================================================================
ALTER TABLE shifts 
ADD CONSTRAINT PK_date_user_id
PRIMARY KEY (date,user_id)




-- FOR TESTING ONLY ==================================================================================

-- TEST IF THE CONSTRAINT WORKS 
-- INSERT DUPLICATE SHIFTS
INSERT INTO shifts (user_id,date,created_at) 
VALUES ('3573','2022-12-15','2022-12-14 00:50:02.690'),
('3573','2022-12-14','2022-12-14 00:50:02.690')


-- FIND IF THE INSERTED DATA ALLOWS 1 SHIFT ONLY
SELECT * FROM shifts WHERE id > '517905' ORDER BY id DESC
--DELETE TOP(2) FROM shifts WHERE id > '517905' 


SELECT * FROM shifts WHERE user_id = '3573' AND date = '2022-12-14'
--DELETE FROM shifts WHERE id = '30883'

