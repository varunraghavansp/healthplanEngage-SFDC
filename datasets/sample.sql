BEGIN TRANSACTION;
CREATE TABLE "Product2" (
	id INTEGER NOT NULL, 
	"Name" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Product2" VALUES(1,'Medical Plan');
CREATE TABLE "Account" (
	id INTEGER NOT NULL, 
	"Active__c" VARCHAR(255), 
	"Effective_Date__c" VARCHAR(255), 
	"Group_Category__c" VARCHAR(255), 
	"Legal_Entity_Name__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"NumberofLocations__c" VARCHAR(255), 
	"Status__c" VARCHAR(255), 
	"TIN_EIN__c" VARCHAR(255), 
	"IsPersonAccount" VARCHAR(255), 
	"ParentId" VARCHAR(255), 
	"Rating_Zipcode__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Account" VALUES(1,'False','2020-03-01','Large Group','Salada Biomedical Incorporated','Salada Biomedical Inc','3.0','Active','553123111','False','','5');
INSERT INTO "Account" VALUES(2,'False','2020-03-01','Large Group','Wood Stream Corp','Woodstream Corp','1.0','Active','553123111','False','','5');
CREATE TABLE "Account_Agency__c" (
	id INTEGER NOT NULL, 
	"Commission_Split__c" VARCHAR(255), 
	"Effective_Date__c" VARCHAR(255), 
	"Is_Primary__c" VARCHAR(255), 
	"Termination_Date__c" VARCHAR(255), 
	"Agency__c" VARCHAR(255), 
	"Customer_Account__c" VARCHAR(255), 
	PRIMARY KEY (id)
);

CREATE TABLE "Account_Agent__c" (
	id INTEGER NOT NULL, 
	"Effective_Date__c" VARCHAR(255), 
	"Is_Primary__c" VARCHAR(255), 
	"Termination_Date__c" VARCHAR(255), 
	"Account_Agency__c" VARCHAR(255), 
	"Agent__c" VARCHAR(255), 
	"Customer_Account__c" VARCHAR(255), 
	PRIMARY KEY (id)
);

CREATE TABLE "Alternate_Plan_Mapping__c" (
	id INTEGER NOT NULL, 
	"Alternate_Package_Code__c" VARCHAR(255), 
	"Effective_From__c" VARCHAR(255), 
	"Effective_To__c" VARCHAR(255), 
	"Mapping_Type__c" VARCHAR(255), 
	"Package_Code__c" VARCHAR(255), 
	"Alternate_Plan_Family__c" VARCHAR(255), 
	"Plan_Family__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(1,'COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','7','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(2,'COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','7','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(3,'COINS20/50 DED0/1000','2021-01-01','','Alternate','COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','9','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(4,'DED100/1000 COINS30/60','2021-01-01','','Alternate','COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','10','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(5,'COINS25/75 DED100/1000','2021-01-01','','Alternate','COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','13','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(6,'COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','2021-01-01','','Straight Renewal','COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','7','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(7,'COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','2021-01-01','','Alternate','COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','7','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(8,'COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','7','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(9,'COINS20/50 DED0/1000','2021-01-01','','Alternate','COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','9','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(10,'DED100/1000 COINS30/60','2021-01-01','','Alternate','COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','10','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(11,'COINS25/75 DED100/1000','2021-01-01','','Alternate','COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','13','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(12,'COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','2021-01-01','','Straight Renewal','COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','7','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(13,'COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','2021-01-01','','Alternate','COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','7','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(14,'COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','7','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(15,'COINS20/50 DED0/1000','2021-01-01','','Alternate','COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','9','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(16,'DED100/1000 COINS30/60','2021-01-01','','Alternate','COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','10','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(17,'COINS25/75 DED100/1000','2021-01-01','','Alternate','COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','13','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(18,'COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','2021-01-01','','Straight Renewal','COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','7','7');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(19,'COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','2021-01-01','','Alternate','COINS20/50 DED0/1000','7','9');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(20,'COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','COINS20/50 DED0/1000','7','9');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(21,'COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','COINS20/50 DED0/1000','7','9');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(22,'DED100/1000 COINS30/60','2021-01-01','','Alternate','COINS20/50 DED0/1000','10','9');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(23,'COINS25/75 DED100/1000','2021-01-01','','Alternate','COINS20/50 DED0/1000','13','9');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(24,'DED100/1000 COINS30/60','2021-01-01','','Straight Renewal','DED100/1000 COINS30/60','10','10');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(25,'COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','2021-01-01','','Alternate','DED100/1000 COINS30/60','7','10');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(26,'COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','DED100/1000 COINS30/60','7','10');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(27,'COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','DED100/1000 COINS30/60','7','10');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(28,'COINS20/50 DED0/1000','2021-01-01','','Alternate','DED100/1000 COINS30/60','9','10');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(29,'COINS25/75 DED100/1000','2021-01-01','','Alternate','DED100/1000 COINS30/60','13','10');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(30,'COINS25/75 DED100/1000','2021-01-01','','Straight Renewal','COINS25/75 DED100/1000','13','13');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(31,'DED100/1000 COINS30/60','2021-01-01','','Alternate','COINS25/75 DED100/1000','10','13');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(32,'COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','2021-01-01','','Alternate','COINS25/75 DED100/1000','7','13');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(33,'COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','COINS25/75 DED100/1000','7','13');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(34,'COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','2021-01-01','','Alternate','COINS25/75 DED100/1000','7','13');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(35,'COINS20/50 DED0/1000','2021-01-01','','Alternate','COINS25/75 DED100/1000','9','13');
INSERT INTO "Alternate_Plan_Mapping__c" VALUES(36,'COINS20/50 DED0/1000','2021-01-01','','Straight Renewal','COINS20/50 DED0/1000','9','9');
CREATE TABLE "Attribute_Value__c" (
	id INTEGER NOT NULL, 
	"Attribute_Value__c" VARCHAR(255), 
	"Effective_Date__c" VARCHAR(255), 
	"In_Network_Display_Value__c" VARCHAR(255), 
	"In_Network_Value__c" VARCHAR(255), 
	"Limits_And_Exceptions_Text_Area__c" VARCHAR(255), 
	"Limits_And_Exceptions__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Out_Of_Network_Display_Value__c" VARCHAR(255), 
	"Out_Of_Network_Value__c" VARCHAR(255), 
	"Attribute__c" VARCHAR(255), 
	"Plan_Family__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Attribute_Value__c" VALUES(179,'25/40','','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ACV25/40','Deductible then 40% coinsurance','25','2','7');
INSERT INTO "Attribute_Value__c" VALUES(180,'DED25/40','','Network A: Deductible then $25/$40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ACVDED25/40','Deductible then 40% coinsurance','DED25','2','7');
INSERT INTO "Attribute_Value__c" VALUES(181,'20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ACV20/40','Deductible then 40% coinsurance','20','2','7');
INSERT INTO "Attribute_Value__c" VALUES(182,'50/40','','Network A: 50% coinsurance Network B: Deductible then 50% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ADME50/40','Deductible then 40% coinsurance','50','3','7');
INSERT INTO "Attribute_Value__c" VALUES(183,'DED50/40','','Network A: Deductible then 50% coinsurance Network B: Deductible then 50% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ADMEDED50/40','Deductible then 40% coinsurance','DED50','3','7');
INSERT INTO "Attribute_Value__c" VALUES(184,'40/40','','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','AHHC40/40','Deductible then 40% coinsurance','40','4','7');
INSERT INTO "Attribute_Value__c" VALUES(185,'DED40/40','','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','AHHCDED40/40','Deductible then 40% coinsurance','DED40','4','7');
INSERT INTO "Attribute_Value__c" VALUES(186,'20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','AHHC20/40','Deductible then 40% coinsurance','20','4','7');
INSERT INTO "Attribute_Value__c" VALUES(187,'50/40','','Network A: 50% coinsurance Network B: Deductible then 50% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','APA50/40','Deductible then 40% coinsurance','50','5','7');
INSERT INTO "Attribute_Value__c" VALUES(188,'DED50/40','','Network A: Deductible then 50% coinsurance Network B: Deductible then 50% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','APADED50/40','Deductible then 40% coinsurance','DED50','5','7');
INSERT INTO "Attribute_Value__c" VALUES(189,'250/NC','','Option 1: $250 gym/wellness services allowance Option 2: Up to $500 per individual/$1,000 per family earned from the purchase of fresh produce','NC','Not Covered','Not Covered','AUB250/NC','Not Covered','250','6','7');
INSERT INTO "Attribute_Value__c" VALUES(190,'30/NC','','$30 allowance per plan year towards the purchase of meals aquired from Zipongo.','NC','Not Covered','Not Covered','ZPO30/NC','Not Covered','30','7','7');
INSERT INTO "Attribute_Value__c" VALUES(191,'90/NC','','$90 allowance','NC','Not Covered','Not Covered','AV-C90/NC','Not Covered','90','8','7');
INSERT INTO "Attribute_Value__c" VALUES(192,'60/NC','','$60 allowance','NC','Not Covered','Not Covered','AV-F60/NC','Not Covered','60','9','7');
INSERT INTO "Attribute_Value__c" VALUES(193,'15/NC','','15% discount','NC','Not Covered','Not Covered','AV-LV15/NC','Not Covered','15','10','7');
INSERT INTO "Attribute_Value__c" VALUES(218,'40/40','','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','AV-ME40/40','Deductible then 40% coinsurance','40','11','7');
INSERT INTO "Attribute_Value__c" VALUES(219,'DED40/40','','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','AV-MEDED40/40','Deductible then 40% coinsurance','DED40','11','7');
INSERT INTO "Attribute_Value__c" VALUES(220,'20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','AV-ME20/40','Deductible then 40% coinsurance','20','11','7');
INSERT INTO "Attribute_Value__c" VALUES(221,'0/NC','','$0 copay / visit','NC','Not Covered','Not Covered','AV-RE0/NC','Not Covered','0','12','7');
INSERT INTO "Attribute_Value__c" VALUES(222,'10/NC','','Single: $10 Bifocal: $10','NC','Not Covered','Not Covered','AV-SPL10/NC','Not Covered','10','13','7');
INSERT INTO "Attribute_Value__c" VALUES(223,'0/NA','','Based on services rendered','NA','','','DS-AD0/NA','Based on services rendered','0','14','7');
INSERT INTO "Attribute_Value__c" VALUES(224,'NC/NC','','Not Covered','NC','Not Covered','Not Covered','DS-PRNC/NC','Not Covered','NC','15','7');
INSERT INTO "Attribute_Value__c" VALUES(225,'26/26','','26','26','26','26','DEP26/26','26','26','16','7');
INSERT INTO "Attribute_Value__c" VALUES(226,'25/40','','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DE25/40','Deductible then 40% coinsurance','25','17','7');
INSERT INTO "Attribute_Value__c" VALUES(227,'DED25/40','','Network A: Deductible then $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DEDED25/40','Deductible then 40% coinsurance','DED25','17','7');
INSERT INTO "Attribute_Value__c" VALUES(228,'20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DE20/40','Deductible then 40% coinsurance','20','17','7');
INSERT INTO "Attribute_Value__c" VALUES(229,'25/40','','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DIO25/40','Deductible then 40% coinsurance','25','18','7');
INSERT INTO "Attribute_Value__c" VALUES(230,'DED25/40','','Network A: Deductible then $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DIODED25/40','Deductible then 40% coinsurance','DED25','18','7');
INSERT INTO "Attribute_Value__c" VALUES(231,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DIODED20/40','Deductible then 40% coinsurance','DED20','18','7');
INSERT INTO "Attribute_Value__c" VALUES(232,'25/40','','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DMS25/40','Deductible then 40% coinsurance','25','19','7');
INSERT INTO "Attribute_Value__c" VALUES(233,'DED25/40','','Network A: Deductible then $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DMSDED25/40','Deductible then 40% coinsurance','DED25','19','7');
INSERT INTO "Attribute_Value__c" VALUES(234,'20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DMS20/40','Deductible then 40% coinsurance','20','19','7');
INSERT INTO "Attribute_Value__c" VALUES(235,'100/40','','Network A: $100 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','AR100/40','Deductible then 40% coinsurance','100','20','7');
INSERT INTO "Attribute_Value__c" VALUES(236,'DED140/40','','Network A: Deductible then $140 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ARDED140/40','Deductible then 40% coinsurance','DED140','20','7');
INSERT INTO "Attribute_Value__c" VALUES(237,'DED100/40','','Network A: Deductible then $100 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ARDED100/40','Deductible then 40% coinsurance','DED100','20','7');
INSERT INTO "Attribute_Value__c" VALUES(238,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ARDED20/40','Deductible then 40% coinsurance','DED20','20','7');
INSERT INTO "Attribute_Value__c" VALUES(239,'0/40','','Network A: $0 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DT0/40','Deductible then 40% coinsurance','0','21','7');
INSERT INTO "Attribute_Value__c" VALUES(240,'DED0/40','','Network A: Deductible then $0 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DTDED0/40','Deductible then 40% coinsurance','DED0','21','7');
INSERT INTO "Attribute_Value__c" VALUES(263,'20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','DT20/40','Deductible then 40% coinsurance','20','21','7');
INSERT INTO "Attribute_Value__c" VALUES(264,'25/40','','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','EKG25/40','Deductible then 40% coinsurance','25','22','7');
INSERT INTO "Attribute_Value__c" VALUES(265,'DED25/40','','Network A: Deductible then $25/$40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','EKGDED25/40','Deductible then 40% coinsurance','DED25','22','7');
INSERT INTO "Attribute_Value__c" VALUES(266,'0/40','','Network A: Deductible then $0 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','EKG0/40','Deductible then 40% coinsurance','0','22','7');
INSERT INTO "Attribute_Value__c" VALUES(267,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','EKGDED20/40','Deductible then 40% coinsurance','DED20','22','7');
INSERT INTO "Attribute_Value__c" VALUES(268,'40/40','','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RR40/40','Deductible then 40% coinsurance','40','23','7');
INSERT INTO "Attribute_Value__c" VALUES(269,'DED40/40','','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RRDED40/40','Deductible then 40% coinsurance','DED40','23','7');
INSERT INTO "Attribute_Value__c" VALUES(270,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RRDED20/40','Deductible then 40% coinsurance','DED20','23','7');
INSERT INTO "Attribute_Value__c" VALUES(271,'150/150','','Network A: $150 copay / visit Network B: $150 copay / visit','150','$150 copay / visit','$150 copay / visit','ER150/150','$150 copay / visit','150','24','7');
INSERT INTO "Attribute_Value__c" VALUES(272,'DED150/DED150','','Network A: Deductible then $150 copay / visit Network B: Deductible then $150 copay / visit','DED150','Deductible then $150 copay / visit','Deductible then $150 copay / visit','ERDED150/DED150','Deductible then $150 copay / visit','DED150','24','7');
INSERT INTO "Attribute_Value__c" VALUES(273,'DED20/DED20','','Network A: Deductible then 20% coinsurance Network B: Deductible then 20% coinsurance','DED20','Deductible then 20% coinsurance','Deductible then 20% coinsurance','ERDED20/DED20','Deductible then 20% coinsurance','DED20','24','7');
INSERT INTO "Attribute_Value__c" VALUES(297,'150/150','','Network A: $150 copay / trip Network B: $150 copay / trip','150','$150 copay / trip','$150 copay / trip','ERT150/150','$150 copay / trip','150','25','7');
INSERT INTO "Attribute_Value__c" VALUES(298,'DED150/150','','Network A: Deductible then $150 copay / trip Network B: Deductible then $150 copay / trip','150','Deductible then $150 copay / trip','Deductible then $150 copay / trip','ERTDED150/150','Deductible then $150 copay / trip','DED150','25','7');
INSERT INTO "Attribute_Value__c" VALUES(299,'DED200/200','','Network A: Deductible then $200 copay / trip Network B: Deductible then $200 copay / trip','200','Deductible then $200 copay / trip','Deductible then $200 copay / trip','ERTDED200/200','Deductible then $200 copay / trip','DED200','25','7');
INSERT INTO "Attribute_Value__c" VALUES(300,'DED20/20','','Network A: Deductible then 20% coinsurance Network B: Deductible then 20% coinsurance','20','Deductible then 20% coinsurance','Deductible then 20% coinsurance','ERTDED20/20','Deductible then 20% coinsurance','DED20','25','7');
INSERT INTO "Attribute_Value__c" VALUES(301,'75/75','','Network A: $75 copay / visit Network B: Deductible then 40% coinsurance','75','$75 copay / visit','$75 copay / visit','UCC75/75','$75 copay / visit','75','26','7');
INSERT INTO "Attribute_Value__c" VALUES(302,'DED75/DED75','','Network A: Deductible then $75 copay / visit Network B: Deductible then 40% coinsurance','DED75','Deductible then $75 copay / visit','Deductible then $75 copay / visit','UCCDED75/DED75','Deductible then $75 copay / visit','DED75','26','7');
INSERT INTO "Attribute_Value__c" VALUES(303,'20/20','','Network A: 20% coinsurance Network B: 40% coinsurance','20','20% coinsurance','20% coinsurance','UCC20/20','20% coinsurance','20','26','7');
INSERT INTO "Attribute_Value__c" VALUES(304,'NA/NA','','Not Applicable','NA','Not Applicable','Not Applicable','APLNA/NA','Not Applicable','NA','27','7');
INSERT INTO "Attribute_Value__c" VALUES(305,'40/40','','Network A: Applies Where Indicated Network B: 40%','40','40%','40%','COINS40/40','40%','40','28','7');
INSERT INTO "Attribute_Value__c" VALUES(306,'20/40','','Network A: 20% Network B: 40%','40','40%','40%','COINS20/40','40%','20','28','7');
INSERT INTO "Attribute_Value__c" VALUES(307,'0/1000','','Network A: $0 Network B: $1,000 / $2,000','0','$1,000 / $2,000','$1,000 / $2,000','DED0/1000','$1,000 / $2,000','1000','29','7');
INSERT INTO "Attribute_Value__c" VALUES(308,'1500/1500','','Network A: $500 / $1,000 Network B: $1,500 / $3,000','1500','$1,500 / $3,000','$1,500 / $3,000','DED1500/1500','$1,500 / $3,000','1500','29','7');
INSERT INTO "Attribute_Value__c" VALUES(309,'1500/3000','','Network A: $1,500 / $3,000 Network B: $3,000 / $6,000','1500','$3,000 / $6,000','$3,000 / $6,000','DED1500/3000','$3,000 / $6,000','3000','29','7');
INSERT INTO "Attribute_Value__c" VALUES(310,'5000/10000','','Network A: $5,000 / $10,000 Network B: $10,000 / $15,000','5000','$10,000 / $15,000','$10,000 / $15,000','DED5000/10000','$10,000 / $15,000','10000','29','7');
INSERT INTO "Attribute_Value__c" VALUES(311,'0/DED40','','Network A: $5,000 / $10,000 Network B: $6,350 / $12,700','DED40','$10,000 / $20,000','$10,000 / $20,000','MOOP0/DED40','$10,000 / $20,000','0','30','7');
INSERT INTO "Attribute_Value__c" VALUES(312,'0/DED40','','Network A: $0 copay / admission Network B: Deductible then 40% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','INHSPS0/DED40','Deductible then 40% coinsurance','0','31','7');
INSERT INTO "Attribute_Value__c" VALUES(313,'DED0/40','','Network A: Deductible then $0 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','INHSPSDED0/40','Deductible then 40% coinsurance','DED0','31','7');
INSERT INTO "Attribute_Value__c" VALUES(314,'500/40','','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','INP500/40','Deductible then 40% coinsurance','500','32','7');
INSERT INTO "Attribute_Value__c" VALUES(315,'DED500/40','','Network A: Deductible then $500 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','INPDED500/40','Deductible then 40% coinsurance','DED500','32','7');
INSERT INTO "Attribute_Value__c" VALUES(316,'DED1000/40','','Network A: Deductible then $1,000 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','INPDED1000/40','Deductible then 40% coinsurance','DED1000','32','7');
INSERT INTO "Attribute_Value__c" VALUES(317,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','INPDED20/40','Deductible then 40% coinsurance','DED20','32','7');
INSERT INTO "Attribute_Value__c" VALUES(318,'0/40','','Network A: $0 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','INPP0/40','Deductible then 40% coinsurance','0','33','7');
INSERT INTO "Attribute_Value__c" VALUES(319,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','INPPDED20/40','Deductible then 40% coinsurance','DED20','33','7');
INSERT INTO "Attribute_Value__c" VALUES(320,'125/40','','Network A: $125 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-A125/40','Deductible then 40% coinsurance','125','34','7');
INSERT INTO "Attribute_Value__c" VALUES(321,'DED175/40','','Network A: Deductible then $175 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-ADED175/40','Deductible then 40% coinsurance','DED175','34','7');
INSERT INTO "Attribute_Value__c" VALUES(322,'DED125/40','','Network A: Deductible then $125 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-ADED125/40','Deductible then 40% coinsurance','DED125','34','7');
INSERT INTO "Attribute_Value__c" VALUES(323,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-ADED20/40','Deductible then 40% coinsurance','DED20','34','7');
INSERT INTO "Attribute_Value__c" VALUES(324,'150/40','','Network A: $150 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-H150/40','Deductible then 40% coinsurance','150','35','7');
INSERT INTO "Attribute_Value__c" VALUES(325,'DED200/40','','Network A: Deductible then $200 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-HDED200/40','Deductible then 40% coinsurance','DED200','35','7');
INSERT INTO "Attribute_Value__c" VALUES(326,'DED150/40','','Network A: Deductible then $150 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-HDED150/40','Deductible then 40% coinsurance','DED150','35','7');
INSERT INTO "Attribute_Value__c" VALUES(327,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-HDED20/40','Deductible then 40% coinsurance','DED20','35','7');
INSERT INTO "Attribute_Value__c" VALUES(328,'0/40','','Network A: $0 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-P0/40','Deductible then 40% coinsurance','0','36','7');
INSERT INTO "Attribute_Value__c" VALUES(329,'DED0/40','','Network A: Deductible then $0 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-PDED0/40','Deductible then 40% coinsurance','DED0','36','7');
INSERT INTO "Attribute_Value__c" VALUES(330,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OSP-PDED20/40','Deductible then 40% coinsurance','DED20','36','7');
INSERT INTO "Attribute_Value__c" VALUES(331,'250/40','','Network A: $250 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','SNF250/40','Deductible then 40% coinsurance','250','37','7');
INSERT INTO "Attribute_Value__c" VALUES(332,'DED500/40','','Network A: Deductible then $500 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','SNFDED500/40','Deductible then 40% coinsurance','DED500','37','7');
INSERT INTO "Attribute_Value__c" VALUES(333,'DED250/40','','Network A: Deductible then $250 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','SNFDED250/40','Deductible then 40% coinsurance','DED250','37','7');
INSERT INTO "Attribute_Value__c" VALUES(334,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','SNFDED20/40','Deductible then 40% coinsurance','DED20','37','7');
INSERT INTO "Attribute_Value__c" VALUES(335,'500/40','','Delivery: Network A: $500 copay / admission Physician: Network A: $0 copay / procedure Delivery: Network B: Deductible then 40% coinsurance Physician: Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PPS-F500/40','Deductible then 40% coinsurance','500','38','7');
INSERT INTO "Attribute_Value__c" VALUES(336,'DED1000/40','','Delivery: Network A: Deductible then $1000 copay / admission Physician: Network A: Deductible then $0 copay / procedure Delivery: Network B: Deductible then 40% coinsurance Physician: Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PPS-FDED1000/40','Deductible then 40% coinsurance','DED1000','38','7');
INSERT INTO "Attribute_Value__c" VALUES(337,'DED40/40','','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PPS-FDED40/40','Deductible then 40% coinsurance','DED40','38','7');
INSERT INTO "Attribute_Value__c" VALUES(338,'DED20/40','','Delivery: Network A: Deductible then 20% coinsurance Physician: Network A: Deductible then $0 coinsurance Delivery: Network B: Deductible then 40% coinsurance Physician: Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PPS-FDED20/40','Deductible then 40% coinsurance','DED20','38','7');
INSERT INTO "Attribute_Value__c" VALUES(339,'DED0/40','','Network A: $0 copay / visit Network B: Deductible then $0 copay / visit','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PPS-OVDED0/40','Deductible then 40% coinsurance','DED0','39','7');
INSERT INTO "Attribute_Value__c" VALUES(340,'0/40','','Network A: $0 copay / visit Network B: $0 copay / visit','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PPS-OV0/40','Deductible then 40% coinsurance','0','39','7');
INSERT INTO "Attribute_Value__c" VALUES(341,'DED00/40','','Network A: Deductible then $0 copay / visit Network B: Deductible then $0 copay / visit','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PPS-OVDED00/40','Deductible then 40% coinsurance','DED00','39','7');
INSERT INTO "Attribute_Value__c" VALUES(342,'500/40','','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MBHI500/40','Deductible then 40% coinsurance','500','40','7');
INSERT INTO "Attribute_Value__c" VALUES(343,'DED1000/40','','Network A: Deductible then $1,000 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MBHIDED1000/40','Deductible then 40% coinsurance','DED1000','40','7');
INSERT INTO "Attribute_Value__c" VALUES(344,'DED500/40','','Facility Network A: Deductible then $500 copay / admission Network B: Deductible then 40% coinsurance Physician Network A: Deductible then $0 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MBHIDED500/40','Deductible then 40% coinsurance','DED500','40','7');
INSERT INTO "Attribute_Value__c" VALUES(345,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MBHIDED20/40','Deductible then 40% coinsurance','DED20','40','7');
INSERT INTO "Attribute_Value__c" VALUES(346,'25/40','','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MBHO25/40','Deductible then 40% coinsurance','25','41','7');
INSERT INTO "Attribute_Value__c" VALUES(347,'DED25/40','','Network A: Deductible then $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MBHODED25/40','Deductible then 40% coinsurance','DED25','41','7');
INSERT INTO "Attribute_Value__c" VALUES(348,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MBHODED20/40','Deductible then 40% coinsurance','DED20','41','7');
INSERT INTO "Attribute_Value__c" VALUES(349,'500/40','','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MISD500/40','Deductible then 40% coinsurance','500','42','7');
INSERT INTO "Attribute_Value__c" VALUES(350,'DED1000/40','','Network A: Deductible then $1,000 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MISDDED1000/40','Deductible then 40% coinsurance','DED1000','42','7');
INSERT INTO "Attribute_Value__c" VALUES(351,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MISDDED20/40','Deductible then 40% coinsurance','DED20','42','7');
INSERT INTO "Attribute_Value__c" VALUES(352,'500/40','','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MISR500/40','Deductible then 40% coinsurance','500','43','7');
INSERT INTO "Attribute_Value__c" VALUES(353,'DED1000/40','','Network A: Deductible then $1,000 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MISRDED1000/40','Deductible then 40% coinsurance','DED1000','43','7');
INSERT INTO "Attribute_Value__c" VALUES(354,'DED500/40','','Network A: Deductible then $500 copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MISRDED500/40','Deductible then 40% coinsurance','DED500','43','7');
INSERT INTO "Attribute_Value__c" VALUES(355,'DED20/40','','Network A: Deductible then 20% copay / admission Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MISRDED20/40','Deductible then 40% coinsurance','DED20','43','7');
INSERT INTO "Attribute_Value__c" VALUES(356,'25/40','','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MOSA25/40','Deductible then 40% coinsurance','25','44','7');
INSERT INTO "Attribute_Value__c" VALUES(357,'DED25/40','','Network A: Deductible then $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MOSADED25/40','Deductible then 40% coinsurance','DED25','44','7');
INSERT INTO "Attribute_Value__c" VALUES(358,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','MOSADED20/40','Deductible then 40% coinsurance','DED20','44','7');
INSERT INTO "Attribute_Value__c" VALUES(359,'DED20/DED40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ATTDED20/DED40','Deductible then 40% coinsurance','DED20','45','7');
INSERT INTO "Attribute_Value__c" VALUES(360,'25/DED40','','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ATT25/DED40','Deductible then 40% coinsurance','25','45','7');
INSERT INTO "Attribute_Value__c" VALUES(392,'DED40/40','','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','ATTDED40/40','Deductible then 40% coinsurance','DED40','45','7');
INSERT INTO "Attribute_Value__c" VALUES(393,'25/40','','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OPP25/40','Deductible then 40% coinsurance','25','46','7');
INSERT INTO "Attribute_Value__c" VALUES(394,'DED25/40','','Network A: Deductible then $25/$40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OPPDED25/40','Deductible then 40% coinsurance','DED25','46','7');
INSERT INTO "Attribute_Value__c" VALUES(395,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','OPPDED20/40','Deductible then 40% coinsurance','DED20','46','7');
INSERT INTO "Attribute_Value__c" VALUES(396,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PCPVDED20/40','Deductible then 40% coinsurance','DED20','47','7');
INSERT INTO "Attribute_Value__c" VALUES(397,'DED25/40','','Network A: Deductible then $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PCPVDED25/40','Deductible then 40% coinsurance','DED25','47','7');
INSERT INTO "Attribute_Value__c" VALUES(398,'DED30/40','','Network A: $30 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','PCPVDED30/40','Deductible then 40% coinsurance','DED30','47','7');
INSERT INTO "Attribute_Value__c" VALUES(399,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','SPVDED20/40','Deductible then 40% coinsurance','DED20','48','7');
INSERT INTO "Attribute_Value__c" VALUES(400,'DED2040/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','SPVDED2040/40','Deductible then 40% coinsurance','DED2040','48','7');
INSERT INTO "Attribute_Value__c" VALUES(401,'DED40/40','','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','SPVDED40/40','Deductible then 40% coinsurance','DED40','48','7');
INSERT INTO "Attribute_Value__c" VALUES(402,'DED25/40','','Network A: Deductible then $25 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','SPVDED25/40','Deductible then 40% coinsurance','DED25','48','7');
INSERT INTO "Attribute_Value__c" VALUES(403,'40/NC','','$40 copay / consultation','NC','Not Covered','Not Covered','TMD40/NC','Not Covered','40','49','7');
INSERT INTO "Attribute_Value__c" VALUES(404,'DED40/NC','','Deductible then $40 copay / consultation','NC','Not Covered','Not Covered','TMDDED40/NC','Not Covered','DED40','49','7');
INSERT INTO "Attribute_Value__c" VALUES(426,'20/NC','','Deductible then 20% coinsurance','NC','Not Covered','Not Covered','TMD20/NC','Not Covered','20','49','7');
INSERT INTO "Attribute_Value__c" VALUES(427,'0/NC','','$0 copay / consultation','NC','Not Covered','Not Covered','TMH0/NC','Not Covered','0','50','7');
INSERT INTO "Attribute_Value__c" VALUES(428,'DED40/NC','','Deductible then $40 copay / consultation','NC','Not Covered','Not Covered','TMHDED40/NC','Not Covered','DED40','50','7');
INSERT INTO "Attribute_Value__c" VALUES(429,'DED0/40','','Deductible then $0 copay / consultation','40','Not Covered','Not Covered','TMHDED0/40','Not Covered','DED0','50','7');
INSERT INTO "Attribute_Value__c" VALUES(430,'C/NA','','Creditable','NA','Not Applicable','Not Applicable','RX-MDC/NA','Not Applicable','C','51','7');
INSERT INTO "Attribute_Value__c" VALUES(431,'4/NC','','$4/$15/$30','NC','Not Covered','Not Covered','RX-PP4/NC','Not Covered','4','52','7');
INSERT INTO "Attribute_Value__c" VALUES(432,'DED40/NC','','Deductible then $4/$15/$30','NC','Not Covered','Not Covered','RX-PPDED40/NC','Not Covered','DED40','52','7');
INSERT INTO "Attribute_Value__c" VALUES(433,'40/DED40','','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RCR40/DED40','Deductible then 40% coinsurance','40','53','7');
INSERT INTO "Attribute_Value__c" VALUES(434,'DED40/DED40','','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RCRDED40/DED40','Deductible then 40% coinsurance','DED40','53','7');
INSERT INTO "Attribute_Value__c" VALUES(435,'DED20/DED40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RCRDED20/DED40','Deductible then 40% coinsurance','DED20','53','7');
INSERT INTO "Attribute_Value__c" VALUES(436,'40/DED40','','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RCS40/DED40','Deductible then 40% coinsurance','40','54','7');
INSERT INTO "Attribute_Value__c" VALUES(437,'DED40/DED40','','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RCSDED40/DED40','Deductible then 40% coinsurance','DED40','54','7');
INSERT INTO "Attribute_Value__c" VALUES(438,'DED20/DED40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RCSDED20/DED40','Deductible then 40% coinsurance','DED20','54','7');
INSERT INTO "Attribute_Value__c" VALUES(439,'DED20/DED40','','Deductible then 20% coinsurance','DED40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RPODED20/DED40','Deductible then 40% coinsurance','DED20','55','7');
INSERT INTO "Attribute_Value__c" VALUES(440,'40/40','','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RPR40/40','Deductible then 40% coinsurance','40','56','7');
INSERT INTO "Attribute_Value__c" VALUES(441,'DED40/40','','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RPRDED40/40','Deductible then 40% coinsurance','DED40','56','7');
INSERT INTO "Attribute_Value__c" VALUES(442,'DED20/40','','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','40','Deductible then 40% coinsurance','Deductible then 40% coinsurance','RPRDED20/40','Deductible then 40% coinsurance','DED20','56','7');
INSERT INTO "Attribute_Value__c" VALUES(465,'50/50','','50% coinsurance','50','','','ADME50/50','Deductible then 50% coinsurance','50','3','10');
INSERT INTO "Attribute_Value__c" VALUES(466,'N/N','','Not Covered','N','','','ADMEN/N','Not Covered','N','3','10');
INSERT INTO "Attribute_Value__c" VALUES(467,'20/50','','20% coinsurance','20','Up to 40 visits per plan year','Up to 40 visits per plan year','AHHC20/50','Deductible then 50% coinsurance','50','4','10');
INSERT INTO "Attribute_Value__c" VALUES(468,'N/N','','Not Covered','N','','','AHHCN/N','Not Covered','N','4','10');
INSERT INTO "Attribute_Value__c" VALUES(469,'50/50','','50% coinsurance','50','','','APA50/50','Deductible then 50% coinsurance','50','5','10');
INSERT INTO "Attribute_Value__c" VALUES(470,'N/N','','Not Covered','N','','','APAN/N','Not Covered','N','5','10');
INSERT INTO "Attribute_Value__c" VALUES(471,'250/0','','Option 1: $250 gym/wellness services allowance. Option 2: Up to $500 per individual/$1,000 per family earned from the purchase of fresh produce.','250','After your effective date you
must choose either Option 1 or
Option 2.','After your effective date you
must choose either Option 1 or
Option 2.','AUB250/0','Not Covered','0','6','10');
INSERT INTO "Attribute_Value__c" VALUES(472,'15/0','','15% off retail price','15','','','AV-C15/0','Not Covered','0','8','10');
INSERT INTO "Attribute_Value__c" VALUES(473,'40/0','','40% off most retail frames','40','','','AV-F40/0','Not Covered','0','9','10');
INSERT INTO "Attribute_Value__c" VALUES(474,'15/0','','15% off retail price or 5% off promotional price','15','','','AV-LV15/0','Not Covered','0','10','10');
INSERT INTO "Attribute_Value__c" VALUES(475,'20/50','','20% coinsurance','20','','','AV-ME20/50','Deductible then 50% coinsurance','50','11','10');
INSERT INTO "Attribute_Value__c" VALUES(476,'40/0','','$40 copay / visit','40','Once every 12 months','Once every 12 months','AV-RE40/0','Not Covered','0','12','10');
INSERT INTO "Attribute_Value__c" VALUES(477,'50/0','','Single: $50 Bifocal: $70','50','Contact EyeMed for additional
options at 1-877-842-3348','Contact EyeMed for additional
options at 1-877-842-3348','AV-SPL50/0','Not Covered','0','13','10');
INSERT INTO "Attribute_Value__c" VALUES(478,'0/0','','Based on services rendered','0','Must be deemed medically
necessary','Must be deemed medically
necessary','DS-AD0/0','Based on services rendered','0','14','10');
INSERT INTO "Attribute_Value__c" VALUES(479,'0/0','','Not Covered','0','','','DS-PR0/0','Not Covered','0','15','10');
INSERT INTO "Attribute_Value__c" VALUES(480,'29/26','','26','29','Up to the end of the birthday
month','Up to the end of the birthday
month','DEP29/26','29','26','16','10');
INSERT INTO "Attribute_Value__c" VALUES(481,'20/50','','20% coinsurance','20','','','DE20/50','Deductible then 50% coinsurance','50','17','10');
INSERT INTO "Attribute_Value__c" VALUES(482,'20/50','','20% coinsurance','20','Office visit liability or pharmacy
rider liability (if applicable),
whichever is less','Office visit liability or pharmacy
rider liability (if applicable),
whichever is less','DIO20/50','Deductible then 50% coinsurance','50','18','10');
INSERT INTO "Attribute_Value__c" VALUES(483,'20/50','','20% coinsurance','20','','','DMS20/50','Deductible then 50% coinsurance','50','19','10');
INSERT INTO "Attribute_Value__c" VALUES(484,'20/50','','20% coinsurance','20','Radiology services, other than
X-rays, including but not
limited to MRI, MRA, CT
Scans, myocardial perfusion
imaging and PET Scans.','Radiology services, other than
X-rays, including but not
limited to MRI, MRA, CT
Scans, myocardial perfusion
imaging and PET Scans.','AR20/50','Deductible then 50% coinsurance','50','20','10');
INSERT INTO "Attribute_Value__c" VALUES(485,'20/50','','20% coinsurance','20','','','DT20/50','Deductible then 50% coinsurance','50','21','10');
INSERT INTO "Attribute_Value__c" VALUES(486,'20/50','','20% coinsurance','20','','','EKG20/50','Deductible then 50% coinsurance','50','22','10');
INSERT INTO "Attribute_Value__c" VALUES(487,'20/50','','20% coinsurance','20','','','RR20/50','Deductible then 50% coinsurance','50','23','10');
INSERT INTO "Attribute_Value__c" VALUES(488,'20/20','','20% coinsurance','20','Copay waived if admitted','Copay waived if admitted','ER20/20','20% coinsurance','20','24','10');
INSERT INTO "Attribute_Value__c" VALUES(489,'20/20','','20% coinsurance','20','Must be deemed medically
necessary','Must be deemed medically
necessary','ERT20/20','20% coinsurance','20','25','10');
INSERT INTO "Attribute_Value__c" VALUES(490,'0/0','','Not Applicable','0','','','APL0/0','Not Applicable','0','27','10');
INSERT INTO "Attribute_Value__c" VALUES(491,'20/50','','20%','20','','','COINS20/50','50%','50','28','10');
INSERT INTO "Attribute_Value__c" VALUES(492,'25/75','','25%','25','','','COINS25/75','75%','75','28','10');
INSERT INTO "Attribute_Value__c" VALUES(493,'30/60','','30%','30','','','COINS30/60','60%','60','28','10');
INSERT INTO "Attribute_Value__c" VALUES(494,'0/1000','','$0/$0 Network A','0','','','DED0/1000','$1000/$2000 Network B','1000','29','10');
INSERT INTO "Attribute_Value__c" VALUES(495,'100/1000','','$100/$2000 Network A','100','','','DED100/1000','$2000/$4000 Network B','1000','29','10');
INSERT INTO "Attribute_Value__c" VALUES(496,'7350/10000','','$7,350 / $14,700','7350','Where the out of pocket max
applies it accumulates as
embedded.
*See Important Notes section
for more detail.','Where the out of pocket max
applies it accumulates as
embedded.
*See Important Notes section
for more detail.','MOOP7350/10000','$10,000 / $20,000','10000','30','10');
INSERT INTO "Attribute_Value__c" VALUES(497,'0/50','','$0 copay / visit','0','Up to 210 days per plan year','Up to 210 days per plan year','INHSPS0/50','Deductible then 50% coinsurance','50','31','10');
INSERT INTO "Attribute_Value__c" VALUES(498,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','INP20/50','Deductible then 50% coinsurance','50','32','10');
INSERT INTO "Attribute_Value__c" VALUES(499,'1000/0','','Inpatient Hospital Copay: $1000.00 & SNF $500.00 Per Admission Dual Network','1000','','','INP1000/0','Deductible then 50% coinsurance','0','32','10');
INSERT INTO "Attribute_Value__c" VALUES(500,'250/0','','Inpatient Hospital Copay: $250.00 & SNF $250.00 Per Admission Dual Network','250','','','INP250/0','Deductible then 50% coinsurance','0','32','10');
INSERT INTO "Attribute_Value__c" VALUES(501,'650/0','','Inpatient Hospital Copay: $750.00 & SNF $500.00 Per Admission Dual Network','650','','','INP650/0','Deductible then 50% coinsurance','0','32','10');
INSERT INTO "Attribute_Value__c" VALUES(502,'20/50','','20% coinsurance','20','','','INPP20/50','Deductible then 50% coinsurance','50','33','10');
INSERT INTO "Attribute_Value__c" VALUES(503,'20/50','','20% coinsurance','20','','','OSP-A20/50','Deductible then 50% coinsurance','50','34','10');
INSERT INTO "Attribute_Value__c" VALUES(504,'20/50','','20% coinsurance','20','','','OSP-H20/50','Deductible then 50% coinsurance','50','35','10');
INSERT INTO "Attribute_Value__c" VALUES(505,'20/50','','20% coinsurance','20','Semi-private room, per
admission
Unlimited days per plan year','Semi-private room, per
admission
Unlimited days per plan year','SNF20/50','Deductible then 50% coinsurance','50','37','10');
INSERT INTO "Attribute_Value__c" VALUES(506,'20/50','','Delivery 20% coinsurance Physician: 20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','PPS-F20/50','Deductible then 50% coinsurance','50','38','10');
INSERT INTO "Attribute_Value__c" VALUES(507,'0/50','','$0 copay / visit','0','No charge after the initial
diagnosis','No charge after the initial
diagnosis','PPS-OV0/50','Deductible then 50% coinsurance','50','39','10');
INSERT INTO "Attribute_Value__c" VALUES(508,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','MBHI20/50','Deductible then 50% coinsurance','50','40','10');
INSERT INTO "Attribute_Value__c" VALUES(509,'20/50','','20% coinsurance','20','','','MBHO20/50','Deductible then 50% coinsurance','50','41','10');
INSERT INTO "Attribute_Value__c" VALUES(510,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','MISR20/50','Deductible then 50% coinsurance','50','43','10');
INSERT INTO "Attribute_Value__c" VALUES(511,'20/50','','20% coinsurance','20','','','MOSA20/50','Deductible then 50% coinsurance','50','44','10');
INSERT INTO "Attribute_Value__c" VALUES(512,'20/50','','20% coinsurance','20','','','ATT20/50','Deductible then 50% coinsurance','50','45','10');
INSERT INTO "Attribute_Value__c" VALUES(513,'20/50','','20% coinsurance','20','','','OPP20/50','Deductible then 50% coinsurance','50','46','10');
INSERT INTO "Attribute_Value__c" VALUES(514,'0/0','','$0 copay / consultation','0','','','TMH0/0','Not Covered','0','50','10');
INSERT INTO "Attribute_Value__c" VALUES(515,'0/0','','Creditable','0','For those who are Medicare
eligible, this plan meets the
standard level of prescription
drug coverage determined by
Medicare, therefore this plan
provides you with
CREDITABLE COVERAGE','For those who are Medicare
eligible, this plan meets the
standard level of prescription
drug coverage determined by
Medicare, therefore this plan
provides you with
CREDITABLE COVERAGE','RX-MD0/0','Not Applicable','0','51','10');
INSERT INTO "Attribute_Value__c" VALUES(516,'May-00','','$5/20%/20%','5','Must be filled at a participating
Pharmacy.
This plan utilizes Prescription
Drug Formulary III.','Must be filled at a participating
Pharmacy.
This plan utilizes Prescription
Drug Formulary III.','RX-PP5/0','Not Covered','0','52','10');
INSERT INTO "Attribute_Value__c" VALUES(517,'20/50','','20% coinsurance','20','Up to 36 visits per event','Up to 36 visits per event','RCR20/50','Deductible then 50% coinsurance','50','53','10');
INSERT INTO "Attribute_Value__c" VALUES(518,'20/50','','20% coinsurance','20','','','RCS20/50','Deductible then 50% coinsurance','50','54','10');
INSERT INTO "Attribute_Value__c" VALUES(519,'20/50','','20% coinsurance','20','Up to 60 visits per condition
per plan year','Up to 60 visits per condition
per plan year','RPO20/50','Deductible then 50% coinsurance','50','55','10');
INSERT INTO "Attribute_Value__c" VALUES(520,'20/50','','20% coinsurance','20','Up to 24 visits per plan year','Up to 24 visits per plan year','RPR20/50','Deductible then 50% coinsurance','50','56','10');
INSERT INTO "Attribute_Value__c" VALUES(521,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','MISD20/50','Deductible then 50% coinsurance','50','42','10');
INSERT INTO "Attribute_Value__c" VALUES(522,'20/50','','20% coinsurance','20','See Medications Administered
in an Office or Outpatient
Hospital Setting for additional
member liability','See Medications Administered
in an Office or Outpatient
Hospital Setting for additional
member liability','ACV20/50','Deductible then 50% coinsurance','50','2','10');
INSERT INTO "Attribute_Value__c" VALUES(523,'N/N','','Not Covered','N','','','ACVN/N','Not Covered','N','2','10');
INSERT INTO "Attribute_Value__c" VALUES(524,'250/0','','Option 1: $250 gym/wellness services allowance. Option 2: Up to $500 per individual/$1,000 per family earned from the purchase of fresh produce.','250','After your effective date you
must choose either Option 1 or
Option 2.','After your effective date you
must choose either Option 1 or
Option 2.','AUB250/0','Not Covered','0','6','13');
INSERT INTO "Attribute_Value__c" VALUES(525,'15/0','','15% off retail price','15','','','AV-C15/0','Not Covered','0','8','13');
INSERT INTO "Attribute_Value__c" VALUES(526,'40/0','','40% off most retail frames','40','','','AV-F40/0','Not Covered','0','9','13');
INSERT INTO "Attribute_Value__c" VALUES(527,'15/0','','15% off retail price or 5% off promotional price','15','','','AV-LV15/0','Not Covered','0','10','13');
INSERT INTO "Attribute_Value__c" VALUES(528,'20/50','','20% coinsurance','20','','','AV-ME20/50','Deductible then 50% coinsurance','50','11','13');
INSERT INTO "Attribute_Value__c" VALUES(529,'40/0','','$40 copay / visit','40','Once every 12 months','Once every 12 months','AV-RE40/0','Not Covered','0','12','13');
INSERT INTO "Attribute_Value__c" VALUES(530,'50/0','','Single: $50 Bifocal: $70','50','Contact EyeMed for additional
options at 1-877-842-3348','Contact EyeMed for additional
options at 1-877-842-3348','AV-SPL50/0','Not Covered','0','13','13');
INSERT INTO "Attribute_Value__c" VALUES(531,'0/0','','Based on services rendered','0','Must be deemed medically
necessary','Must be deemed medically
necessary','DS-AD0/0','Based on services rendered','0','14','13');
INSERT INTO "Attribute_Value__c" VALUES(532,'0/0','','Not Covered','0','','','DS-PR0/0','Not Covered','0','15','13');
INSERT INTO "Attribute_Value__c" VALUES(533,'29/26','','26','29','Up to the end of the birthday
month','Up to the end of the birthday
month','DEP29/26','29','26','16','13');
INSERT INTO "Attribute_Value__c" VALUES(534,'20/50','','20% coinsurance','20','','','DE20/50','Deductible then 50% coinsurance','50','17','13');
INSERT INTO "Attribute_Value__c" VALUES(535,'20/50','','20% coinsurance','20','Office visit liability or pharmacy
rider liability (if applicable),
whichever is less','Office visit liability or pharmacy
rider liability (if applicable),
whichever is less','DIO20/50','Deductible then 50% coinsurance','50','18','13');
INSERT INTO "Attribute_Value__c" VALUES(536,'20/50','','20% coinsurance','20','','','DMS20/50','Deductible then 50% coinsurance','50','19','13');
INSERT INTO "Attribute_Value__c" VALUES(537,'20/50','','20% coinsurance','20','Radiology services, other than
X-rays, including but not
limited to MRI, MRA, CT
Scans, myocardial perfusion
imaging and PET Scans.','Radiology services, other than
X-rays, including but not
limited to MRI, MRA, CT
Scans, myocardial perfusion
imaging and PET Scans.','AR20/50','Deductible then 50% coinsurance','50','20','13');
INSERT INTO "Attribute_Value__c" VALUES(538,'20/50','','20% coinsurance','20','','','DT20/50','Deductible then 50% coinsurance','50','21','13');
INSERT INTO "Attribute_Value__c" VALUES(539,'20/50','','20% coinsurance','20','','','EKG20/50','Deductible then 50% coinsurance','50','22','13');
INSERT INTO "Attribute_Value__c" VALUES(540,'20/50','','20% coinsurance','20','','','RR20/50','Deductible then 50% coinsurance','50','23','13');
INSERT INTO "Attribute_Value__c" VALUES(541,'20/20','','20% coinsurance','20','Copay waived if admitted','Copay waived if admitted','ER20/20','20% coinsurance','20','24','13');
INSERT INTO "Attribute_Value__c" VALUES(542,'20/20','','20% coinsurance','20','Must be deemed medically
necessary','Must be deemed medically
necessary','ERT20/20','20% coinsurance','20','25','13');
INSERT INTO "Attribute_Value__c" VALUES(543,'0/0','','Not Applicable','0','','','APL0/0','Not Applicable','0','27','13');
INSERT INTO "Attribute_Value__c" VALUES(544,'20/50','','20%','20','','','COINS20/50','50%','50','28','13');
INSERT INTO "Attribute_Value__c" VALUES(545,'25/75','','25%','25','','','COINS25/75','75%','75','28','13');
INSERT INTO "Attribute_Value__c" VALUES(546,'30/60','','30%','30','','','COINS30/60','60%','60','28','13');
INSERT INTO "Attribute_Value__c" VALUES(547,'0/1000','','$0/$0 Network A','0','','','DED0/1000','$1000/$2000 Network B','1000','29','13');
INSERT INTO "Attribute_Value__c" VALUES(548,'100/1000','','$100/$2000 Network A','100','','','DED100/1000','$2000/$4000 Network B','1000','29','13');
INSERT INTO "Attribute_Value__c" VALUES(549,'7350/10000','','$7,350 / $14,700','7350','Where the out of pocket max
applies it accumulates as
embedded.
*See Important Notes section
for more detail.','Where the out of pocket max
applies it accumulates as
embedded.
*See Important Notes section
for more detail.','MOOP7350/10000','$10,000 / $20,000','10000','30','13');
INSERT INTO "Attribute_Value__c" VALUES(550,'0/50','','$0 copay / visit','0','Up to 210 days per plan year','Up to 210 days per plan year','INHSPS0/50','Deductible then 50% coinsurance','50','31','13');
INSERT INTO "Attribute_Value__c" VALUES(551,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','INP20/50','Deductible then 50% coinsurance','50','32','13');
INSERT INTO "Attribute_Value__c" VALUES(552,'1000/0','','Inpatient Hospital Copay: $1000.00 & SNF $500.00 Per Admission Dual Network','1000','','','INP1000/0','Deductible then 50% coinsurance','0','32','13');
INSERT INTO "Attribute_Value__c" VALUES(553,'250/0','','Inpatient Hospital Copay: $250.00 & SNF $250.00 Per Admission Dual Network','250','','','INP250/0','Deductible then 50% coinsurance','0','32','13');
INSERT INTO "Attribute_Value__c" VALUES(554,'650/0','','Inpatient Hospital Copay: $750.00 & SNF $500.00 Per Admission Dual Network','650','','','INP650/0','Deductible then 50% coinsurance','0','32','13');
INSERT INTO "Attribute_Value__c" VALUES(555,'20/50','','20% coinsurance','20','','','INPP20/50','Deductible then 50% coinsurance','50','33','13');
INSERT INTO "Attribute_Value__c" VALUES(556,'20/50','','20% coinsurance','20','','','OSP-A20/50','Deductible then 50% coinsurance','50','34','13');
INSERT INTO "Attribute_Value__c" VALUES(557,'20/50','','20% coinsurance','20','','','OSP-H20/50','Deductible then 50% coinsurance','50','35','13');
INSERT INTO "Attribute_Value__c" VALUES(558,'20/50','','20% coinsurance','20','Semi-private room, per
admission
Unlimited days per plan year','Semi-private room, per
admission
Unlimited days per plan year','SNF20/50','Deductible then 50% coinsurance','50','37','13');
INSERT INTO "Attribute_Value__c" VALUES(559,'20/50','','Delivery 20% coinsurance Physician: 20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','PPS-F20/50','Deductible then 50% coinsurance','50','38','13');
INSERT INTO "Attribute_Value__c" VALUES(560,'0/50','','$0 copay / visit','0','No charge after the initial
diagnosis','No charge after the initial
diagnosis','PPS-OV0/50','Deductible then 50% coinsurance','50','39','13');
INSERT INTO "Attribute_Value__c" VALUES(561,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','MBHI20/50','Deductible then 50% coinsurance','50','40','13');
INSERT INTO "Attribute_Value__c" VALUES(562,'20/50','','20% coinsurance','20','','','MBHO20/50','Deductible then 50% coinsurance','50','41','13');
INSERT INTO "Attribute_Value__c" VALUES(563,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','MISD20/50','Deductible then 50% coinsurance','50','42','13');
INSERT INTO "Attribute_Value__c" VALUES(564,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','MISR20/50','Deductible then 50% coinsurance','50','43','13');
INSERT INTO "Attribute_Value__c" VALUES(565,'20/50','','20% coinsurance','20','','','MOSA20/50','Deductible then 50% coinsurance','50','44','13');
INSERT INTO "Attribute_Value__c" VALUES(566,'20/50','','20% coinsurance','20','','','ATT20/50','Deductible then 50% coinsurance','50','45','13');
INSERT INTO "Attribute_Value__c" VALUES(567,'20/50','','20% coinsurance','20','','','OPP20/50','Deductible then 50% coinsurance','50','46','13');
INSERT INTO "Attribute_Value__c" VALUES(568,'0/0','','$0 copay / consultation','0','','','TMH0/0','Not Covered','0','50','13');
INSERT INTO "Attribute_Value__c" VALUES(569,'0/0','','Creditable','0','For those who are Medicare
eligible, this plan meets the
standard level of prescription
drug coverage determined by
Medicare, therefore this plan
provides you with
CREDITABLE COVERAGE','For those who are Medicare
eligible, this plan meets the
standard level of prescription
drug coverage determined by
Medicare, therefore this plan
provides you with
CREDITABLE COVERAGE','RX-MD0/0','Not Applicable','0','51','13');
INSERT INTO "Attribute_Value__c" VALUES(570,'May-00','','$5/20%/20%','5','Must be filled at a participating
Pharmacy.
This plan utilizes Prescription
Drug Formulary III.','Must be filled at a participating
Pharmacy.
This plan utilizes Prescription
Drug Formulary III.','RX-PP5/0','Not Covered','0','52','13');
INSERT INTO "Attribute_Value__c" VALUES(571,'20/50','','20% coinsurance','20','Up to 36 visits per event','Up to 36 visits per event','RCR20/50','Deductible then 50% coinsurance','50','53','13');
INSERT INTO "Attribute_Value__c" VALUES(572,'20/50','','20% coinsurance','20','','','RCS20/50','Deductible then 50% coinsurance','50','54','13');
INSERT INTO "Attribute_Value__c" VALUES(573,'20/50','','20% coinsurance','20','Up to 60 visits per condition
per plan year','Up to 60 visits per condition
per plan year','RPO20/50','Deductible then 50% coinsurance','50','55','13');
INSERT INTO "Attribute_Value__c" VALUES(574,'20/50','','20% coinsurance','20','Up to 24 visits per plan year','Up to 24 visits per plan year','RPR20/50','Deductible then 50% coinsurance','50','56','13');
INSERT INTO "Attribute_Value__c" VALUES(575,'20/50','','20% coinsurance','20','See Medications Administered
in an Office or Outpatient
Hospital Setting for additional
member liability','See Medications Administered
in an Office or Outpatient
Hospital Setting for additional
member liability','ACV20/50','Deductible then 50% coinsurance','50','2','13');
INSERT INTO "Attribute_Value__c" VALUES(576,'N/N','','Not Covered','N','','','ACVN/N','Not Covered','N','2','13');
INSERT INTO "Attribute_Value__c" VALUES(577,'50/50','','50% coinsurance','50','','','ADME50/50','Deductible then 50% coinsurance','50','3','13');
INSERT INTO "Attribute_Value__c" VALUES(578,'N/N','','Not Covered','N','','','ADMEN/N','Not Covered','N','3','13');
INSERT INTO "Attribute_Value__c" VALUES(579,'20/50','','20% coinsurance','20','Up to 40 visits per plan year','Up to 40 visits per plan year','AHHC20/50','Deductible then 50% coinsurance','50','4','13');
INSERT INTO "Attribute_Value__c" VALUES(580,'N/N','','Not Covered','N','','','AHHCN/N','Not Covered','N','4','13');
INSERT INTO "Attribute_Value__c" VALUES(581,'50/50','','50% coinsurance','50','','','APA50/50','Deductible then 50% coinsurance','50','5','13');
INSERT INTO "Attribute_Value__c" VALUES(582,'N/N','','Not Covered','N','','','APAN/N','Not Covered','N','5','13');
INSERT INTO "Attribute_Value__c" VALUES(583,'N/N','','Not Covered','N','','','ACVN/N','Not Covered','N','2','9');
INSERT INTO "Attribute_Value__c" VALUES(584,'50/50','','50% coinsurance','50','','','ADME50/50','Deductible then 50% coinsurance','50','3','9');
INSERT INTO "Attribute_Value__c" VALUES(585,'N/N','','Not Covered','N','','','ADMEN/N','Not Covered','N','3','9');
INSERT INTO "Attribute_Value__c" VALUES(586,'20/50','','20% coinsurance','20','Up to 40 visits per plan year','Up to 40 visits per plan year','AHHC20/50','Deductible then 50% coinsurance','50','4','9');
INSERT INTO "Attribute_Value__c" VALUES(587,'20/50','','20% coinsurance','20','See Medications Administered
in an Office or Outpatient
Hospital Setting for additional
member liability','See Medications Administered
in an Office or Outpatient
Hospital Setting for additional
member liability','ACV20/50','Deductible then 50% coinsurance','50','2','9');
INSERT INTO "Attribute_Value__c" VALUES(588,'N/N','','Not Covered','N','','','AHHCN/N','Not Covered','N','4','9');
INSERT INTO "Attribute_Value__c" VALUES(589,'50/50','','50% coinsurance','50','','','APA50/50','Deductible then 50% coinsurance','50','5','9');
INSERT INTO "Attribute_Value__c" VALUES(590,'N/N','','Not Covered','N','','','APAN/N','Not Covered','N','5','9');
INSERT INTO "Attribute_Value__c" VALUES(591,'250/0','','Option 1: $250 gym/wellness services allowance. Option 2: Up to $500 per individual/$1,000 per family earned from the purchase of fresh produce.','250','After your effective date you
must choose either Option 1 or
Option 2.','After your effective date you
must choose either Option 1 or
Option 2.','AUB250/0','Not Covered','0','6','9');
INSERT INTO "Attribute_Value__c" VALUES(592,'15/0','','15% off retail price','15','','','AV-C15/0','Not Covered','0','8','9');
INSERT INTO "Attribute_Value__c" VALUES(593,'40/0','','40% off most retail frames','40','','','AV-F40/0','Not Covered','0','9','9');
INSERT INTO "Attribute_Value__c" VALUES(594,'15/0','','15% off retail price or 5% off promotional price','15','','','AV-LV15/0','Not Covered','0','10','9');
INSERT INTO "Attribute_Value__c" VALUES(595,'20/50','','20% coinsurance','20','','','AV-ME20/50','Deductible then 50% coinsurance','50','11','9');
INSERT INTO "Attribute_Value__c" VALUES(596,'40/0','','$40 copay / visit','40','Once every 12 months','Once every 12 months','AV-RE40/0','Not Covered','0','12','9');
INSERT INTO "Attribute_Value__c" VALUES(597,'50/0','','Single: $50 Bifocal: $70','50','Contact EyeMed for additional
options at 1-877-842-3348','Contact EyeMed for additional
options at 1-877-842-3348','AV-SPL50/0','Not Covered','0','13','9');
INSERT INTO "Attribute_Value__c" VALUES(598,'0/0','','Based on services rendered','0','Must be deemed medically
necessary','Must be deemed medically
necessary','DS-AD0/0','Based on services rendered','0','14','9');
INSERT INTO "Attribute_Value__c" VALUES(599,'0/0','','Not Covered','0','','','DS-PR0/0','Not Covered','0','15','9');
INSERT INTO "Attribute_Value__c" VALUES(600,'29/26','','26','29','Up to the end of the birthday
month','Up to the end of the birthday
month','DEP29/26','29','26','16','9');
INSERT INTO "Attribute_Value__c" VALUES(601,'20/50','','20% coinsurance','20','','','DE20/50','Deductible then 50% coinsurance','50','17','9');
INSERT INTO "Attribute_Value__c" VALUES(602,'20/50','','20% coinsurance','20','Office visit liability or pharmacy
rider liability (if applicable),
whichever is less','Office visit liability or pharmacy
rider liability (if applicable),
whichever is less','DIO20/50','Deductible then 50% coinsurance','50','18','9');
INSERT INTO "Attribute_Value__c" VALUES(603,'20/50','','20% coinsurance','20','','','DMS20/50','Deductible then 50% coinsurance','50','19','9');
INSERT INTO "Attribute_Value__c" VALUES(604,'20/50','','20% coinsurance','20','Radiology services, other than
X-rays, including but not
limited to MRI, MRA, CT
Scans, myocardial perfusion
imaging and PET Scans.','Radiology services, other than
X-rays, including but not
limited to MRI, MRA, CT
Scans, myocardial perfusion
imaging and PET Scans.','AR20/50','Deductible then 50% coinsurance','50','20','9');
INSERT INTO "Attribute_Value__c" VALUES(605,'20/50','','20% coinsurance','20','','','DT20/50','Deductible then 50% coinsurance','50','21','9');
INSERT INTO "Attribute_Value__c" VALUES(606,'20/50','','20% coinsurance','20','','','EKG20/50','Deductible then 50% coinsurance','50','22','9');
INSERT INTO "Attribute_Value__c" VALUES(607,'20/50','','20% coinsurance','20','','','RR20/50','Deductible then 50% coinsurance','50','23','9');
INSERT INTO "Attribute_Value__c" VALUES(608,'20/20','','20% coinsurance','20','Copay waived if admitted','Copay waived if admitted','ER20/20','20% coinsurance','20','24','9');
INSERT INTO "Attribute_Value__c" VALUES(609,'20/20','','20% coinsurance','20','Must be deemed medically
necessary','Must be deemed medically
necessary','ERT20/20','20% coinsurance','20','25','9');
INSERT INTO "Attribute_Value__c" VALUES(610,'0/0','','Not Applicable','0','','','APL0/0','Not Applicable','0','27','9');
INSERT INTO "Attribute_Value__c" VALUES(611,'20/50','','20%','20','','','COINS20/50','50%','50','28','9');
INSERT INTO "Attribute_Value__c" VALUES(612,'25/75','','25%','25','','','COINS25/75','75%','75','28','9');
INSERT INTO "Attribute_Value__c" VALUES(613,'30/60','','30%','30','','','COINS30/60','60%','60','28','9');
INSERT INTO "Attribute_Value__c" VALUES(614,'0/1000','','$0/$0 Network A','0','','','DED0/1000','$1000/$2000 Network B','1000','29','9');
INSERT INTO "Attribute_Value__c" VALUES(615,'100/1000','','$100/$2000 Network A','100','','','DED100/1000','$2000/$4000 Network B','1000','29','9');
INSERT INTO "Attribute_Value__c" VALUES(616,'7350/10000','','$7,350 / $14,700','7350','Where the out of pocket max
applies it accumulates as
embedded.
*See Important Notes section
for more detail.','Where the out of pocket max
applies it accumulates as
embedded.
*See Important Notes section
for more detail.','MOOP7350/10000','$10,000 / $20,000','10000','30','9');
INSERT INTO "Attribute_Value__c" VALUES(617,'0/50','','$0 copay / visit','0','Up to 210 days per plan year','Up to 210 days per plan year','INHSPS0/50','Deductible then 50% coinsurance','50','31','9');
INSERT INTO "Attribute_Value__c" VALUES(618,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','INP20/50','Deductible then 50% coinsurance','50','32','9');
INSERT INTO "Attribute_Value__c" VALUES(619,'1000/0','','Inpatient Hospital Copay: $1000.00 & SNF $500.00 Per Admission Dual Network','1000','','','INP1000/0','Deductible then 50% coinsurance','0','32','9');
INSERT INTO "Attribute_Value__c" VALUES(620,'250/0','','Inpatient Hospital Copay: $250.00 & SNF $250.00 Per Admission Dual Network','250','','','INP250/0','Deductible then 50% coinsurance','0','32','9');
INSERT INTO "Attribute_Value__c" VALUES(621,'650/0','','Inpatient Hospital Copay: $750.00 & SNF $500.00 Per Admission Dual Network','650','','','INP650/0','Deductible then 50% coinsurance','0','32','9');
INSERT INTO "Attribute_Value__c" VALUES(622,'20/50','','20% coinsurance','20','','','INPP20/50','Deductible then 50% coinsurance','50','33','9');
INSERT INTO "Attribute_Value__c" VALUES(623,'20/50','','20% coinsurance','20','','','OSP-A20/50','Deductible then 50% coinsurance','50','34','9');
INSERT INTO "Attribute_Value__c" VALUES(624,'20/50','','20% coinsurance','20','','','OSP-H20/50','Deductible then 50% coinsurance','50','35','9');
INSERT INTO "Attribute_Value__c" VALUES(625,'20/50','','20% coinsurance','20','Semi-private room, per
admission
Unlimited days per plan year','Semi-private room, per
admission
Unlimited days per plan year','SNF20/50','Deductible then 50% coinsurance','50','37','9');
INSERT INTO "Attribute_Value__c" VALUES(626,'20/50','','Delivery 20% coinsurance Physician: 20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','PPS-F20/50','Deductible then 50% coinsurance','50','38','9');
INSERT INTO "Attribute_Value__c" VALUES(627,'0/50','','$0 copay / visit','0','No charge after the initial
diagnosis','No charge after the initial
diagnosis','PPS-OV0/50','Deductible then 50% coinsurance','50','39','9');
INSERT INTO "Attribute_Value__c" VALUES(628,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','MBHI20/50','Deductible then 50% coinsurance','50','40','9');
INSERT INTO "Attribute_Value__c" VALUES(629,'20/50','','20% coinsurance','20','','','MBHO20/50','Deductible then 50% coinsurance','50','41','9');
INSERT INTO "Attribute_Value__c" VALUES(630,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','MISD20/50','Deductible then 50% coinsurance','50','42','9');
INSERT INTO "Attribute_Value__c" VALUES(631,'20/50','','20% coinsurance','20','Semi-private room, per
admission','Semi-private room, per
admission','MISR20/50','Deductible then 50% coinsurance','50','43','9');
INSERT INTO "Attribute_Value__c" VALUES(632,'20/50','','20% coinsurance','20','','','MOSA20/50','Deductible then 50% coinsurance','50','44','9');
INSERT INTO "Attribute_Value__c" VALUES(633,'20/50','','20% coinsurance','20','','','ATT20/50','Deductible then 50% coinsurance','50','45','9');
INSERT INTO "Attribute_Value__c" VALUES(634,'20/50','','20% coinsurance','20','','','OPP20/50','Deductible then 50% coinsurance','50','46','9');
INSERT INTO "Attribute_Value__c" VALUES(635,'0/0','','$0 copay / consultation','0','','','TMH0/0','Not Covered','0','50','9');
INSERT INTO "Attribute_Value__c" VALUES(636,'0/0','','Creditable','0','For those who are Medicare
eligible, this plan meets the
standard level of prescription
drug coverage determined by
Medicare, therefore this plan
provides you with
CREDITABLE COVERAGE','For those who are Medicare
eligible, this plan meets the
standard level of prescription
drug coverage determined by
Medicare, therefore this plan
provides you with
CREDITABLE COVERAGE','RX-MD0/0','Not Applicable','0','51','9');
INSERT INTO "Attribute_Value__c" VALUES(637,'May-00','','$5/20%/20%','5','Must be filled at a participating
Pharmacy.
This plan utilizes Prescription
Drug Formulary III.','Must be filled at a participating
Pharmacy.
This plan utilizes Prescription
Drug Formulary III.','RX-PP5/0','Not Covered','0','52','9');
INSERT INTO "Attribute_Value__c" VALUES(638,'20/50','','20% coinsurance','20','Up to 36 visits per event','Up to 36 visits per event','RCR20/50','Deductible then 50% coinsurance','50','53','9');
INSERT INTO "Attribute_Value__c" VALUES(639,'20/50','','20% coinsurance','20','','','RCS20/50','Deductible then 50% coinsurance','50','54','9');
INSERT INTO "Attribute_Value__c" VALUES(640,'20/50','','20% coinsurance','20','Up to 60 visits per condition
per plan year','Up to 60 visits per condition
per plan year','RPO20/50','Deductible then 50% coinsurance','50','55','9');
INSERT INTO "Attribute_Value__c" VALUES(641,'20/50','','20% coinsurance','20','Up to 24 visits per plan year','Up to 24 visits per plan year','RPR20/50','Deductible then 50% coinsurance','50','56','9');
CREATE TABLE "Attribute__c" (
	id INTEGER NOT NULL, 
	"Attribute_Category__c" VARCHAR(255), 
	"Attribute_Display_Name__c" VARCHAR(255), 
	"Attribute_Long_Code__c" VARCHAR(255), 
	"Attribute_Name__c" VARCHAR(255), 
	"Is_Key_Display_Benefit__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Value_Type__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Attribute__c" VALUES(1,'Maternity Services','Family Planning','FP','Family Planning','False','FP','Text');
INSERT INTO "Attribute__c" VALUES(2,'Additional Services','Chemotherapy','ACV','Chemotherapy','False','ACV','Text');
INSERT INTO "Attribute__c" VALUES(3,'Additional Services','Durable Medical Equipment','ADME','Durable Medical Equipment','False','ADME','Text');
INSERT INTO "Attribute__c" VALUES(4,'Additional Services','Home Health Care','AHHC','Home Health Care','False','AHHC','Text');
INSERT INTO "Attribute__c" VALUES(5,'Additional Services','Prosthetics and Appliances','APA','Prosthetics and Appliances','False','APA','Text');
INSERT INTO "Attribute__c" VALUES(6,'Additional Services','Unique Benefits','AUB','Unique Benefits','False','AUB','Text');
INSERT INTO "Attribute__c" VALUES(7,'Additional Services','Zipongo Meal Kits','ZPO','Zipongo Meal Kits','False','ZPO','Text');
INSERT INTO "Attribute__c" VALUES(8,'Adult Vision Services','Conventional Contact Lenses','AV-C','Conventional Contact Lenses','False','AV-C','Text');
INSERT INTO "Attribute__c" VALUES(9,'Adult Vision Services','Frames','AV-F','Frames','False','AV-F','Text');
INSERT INTO "Attribute__c" VALUES(10,'Adult Vision Services','Laser Vision Correction','AV-LV','Laser Vision Correction','False','AV-LV','Text');
INSERT INTO "Attribute__c" VALUES(11,'Adult Vision Services','Medical Eye Exam','AV-ME','Medical Eye Exam','False','AV-ME','Text');
INSERT INTO "Attribute__c" VALUES(12,'Adult Vision Services','Routine/ Refractive Exam','AV-RE','Routine/ Refractive Exam','False','AV-RE','Text');
INSERT INTO "Attribute__c" VALUES(13,'Adult Vision Services','Standard Plastic Lenses','AV-SPL','Standard Plastic Lenses','False','AV-SPL','Text');
INSERT INTO "Attribute__c" VALUES(14,'Dental Services','Accidental Dental','DS-AD','Accidental Dental','False','DS-AD','Text');
INSERT INTO "Attribute__c" VALUES(15,'Dental Services','Preventive and Routine','DS-PR','Preventive and Routine','False','DS-PR','Text');
INSERT INTO "Attribute__c" VALUES(16,'Dependent Coverage','Dependent Eligibility','DEP','Dependent Eligibility','False','DEP','Text');
INSERT INTO "Attribute__c" VALUES(17,'Diabetic Supplies and Services','Diabetic Equipment (e.g. Blood glucose monitor, etc.)','DE','Diabetic Equipment (e.g. Blood glucose monitor, etc.)','False','DE','Text');
INSERT INTO "Attribute__c" VALUES(18,'Diabetic Supplies and Services','Insulin and Other Oral Agents','DIO','Insulin and Other Oral Agents','False','DIO','Text');
INSERT INTO "Attribute__c" VALUES(19,'Diabetic Supplies and Services','Diabetic Medical Supplies (Test Strips, Syringes, etc.)','DMS','Diabetic Medical Supplies (Test Strips, Syringes, etc.)','False','DMS','Text');
INSERT INTO "Attribute__c" VALUES(20,'Diagnostic Testing Services','Advanced Radiology','AR','Advanced Radiology','False','AR','Text');
INSERT INTO "Attribute__c" VALUES(21,'Diagnostic Testing Services','Laboratory Testing','DT','Laboratory Testing','False','DT','Text');
INSERT INTO "Attribute__c" VALUES(22,'Diagnostic Testing Services','EKG','EKG','EKG','False','EKG','Text');
INSERT INTO "Attribute__c" VALUES(23,'Diagnostic Testing Services','Routine Radiology','RR','Routine Radiology','False','RR','Text');
INSERT INTO "Attribute__c" VALUES(24,'Emergency & Urgent Care Services','Emergency Room','ER','Emergency Room','False','ER','Text');
INSERT INTO "Attribute__c" VALUES(25,'Emergency & Urgent Care Services','Ambulance','ERT','Ambulance','False','ERT','Text');
INSERT INTO "Attribute__c" VALUES(26,'Emergency & Urgent Care Services','Urgent Care Center','UCC','Urgent Care Center','False','UCC','Text');
INSERT INTO "Attribute__c" VALUES(27,'General Information','Annual Maximum','APL','Annual Maximum','False','APL','Text');
INSERT INTO "Attribute__c" VALUES(28,'General Information','Coinsurance','COINS','Coinsurance','True','COINS','Text');
INSERT INTO "Attribute__c" VALUES(29,'General Information','Deductible','DED','Deductible','True','DED','Text');
INSERT INTO "Attribute__c" VALUES(30,'General Information','Out-of-Pocket Maximum','MOOP','Out-of-Pocket Maximum','True','MOOP','Text');
INSERT INTO "Attribute__c" VALUES(31,'Hospital and Other Facility Services','Inpatient Hospice','INHSPS','Inpatient Hospice','False','INHSPS','Text');
INSERT INTO "Attribute__c" VALUES(32,'Hospital and Other Facility Services','Inpatient Hospital','INP','Inpatient Hospital','False','INP','Text');
INSERT INTO "Attribute__c" VALUES(33,'Hospital and Other Facility Services','Inpatient Hospital: Physician/Surgeon Fees','INPP','Inpatient Hospital: Physician/Surgeon Fees','False','INPP','Text');
INSERT INTO "Attribute__c" VALUES(34,'Hospital and Other Facility Services','Outpatient Surgical Procedures (Ambulatory Surgery Center)','OSP-A','Outpatient Surgical Procedures (Ambulatory Surgery Center)','False','OSP-A','Text');
INSERT INTO "Attribute__c" VALUES(35,'Hospital and Other Facility Services','Outpatient Surgical Procedures (Hospital Facility)','OSP-H','Outpatient Surgical Procedures (Hospital Facility)','False','OSP-H','Text');
INSERT INTO "Attribute__c" VALUES(36,'Hospital and Other Facility Services','Outpatient Surgical Procedures: Physician/Surgeon Fees','OSP-P','Outpatient Surgical Procedures: Physician/Surgeon Fees','False','OSP-P','Text');
INSERT INTO "Attribute__c" VALUES(37,'Hospital and Other Facility Services','Skilled Nursing Facility','SNF','Skilled Nursing Facility','False','SNF','Text');
INSERT INTO "Attribute__c" VALUES(38,'Maternity Services','Inpatient Maternity','PPS-F','Inpatient Maternity','False','PPS-F','Text');
INSERT INTO "Attribute__c" VALUES(39,'Maternity Services','Physician Services: Prenatal and Postnatal Care','PPS-OV','Physician Services: Prenatal and Postnatal Care','False','PPS-OV','Text');
INSERT INTO "Attribute__c" VALUES(40,'Mental Health & Substance Abuse','Inpatient Mental Health','MBHI','Inpatient Mental Health','False','MBHI','Text');
INSERT INTO "Attribute__c" VALUES(41,'Mental Health & Substance Abuse','Outpatient Mental Health','MBHO','Outpatient Mental Health','False','MBHO','Text');
INSERT INTO "Attribute__c" VALUES(42,'Mental Health & Substance Abuse','Inpatient Substance Abuse - Detox','MISD','Inpatient Substance Abuse - Detox','False','MISD','Text');
INSERT INTO "Attribute__c" VALUES(43,'Mental Health & Substance Abuse','Inpatient Substance Abuse - Rehab','MISR','Inpatient Substance Abuse - Rehab','False','MISR','Text');
INSERT INTO "Attribute__c" VALUES(44,'Mental Health & Substance Abuse','Outpatient Substance Abuse','MOSA','Outpatient Substance Abuse','False','MOSA','Text');
INSERT INTO "Attribute__c" VALUES(45,'Physician and Other Services','Allergy Testing & Treatment','ATT','Allergy Testing & Treatment','False','ATT','Text');
INSERT INTO "Attribute__c" VALUES(46,'Physician and Other Services','Outpatient Surgical Procedures (in physician''s office)','OPP','Outpatient Surgical Procedures (in physician''s office)','False','OPP','Text');
INSERT INTO "Attribute__c" VALUES(47,'Physician and Other Services','Primary Office Visit','PCPV','Primary Office Visit','False','PCPV','Text');
INSERT INTO "Attribute__c" VALUES(48,'Physician and Other Services','Specialist Office Visit','SPV','Specialist Office Visit','False','SPV','Text');
INSERT INTO "Attribute__c" VALUES(49,'Physician and Other Services','Telemedicine Dermatology','TMD','Telemedicine Dermatology','False','TMD','Text');
INSERT INTO "Attribute__c" VALUES(50,'Physician and Other Services','Telemedicine Including Mental Health, Behavioral Health and Substance Use Disorder','TMH','Telemedicine Including Mental Health, Behavioral Health and Substance Use Disorder','False','TMH','Text');
INSERT INTO "Attribute__c" VALUES(51,'Prescription Drug Coverage','Medicare Part D Creditable Coverage Status','RX-MD','Medicare Part D Creditable Coverage Status','False','RX-MD','Text');
INSERT INTO "Attribute__c" VALUES(52,'Prescription Drug Coverage','Prescription Plan','RX-PP','Prescription Plan','False','RX-PP','Text');
INSERT INTO "Attribute__c" VALUES(53,'Rehabilitation Services','Cardiac Rehabilitation','RCR','Cardiac Rehabilitation','False','RCR','Text');
INSERT INTO "Attribute__c" VALUES(54,'Rehabilitation Services','Chiropractic Services','RCS','Chiropractic Services','False','RCS','Text');
INSERT INTO "Attribute__c" VALUES(55,'Rehabilitation Services','Physical - Occupational - Speech Therapies','RPO','Physical - Occupational - Speech Therapies','False','RPO','Text');
INSERT INTO "Attribute__c" VALUES(56,'Rehabilitation Services','Pulmonary Rehabilitation','RPR','Pulmonary Rehabilitation','False','RPR','Text');
CREATE TABLE "Base_Rate_Schedule__c" (
	id INTEGER NOT NULL, 
	"Effective_Date__c" VARCHAR(255), 
	"Status__c" VARCHAR(255), 
	"Termination_Date__c" VARCHAR(255), 
	"Tier_Code__c" VARCHAR(255), 
	"Version__c" VARCHAR(255), 
	"Plan_Family__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Base_Rate_Schedule__c" VALUES(2,'2020-01-01','Active','2020-12-31','4 Tier','1.0','7');
INSERT INTO "Base_Rate_Schedule__c" VALUES(3,'2021-01-01','Active','2021-12-31','4 Tier','1.0','9');
INSERT INTO "Base_Rate_Schedule__c" VALUES(4,'2021-01-01','Active','2021-12-31','4 Tier','1.0','10');
INSERT INTO "Base_Rate_Schedule__c" VALUES(5,'2021-01-01','Active','2021-12-31','4 Tier','1.0','13');
CREATE TABLE "Base_Rate_Variant__c" (
	id INTEGER NOT NULL, 
	"Policy_Form__c" VARCHAR(255), 
	"Subscriber_And_Child__c" VARCHAR(255), 
	"Subscriber_And_Children__c" VARCHAR(255), 
	"Subscriber_And_Family__c" VARCHAR(255), 
	"Subscriber_And_Spouse__c" VARCHAR(255), 
	"Subscriber__c" VARCHAR(255), 
	"Variant_Code__c" VARCHAR(255), 
	"Variant_Description__c" VARCHAR(255), 
	"Base_Rate_Schedule__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Base_Rate_Variant__c" VALUES(3,'','','880.0','1020.0','840.0','420.0','COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','','2');
INSERT INTO "Base_Rate_Variant__c" VALUES(4,'','','1020.0','1450.0','920.0','500.0','DED100/1000 COINS30/60','','4');
INSERT INTO "Base_Rate_Variant__c" VALUES(5,'','','1000.0','1500.0','1000.0','500.0','COINS20/50 DED0/1000','','3');
INSERT INTO "Base_Rate_Variant__c" VALUES(6,'','','700.0','850.0','650.0','325.0','COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','','2');
INSERT INTO "Base_Rate_Variant__c" VALUES(7,'','','820.0','1025.0','800.0','450.0','COINS25/75 DED100/1000','','5');
INSERT INTO "Base_Rate_Variant__c" VALUES(8,'','','900.0','1055.0','890.0','445.0','COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','','2');
CREATE TABLE "Competitor_Plan_Information__c" (
	id INTEGER NOT NULL, 
	"Carrier_Name__c" VARCHAR(255), 
	"DME__c" VARCHAR(255), 
	"Deductible__c" VARCHAR(255), 
	"Drug_Option__c" VARCHAR(255), 
	"Emergency_Room_Copay__c" VARCHAR(255), 
	"Family_Incentives__c" VARCHAR(255), 
	"Family_Medical_Management__c" VARCHAR(255), 
	"Family_Medical__c" VARCHAR(255), 
	"Family_Prescription_Drug__c" VARCHAR(255), 
	"HDHP_Option__c" VARCHAR(255), 
	"Inpatient_Copay__c" VARCHAR(255), 
	"Max_Dependent_Age__c" VARCHAR(255), 
	"Medical_Equipment_Rider__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Plan_Name__c" VARCHAR(255), 
	"Plan_Type__c" VARCHAR(255), 
	"Product_Category__c" VARCHAR(255), 
	"Rate_Effective_Date__c" VARCHAR(255), 
	"Rate_Termination_Date__c" VARCHAR(255), 
	"Subscriber_Children_Incentives__c" VARCHAR(255), 
	"Subscriber_Children_Medical_Management__c" VARCHAR(255), 
	"Subscriber_Children_Medical__c" VARCHAR(255), 
	"Subscriber_Children_Prescription_Drug__c" VARCHAR(255), 
	"Subscriber_Only_Incentives__c" VARCHAR(255), 
	"Subscriber_Only_Medical_Management__c" VARCHAR(255), 
	"Subscriber_Only_Medical__c" VARCHAR(255), 
	"Subscriber_Only_Prescription_Drug__c" VARCHAR(255), 
	"Subscriber_Spouse_Incentives__c" VARCHAR(255), 
	"Subscriber_Spouse_Medical_Management__c" VARCHAR(255), 
	"Subscriber_Spouse_Medical__c" VARCHAR(255), 
	"Subscriber_Spouse_Prescription_Drug__c" VARCHAR(255), 
	"Tier__c" VARCHAR(255), 
	"Customer_Account__c" VARCHAR(255), 
	"Quote__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Competitor_Plan_Information__c" VALUES(1,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','82');
INSERT INTO "Competitor_Plan_Information__c" VALUES(2,'Humana','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.37','120.0','Yes','1000','23','Y','LGP HMO 5000/10000','Easy HMO','HMO','Medical','','','0.0','0.0','350.37','90.0','0.0','0.0','202.51','50.0','0.0','0.0','450.37','100.0','4 Tier','','82');
INSERT INTO "Competitor_Plan_Information__c" VALUES(3,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','77');
INSERT INTO "Competitor_Plan_Information__c" VALUES(4,'Humana','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.37','120.0','Yes','1000','23','Y','LGP HMO 5000/10000','Easy HMO','HMO','Medical','','','0.0','0.0','350.37','90.0','0.0','0.0','202.51','50.0','0.0','0.0','450.37','100.0','4 Tier','','77');
INSERT INTO "Competitor_Plan_Information__c" VALUES(5,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','78');
INSERT INTO "Competitor_Plan_Information__c" VALUES(6,'Humana','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.37','120.0','Yes','1000','23','Y','LGP HMO 5000/10000','Easy HMO','HMO','Medical','','','0.0','0.0','350.37','90.0','0.0','0.0','202.51','50.0','0.0','0.0','450.37','100.0','4 Tier','','78');
INSERT INTO "Competitor_Plan_Information__c" VALUES(7,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','83');
INSERT INTO "Competitor_Plan_Information__c" VALUES(8,'Humana','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.37','120.0','Yes','1000','23','Y','LGP HMO 5000/10000','Easy HMO','HMO','Medical','','','0.0','0.0','350.37','90.0','0.0','0.0','202.51','50.0','0.0','0.0','450.37','100.0','4 Tier','','83');
INSERT INTO "Competitor_Plan_Information__c" VALUES(9,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','');
INSERT INTO "Competitor_Plan_Information__c" VALUES(10,'Humana','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.37','120.0','Yes','1000','23','Y','LGP HMO 5000/10000','Easy HMO','HMO','Medical','','','0.0','0.0','350.37','90.0','0.0','0.0','202.51','50.0','0.0','0.0','450.37','100.0','4 Tier','','');
INSERT INTO "Competitor_Plan_Information__c" VALUES(11,'Independent Health','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','700.0','310.0','No','500','23','Y','COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/N','Encompass Plus Advanced','PPO','Medical','','','0.0','0.0','600.0','150.0','0.0','0.0','380.0','20.0','0.0','0.0','600.0','200.0','4 Tier','','81');
INSERT INTO "Competitor_Plan_Information__c" VALUES(12,'Independent Health','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.0','120.0','Yes','1000','23','Y','COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/','Encompass Plus','PPO','Medical','','','0.0','0.0','490.0','90.0','0.0','0.0','260.0','50.0','0.0','0.0','530.0','100.0','4 Tier','','81');
INSERT INTO "Competitor_Plan_Information__c" VALUES(13,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','80');
INSERT INTO "Competitor_Plan_Information__c" VALUES(14,'Humana','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.37','120.0','Yes','1000','23','Y','LGP HMO 5000/10000','Easy HMO','HMO','Medical','','','0.0','0.0','350.37','90.0','0.0','0.0','202.51','50.0','0.0','0.0','450.37','100.0','4 Tier','','80');
INSERT INTO "Competitor_Plan_Information__c" VALUES(15,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','');
INSERT INTO "Competitor_Plan_Information__c" VALUES(16,'Humana','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.37','120.0','Yes','1000','23','Y','LGP HMO 5000/10000','Easy HMO','HMO','Medical','','','0.0','0.0','350.37','90.0','0.0','0.0','202.51','50.0','0.0','0.0','450.37','100.0','4 Tier','','');
INSERT INTO "Competitor_Plan_Information__c" VALUES(17,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','85');
INSERT INTO "Competitor_Plan_Information__c" VALUES(18,'Humana','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.37','120.0','Yes','1000','23','Y','LGP HMO 5000/10000','Easy HMO','HMO','Medical','','','0.0','0.0','350.37','90.0','0.0','0.0','202.51','50.0','0.0','0.0','450.37','100.0','4 Tier','','85');
INSERT INTO "Competitor_Plan_Information__c" VALUES(19,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','');
INSERT INTO "Competitor_Plan_Information__c" VALUES(20,'Humana','50% COINS INN','$2000 Individual/$5000 Family','$20/$50/$100','$75','0.0','0.0','1177.36','310.0','No','500','23','Y','LGP PPO 2000/5000','Easy PPO','PPO','Medical','','','0.0','0.0','714.37','190.0','0.0','0.0','402.51','100.0','0.0','0.0','906.37','200.0','4 Tier','','1');
INSERT INTO "Competitor_Plan_Information__c" VALUES(21,'Humana','50% COINS INN','$5000 Individual/$10000 Family','$100/$150/$170','$75','0.0','0.0','700.37','120.0','Yes','1000','23','Y','LGP HMO 5000/10000','Easy HMO','HMO','Medical','','','0.0','0.0','350.37','90.0','0.0','0.0','202.51','50.0','0.0','0.0','450.37','100.0','4 Tier','','1');
CREATE TABLE "Component_Attribute__c" (
	id INTEGER NOT NULL, 
	"Component_Attribute_Type__c" VARCHAR(255), 
	"Is_Key_Benefit__c" VARCHAR(255), 
	"Is_Rate_Impacting__c" VARCHAR(255), 
	"Attribute__c" VARCHAR(255), 
	"Plan_Component__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Component_Attribute__c" VALUES(147,'','False','False','8','11');
INSERT INTO "Component_Attribute__c" VALUES(148,'','False','False','9','11');
INSERT INTO "Component_Attribute__c" VALUES(149,'','False','False','10','11');
INSERT INTO "Component_Attribute__c" VALUES(150,'','False','False','11','11');
INSERT INTO "Component_Attribute__c" VALUES(151,'','False','False','12','11');
INSERT INTO "Component_Attribute__c" VALUES(152,'','False','False','13','11');
INSERT INTO "Component_Attribute__c" VALUES(153,'','False','False','14','11');
INSERT INTO "Component_Attribute__c" VALUES(154,'','False','False','15','11');
INSERT INTO "Component_Attribute__c" VALUES(155,'','False','False','16','11');
INSERT INTO "Component_Attribute__c" VALUES(156,'','False','False','17','11');
INSERT INTO "Component_Attribute__c" VALUES(157,'','False','False','18','11');
INSERT INTO "Component_Attribute__c" VALUES(158,'','False','False','19','11');
INSERT INTO "Component_Attribute__c" VALUES(159,'','False','False','20','11');
INSERT INTO "Component_Attribute__c" VALUES(160,'','False','False','21','11');
INSERT INTO "Component_Attribute__c" VALUES(161,'','False','False','22','11');
INSERT INTO "Component_Attribute__c" VALUES(162,'','False','False','23','11');
INSERT INTO "Component_Attribute__c" VALUES(163,'','False','False','24','11');
INSERT INTO "Component_Attribute__c" VALUES(164,'','False','False','25','11');
INSERT INTO "Component_Attribute__c" VALUES(165,'','False','False','27','11');
INSERT INTO "Component_Attribute__c" VALUES(166,'','True','True','28','11');
INSERT INTO "Component_Attribute__c" VALUES(167,'','True','True','29','11');
INSERT INTO "Component_Attribute__c" VALUES(168,'','False','False','30','11');
INSERT INTO "Component_Attribute__c" VALUES(169,'','False','False','31','11');
INSERT INTO "Component_Attribute__c" VALUES(170,'','False','False','32','11');
INSERT INTO "Component_Attribute__c" VALUES(171,'','False','False','33','11');
INSERT INTO "Component_Attribute__c" VALUES(172,'','False','False','34','11');
INSERT INTO "Component_Attribute__c" VALUES(173,'','False','False','35','11');
INSERT INTO "Component_Attribute__c" VALUES(174,'','False','False','37','11');
INSERT INTO "Component_Attribute__c" VALUES(175,'','False','False','38','11');
INSERT INTO "Component_Attribute__c" VALUES(176,'','False','False','39','11');
INSERT INTO "Component_Attribute__c" VALUES(177,'','False','False','40','11');
INSERT INTO "Component_Attribute__c" VALUES(178,'','False','False','41','11');
INSERT INTO "Component_Attribute__c" VALUES(179,'','False','False','42','11');
INSERT INTO "Component_Attribute__c" VALUES(180,'','False','False','43','11');
INSERT INTO "Component_Attribute__c" VALUES(181,'','False','False','44','11');
INSERT INTO "Component_Attribute__c" VALUES(182,'','False','False','45','11');
INSERT INTO "Component_Attribute__c" VALUES(183,'','False','False','46','11');
INSERT INTO "Component_Attribute__c" VALUES(184,'','False','False','50','11');
INSERT INTO "Component_Attribute__c" VALUES(185,'','False','False','51','11');
INSERT INTO "Component_Attribute__c" VALUES(186,'','False','False','52','11');
INSERT INTO "Component_Attribute__c" VALUES(187,'','False','False','53','11');
INSERT INTO "Component_Attribute__c" VALUES(188,'','False','False','54','11');
INSERT INTO "Component_Attribute__c" VALUES(189,'','False','False','55','11');
INSERT INTO "Component_Attribute__c" VALUES(190,'','False','False','56','11');
INSERT INTO "Component_Attribute__c" VALUES(191,'','True','True','2','12');
INSERT INTO "Component_Attribute__c" VALUES(192,'','True','True','3','12');
INSERT INTO "Component_Attribute__c" VALUES(193,'','True','True','4','12');
INSERT INTO "Component_Attribute__c" VALUES(194,'','True','True','5','12');
INSERT INTO "Component_Attribute__c" VALUES(195,'','True','True','6','12');
INSERT INTO "Component_Attribute__c" VALUES(196,'','False','False','8','13');
INSERT INTO "Component_Attribute__c" VALUES(197,'','False','False','9','13');
INSERT INTO "Component_Attribute__c" VALUES(198,'','False','False','10','13');
INSERT INTO "Component_Attribute__c" VALUES(199,'','False','False','11','13');
INSERT INTO "Component_Attribute__c" VALUES(200,'','False','False','12','13');
INSERT INTO "Component_Attribute__c" VALUES(201,'','False','False','13','13');
INSERT INTO "Component_Attribute__c" VALUES(202,'','False','False','14','13');
INSERT INTO "Component_Attribute__c" VALUES(203,'','False','False','15','13');
INSERT INTO "Component_Attribute__c" VALUES(204,'','False','False','16','13');
INSERT INTO "Component_Attribute__c" VALUES(205,'','False','False','17','13');
INSERT INTO "Component_Attribute__c" VALUES(206,'','False','False','18','13');
INSERT INTO "Component_Attribute__c" VALUES(207,'','False','False','19','13');
INSERT INTO "Component_Attribute__c" VALUES(208,'','False','False','20','13');
INSERT INTO "Component_Attribute__c" VALUES(209,'','False','False','21','13');
INSERT INTO "Component_Attribute__c" VALUES(210,'','False','False','22','13');
INSERT INTO "Component_Attribute__c" VALUES(211,'','False','False','23','13');
INSERT INTO "Component_Attribute__c" VALUES(212,'','False','False','24','13');
INSERT INTO "Component_Attribute__c" VALUES(213,'','False','False','25','13');
INSERT INTO "Component_Attribute__c" VALUES(214,'','False','False','27','13');
INSERT INTO "Component_Attribute__c" VALUES(215,'','True','True','28','13');
INSERT INTO "Component_Attribute__c" VALUES(216,'','True','True','29','13');
INSERT INTO "Component_Attribute__c" VALUES(217,'','False','False','30','13');
INSERT INTO "Component_Attribute__c" VALUES(218,'','False','False','31','13');
INSERT INTO "Component_Attribute__c" VALUES(219,'','False','False','32','13');
INSERT INTO "Component_Attribute__c" VALUES(220,'','False','False','33','13');
INSERT INTO "Component_Attribute__c" VALUES(221,'','False','False','34','13');
INSERT INTO "Component_Attribute__c" VALUES(222,'','False','False','35','13');
INSERT INTO "Component_Attribute__c" VALUES(223,'','False','False','37','13');
INSERT INTO "Component_Attribute__c" VALUES(224,'','False','False','38','13');
INSERT INTO "Component_Attribute__c" VALUES(225,'','False','False','39','13');
INSERT INTO "Component_Attribute__c" VALUES(226,'','False','False','40','13');
INSERT INTO "Component_Attribute__c" VALUES(227,'','False','False','41','13');
INSERT INTO "Component_Attribute__c" VALUES(228,'','False','False','42','13');
INSERT INTO "Component_Attribute__c" VALUES(229,'','False','False','43','13');
INSERT INTO "Component_Attribute__c" VALUES(230,'','False','False','44','13');
INSERT INTO "Component_Attribute__c" VALUES(231,'','False','False','45','13');
INSERT INTO "Component_Attribute__c" VALUES(232,'','False','False','46','13');
INSERT INTO "Component_Attribute__c" VALUES(233,'','False','False','50','13');
INSERT INTO "Component_Attribute__c" VALUES(234,'','False','False','51','13');
INSERT INTO "Component_Attribute__c" VALUES(235,'','False','False','52','13');
INSERT INTO "Component_Attribute__c" VALUES(236,'','False','False','53','13');
INSERT INTO "Component_Attribute__c" VALUES(237,'','False','False','54','13');
INSERT INTO "Component_Attribute__c" VALUES(238,'','False','False','55','13');
INSERT INTO "Component_Attribute__c" VALUES(239,'','False','False','56','13');
INSERT INTO "Component_Attribute__c" VALUES(240,'','False','False','8','14');
INSERT INTO "Component_Attribute__c" VALUES(241,'','False','False','9','14');
INSERT INTO "Component_Attribute__c" VALUES(242,'','False','False','10','14');
INSERT INTO "Component_Attribute__c" VALUES(243,'','False','False','11','14');
INSERT INTO "Component_Attribute__c" VALUES(244,'','False','False','12','14');
INSERT INTO "Component_Attribute__c" VALUES(245,'','False','False','13','14');
INSERT INTO "Component_Attribute__c" VALUES(246,'','False','False','14','14');
INSERT INTO "Component_Attribute__c" VALUES(247,'','False','False','15','14');
INSERT INTO "Component_Attribute__c" VALUES(248,'','False','False','16','14');
INSERT INTO "Component_Attribute__c" VALUES(249,'','False','False','17','14');
INSERT INTO "Component_Attribute__c" VALUES(250,'','False','False','18','14');
INSERT INTO "Component_Attribute__c" VALUES(251,'','False','False','19','14');
INSERT INTO "Component_Attribute__c" VALUES(252,'','False','False','20','14');
INSERT INTO "Component_Attribute__c" VALUES(253,'','False','False','21','14');
INSERT INTO "Component_Attribute__c" VALUES(254,'','False','False','22','14');
INSERT INTO "Component_Attribute__c" VALUES(255,'','False','False','23','14');
INSERT INTO "Component_Attribute__c" VALUES(256,'','False','False','24','14');
INSERT INTO "Component_Attribute__c" VALUES(257,'','False','False','25','14');
INSERT INTO "Component_Attribute__c" VALUES(258,'','False','False','27','14');
INSERT INTO "Component_Attribute__c" VALUES(259,'','True','True','28','14');
INSERT INTO "Component_Attribute__c" VALUES(260,'','True','True','29','14');
INSERT INTO "Component_Attribute__c" VALUES(261,'','False','False','30','14');
INSERT INTO "Component_Attribute__c" VALUES(262,'','False','False','31','14');
INSERT INTO "Component_Attribute__c" VALUES(263,'','False','False','32','14');
INSERT INTO "Component_Attribute__c" VALUES(264,'','False','False','33','14');
INSERT INTO "Component_Attribute__c" VALUES(265,'','False','False','34','14');
INSERT INTO "Component_Attribute__c" VALUES(266,'','False','False','35','14');
INSERT INTO "Component_Attribute__c" VALUES(267,'','False','False','37','14');
INSERT INTO "Component_Attribute__c" VALUES(268,'','False','False','38','14');
INSERT INTO "Component_Attribute__c" VALUES(269,'','False','False','39','14');
INSERT INTO "Component_Attribute__c" VALUES(270,'','False','False','40','14');
INSERT INTO "Component_Attribute__c" VALUES(271,'','False','False','41','14');
INSERT INTO "Component_Attribute__c" VALUES(272,'','False','False','42','14');
INSERT INTO "Component_Attribute__c" VALUES(273,'','False','False','43','14');
INSERT INTO "Component_Attribute__c" VALUES(274,'','False','False','44','14');
INSERT INTO "Component_Attribute__c" VALUES(275,'','False','False','45','14');
INSERT INTO "Component_Attribute__c" VALUES(276,'','False','False','46','14');
INSERT INTO "Component_Attribute__c" VALUES(277,'','False','False','50','14');
INSERT INTO "Component_Attribute__c" VALUES(278,'','False','False','51','14');
INSERT INTO "Component_Attribute__c" VALUES(279,'','False','False','52','14');
INSERT INTO "Component_Attribute__c" VALUES(280,'','False','False','53','14');
INSERT INTO "Component_Attribute__c" VALUES(281,'','False','False','54','14');
INSERT INTO "Component_Attribute__c" VALUES(282,'','False','False','55','14');
INSERT INTO "Component_Attribute__c" VALUES(283,'','False','False','56','14');
INSERT INTO "Component_Attribute__c" VALUES(284,'','False','False','2','15');
INSERT INTO "Component_Attribute__c" VALUES(285,'','False','False','3','15');
INSERT INTO "Component_Attribute__c" VALUES(286,'','False','False','4','15');
INSERT INTO "Component_Attribute__c" VALUES(287,'','False','False','5','15');
INSERT INTO "Component_Attribute__c" VALUES(288,'','False','False','6','15');
INSERT INTO "Component_Attribute__c" VALUES(289,'','False','False','8','15');
INSERT INTO "Component_Attribute__c" VALUES(290,'','False','False','9','15');
INSERT INTO "Component_Attribute__c" VALUES(291,'','False','False','10','15');
INSERT INTO "Component_Attribute__c" VALUES(292,'','False','False','11','15');
INSERT INTO "Component_Attribute__c" VALUES(293,'','False','False','12','15');
INSERT INTO "Component_Attribute__c" VALUES(294,'','False','False','13','15');
INSERT INTO "Component_Attribute__c" VALUES(295,'','False','False','14','15');
INSERT INTO "Component_Attribute__c" VALUES(296,'','False','False','15','15');
INSERT INTO "Component_Attribute__c" VALUES(297,'','False','False','16','15');
INSERT INTO "Component_Attribute__c" VALUES(298,'','False','False','17','15');
INSERT INTO "Component_Attribute__c" VALUES(299,'','False','False','18','15');
INSERT INTO "Component_Attribute__c" VALUES(300,'','False','False','19','15');
INSERT INTO "Component_Attribute__c" VALUES(301,'','False','False','20','15');
INSERT INTO "Component_Attribute__c" VALUES(302,'','False','False','21','15');
INSERT INTO "Component_Attribute__c" VALUES(303,'','False','False','22','15');
INSERT INTO "Component_Attribute__c" VALUES(304,'','False','False','23','15');
INSERT INTO "Component_Attribute__c" VALUES(305,'','False','False','24','15');
INSERT INTO "Component_Attribute__c" VALUES(306,'','False','False','25','15');
INSERT INTO "Component_Attribute__c" VALUES(307,'','False','False','27','15');
INSERT INTO "Component_Attribute__c" VALUES(308,'','True','True','28','15');
INSERT INTO "Component_Attribute__c" VALUES(309,'','True','True','29','15');
INSERT INTO "Component_Attribute__c" VALUES(310,'','False','False','30','15');
INSERT INTO "Component_Attribute__c" VALUES(311,'','False','False','31','15');
INSERT INTO "Component_Attribute__c" VALUES(312,'','False','False','32','15');
INSERT INTO "Component_Attribute__c" VALUES(313,'','False','False','33','15');
INSERT INTO "Component_Attribute__c" VALUES(314,'','False','False','34','15');
INSERT INTO "Component_Attribute__c" VALUES(315,'','False','False','35','15');
INSERT INTO "Component_Attribute__c" VALUES(316,'','False','False','37','15');
INSERT INTO "Component_Attribute__c" VALUES(317,'','False','False','38','15');
INSERT INTO "Component_Attribute__c" VALUES(318,'','False','False','39','15');
INSERT INTO "Component_Attribute__c" VALUES(319,'','False','False','40','15');
INSERT INTO "Component_Attribute__c" VALUES(320,'','False','False','41','15');
INSERT INTO "Component_Attribute__c" VALUES(321,'','False','False','42','15');
INSERT INTO "Component_Attribute__c" VALUES(322,'','False','False','43','15');
INSERT INTO "Component_Attribute__c" VALUES(323,'','False','False','44','15');
INSERT INTO "Component_Attribute__c" VALUES(324,'','False','False','45','15');
INSERT INTO "Component_Attribute__c" VALUES(325,'','False','False','46','15');
INSERT INTO "Component_Attribute__c" VALUES(326,'','False','False','50','15');
INSERT INTO "Component_Attribute__c" VALUES(327,'','False','False','51','15');
INSERT INTO "Component_Attribute__c" VALUES(328,'','False','False','52','15');
INSERT INTO "Component_Attribute__c" VALUES(329,'','False','False','53','15');
INSERT INTO "Component_Attribute__c" VALUES(330,'','False','False','54','15');
INSERT INTO "Component_Attribute__c" VALUES(331,'','False','False','55','15');
INSERT INTO "Component_Attribute__c" VALUES(332,'','False','False','56','15');
CREATE TABLE "Contact" (
	id INTEGER NOT NULL, 
	"DoNotCall" VARCHAR(255), 
	"FirstName" VARCHAR(255), 
	"HasOptedOutOfEmail" VARCHAR(255), 
	"HasOptedOutOfFax" VARCHAR(255), 
	"LastName" VARCHAR(255), 
	"IsPersonAccount" VARCHAR(255), 
	"AccountId" VARCHAR(255), 
	"ReportsToId" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Contact" VALUES(1,'False','John','False','False','Smith','False','1','');
INSERT INTO "Contact" VALUES(2,'False','Edward','False','False','Stamos','False','2','');
CREATE TABLE "Eligibility__c" (
	id INTEGER NOT NULL, 
	"Average_Total_Employees_for_prior_year__c" VARCHAR(255), 
	"Eligible_Emp_w_coverage__c" VARCHAR(255), 
	"Eligible_Emp_wo_coverage__c" VARCHAR(255), 
	"Employees_First_Day__c" VARCHAR(255), 
	"Group_Employed_20_Emp__c" VARCHAR(255), 
	"Group_has_1099_Employees__c" VARCHAR(255), 
	"Number_Cobra_Continuants__c" VARCHAR(255), 
	"Number_Employees_WP__c" VARCHAR(255), 
	"Participation_Requirement_Percent__c" VARCHAR(255), 
	"Response_Channel__c" VARCHAR(255), 
	"Status__c" VARCHAR(255), 
	"TEFRA_DEFRA_Medicare__c" VARCHAR(255), 
	"Total_Employees__c" VARCHAR(255), 
	"Total_PartTime__c" VARCHAR(255), 
	"Customer_Account__c" VARCHAR(255), 
	"Quote__c" VARCHAR(255), 
	PRIMARY KEY (id)
);

CREATE TABLE "Group_Class__c" (
	id INTEGER NOT NULL, 
	"Class_Description__c" VARCHAR(255), 
	"Class_Type__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Customer_Account__c" VARCHAR(255), 
	"Quote__c" VARCHAR(255), 
	PRIMARY KEY (id)
);

CREATE TABLE "Marketing_Plan_Benefit__c" (
	id INTEGER NOT NULL, 
	"CPQ_Disp_Sort__c" VARCHAR(255), 
	"Attribute_Value__c" VARCHAR(255), 
	"Component_Attribute__c" VARCHAR(255), 
	"Marketing_Plan__c" VARCHAR(255), 
	"Plan_Template_Component__c" VARCHAR(255), 
	PRIMARY KEY (id)
);

INSERT INTO "Marketing_Plan_Benefit__c" VALUES(51,'1.0','305','166','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(52,'1.0','309','167','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(53,'15.0','224','154','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(54,'16.0','225','155','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(55,'9.0','226','156','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(56,'9.0','229','157','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(57,'9.0','232','158','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(58,'6.0','235','159','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(59,'6.0','239','160','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(60,'6.0','264','161','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(61,'6.0','268','162','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(62,'4.0','271','163','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(63,'10.0','440','190','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(64,'1.0','304','165','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(65,'1.0','311','168','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(66,'5.0','312','169','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(67,'5.0','314','170','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(68,'5.0','318','171','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(69,'5.0','320','172','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(70,'5.0','324','173','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(71,'5.0','331','174','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(72,'7.0','335','175','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(73,'7.0','339','176','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(74,'8.0','342','177','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(75,'8.0','346','178','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(76,'8.0','349','179','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(77,'8.0','352','180','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(78,'8.0','356','181','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(79,'3.0','359','182','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(80,'3.0','393','183','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(81,'3.0','427','184','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(82,'12.0','430','185','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(83,'12.0','431','186','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(84,'10.0','433','187','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(85,'10.0','436','188','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(86,'10.0','439','189','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(87,'15.0','223','153','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(88,'14.0','222','152','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(89,'14.0','221','151','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(90,'14.0','218','150','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(91,'14.0','193','149','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(92,'14.0','192','148','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(93,'14.0','191','147','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(94,'4.0','297','164','3','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(95,'11.0','179','191','3','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(96,'11.0','183','192','3','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(97,'11.0','184','193','3','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(98,'11.0','188','194','3','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(99,'11.0','189','195','3','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(100,'1.0','545','215','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(101,'1.0','548','216','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(102,'14.0','527','198','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(103,'14.0','528','199','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(104,'14.0','529','200','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(105,'14.0','530','201','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(106,'15.0','531','202','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(107,'15.0','532','203','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(108,'16.0','533','204','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(109,'9.0','534','205','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(110,'9.0','535','206','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(111,'9.0','536','207','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(112,'6.0','537','208','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(113,'6.0','538','209','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(114,'6.0','539','210','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(115,'6.0','540','211','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(116,'4.0','541','212','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(117,'4.0','542','213','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(118,'1.0','543','214','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(119,'10.0','574','239','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(120,'5.0','550','218','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(121,'5.0','551','219','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(122,'5.0','555','220','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(123,'5.0','556','221','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(124,'5.0','557','222','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(125,'5.0','558','223','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(126,'7.0','559','224','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(127,'7.0','560','225','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(128,'8.0','561','226','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(129,'8.0','562','227','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(130,'8.0','563','228','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(131,'8.0','564','229','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(132,'8.0','565','230','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(133,'3.0','566','231','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(134,'3.0','567','232','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(135,'3.0','568','233','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(136,'12.0','569','234','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(137,'12.0','570','235','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(138,'10.0','571','236','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(139,'10.0','572','237','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(140,'10.0','573','238','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(141,'14.0','526','197','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(142,'14.0','525','196','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(143,'1.0','549','217','4','11');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(144,'1.0','306','166','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(145,'1.0','310','167','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(146,'15.0','224','154','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(147,'16.0','225','155','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(148,'9.0','226','156','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(149,'9.0','229','157','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(150,'9.0','232','158','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(151,'6.0','235','159','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(152,'6.0','239','160','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(153,'6.0','264','161','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(154,'6.0','268','162','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(155,'4.0','271','163','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(156,'10.0','440','190','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(157,'1.0','304','165','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(158,'1.0','311','168','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(159,'5.0','312','169','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(160,'5.0','314','170','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(161,'5.0','318','171','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(162,'5.0','320','172','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(163,'5.0','324','173','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(164,'5.0','331','174','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(165,'7.0','335','175','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(166,'7.0','339','176','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(167,'8.0','342','177','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(168,'8.0','346','178','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(169,'8.0','349','179','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(170,'8.0','352','180','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(171,'8.0','356','181','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(172,'3.0','359','182','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(173,'3.0','393','183','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(174,'3.0','427','184','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(175,'12.0','430','185','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(176,'12.0','431','186','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(177,'10.0','433','187','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(178,'10.0','436','188','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(179,'10.0','439','189','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(180,'15.0','223','153','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(181,'14.0','222','152','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(182,'14.0','221','151','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(183,'14.0','218','150','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(184,'14.0','193','149','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(185,'14.0','192','148','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(186,'14.0','191','147','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(187,'4.0','297','164','5','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(188,'11.0','180','191','5','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(189,'11.0','182','192','5','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(190,'11.0','185','193','5','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(191,'11.0','188','194','5','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(192,'11.0','189','195','5','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(193,'8.0','631','273','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(194,'8.0','632','274','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(195,'3.0','633','275','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(196,'3.0','634','276','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(197,'3.0','635','277','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(198,'12.0','636','278','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(199,'12.0','637','279','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(200,'10.0','638','280','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(201,'10.0','639','281','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(202,'10.0','640','282','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(203,'14.0','593','241','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(204,'14.0','592','240','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(205,'1.0','616','261','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(206,'1.0','611','259','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(207,'1.0','614','260','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(208,'14.0','594','242','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(209,'14.0','595','243','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(210,'14.0','596','244','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(211,'14.0','597','245','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(212,'15.0','598','246','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(213,'15.0','599','247','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(214,'16.0','600','248','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(215,'9.0','601','249','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(216,'9.0','602','250','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(217,'9.0','603','251','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(218,'6.0','604','252','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(219,'6.0','605','253','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(220,'1.0','495','309','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(221,'1.0','493','308','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(222,'11.0','467','286','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(223,'11.0','470','287','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(224,'11.0','471','288','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(225,'14.0','472','289','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(226,'14.0','473','290','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(227,'14.0','474','291','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(228,'14.0','475','292','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(229,'14.0','476','293','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(230,'14.0','477','294','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(231,'15.0','478','295','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(232,'15.0','479','296','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(233,'16.0','480','297','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(234,'9.0','481','298','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(235,'9.0','482','299','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(236,'9.0','483','300','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(237,'6.0','484','301','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(238,'6.0','485','302','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(239,'6.0','486','303','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(240,'6.0','487','304','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(241,'4.0','488','305','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(242,'10.0','520','332','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(243,'1.0','490','307','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(244,'1.0','496','310','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(245,'5.0','497','311','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(246,'5.0','499','312','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(247,'5.0','502','313','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(248,'5.0','503','314','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(249,'5.0','504','315','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(250,'5.0','505','316','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(251,'7.0','506','317','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(252,'6.0','606','254','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(253,'6.0','607','255','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(254,'4.0','608','256','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(255,'4.0','609','257','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(256,'1.0','610','258','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(257,'10.0','641','283','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(258,'5.0','617','262','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(259,'5.0','618','263','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(260,'5.0','622','264','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(261,'5.0','623','265','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(262,'5.0','624','266','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(263,'5.0','625','267','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(264,'7.0','626','268','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(265,'7.0','627','269','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(266,'8.0','628','270','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(267,'8.0','629','271','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(268,'7.0','507','318','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(269,'8.0','508','319','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(270,'8.0','509','320','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(271,'8.0','521','321','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(272,'8.0','510','322','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(273,'8.0','511','323','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(274,'3.0','512','324','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(275,'3.0','513','325','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(276,'3.0','514','326','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(277,'12.0','515','327','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(278,'12.0','516','328','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(279,'10.0','517','329','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(280,'10.0','518','330','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(281,'10.0','519','331','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(282,'11.0','466','285','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(283,'11.0','522','284','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(284,'4.0','489','306','6','13');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(285,'8.0','630','272','7','12');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(382,'16.0','306','166','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(383,'1.0','308','167','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(384,'1.0','224','154','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(385,'1.0','225','155','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(386,'3.0','226','156','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(387,'9.0','229','157','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(388,'9.0','232','158','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(389,'6.0','235','159','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(390,'6.0','239','160','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(391,'6.0','264','161','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(392,'6.0','268','162','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(393,'4.0','271','163','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(394,'10.0','440','190','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(395,'1.0','304','165','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(396,'1.0','311','168','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(397,'5.0','312','169','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(398,'5.0','314','170','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(399,'5.0','318','171','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(400,'5.0','320','172','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(401,'5.0','324','173','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(402,'5.0','331','174','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(403,'7.0','335','175','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(404,'7.0','339','176','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(405,'8.0','342','177','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(406,'8.0','346','178','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(407,'8.0','349','179','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(408,'8.0','352','180','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(409,'8.0','356','181','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(410,'3.0','359','182','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(411,'3.0','393','183','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(412,'3.0','427','184','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(413,'12.0','430','185','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(414,'12.0','431','186','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(415,'10.0','433','187','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(416,'10.0','436','188','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(417,'10.0','439','189','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(418,'15.0','223','153','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(419,'14.0','222','152','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(420,'14.0','221','151','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(421,'14.0','218','150','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(422,'14.0','193','149','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(423,'14.0','192','148','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(424,'14.0','191','147','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(425,'4.0','297','164','11','9');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(426,'11.0','180','191','11','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(427,'11.0','183','192','11','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(428,'11.0','184','193','11','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(429,'11.0','187','194','11','10');
INSERT INTO "Marketing_Plan_Benefit__c" VALUES(430,'11.0','189','195','11','10');
CREATE TABLE "Marketing_Plan__c" (
	id INTEGER NOT NULL, 
	"Close_Date__c" VARCHAR(255), 
	"Discontinued_Date__c" VARCHAR(255), 
	"Effective_Date__c" VARCHAR(255), 
	"Exchange_Value__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Plan_Component_Code__c" VARCHAR(255), 
	"Plan_Name__c" VARCHAR(255), 
	"Status__c" VARCHAR(255), 
	"Termination_Date__c" VARCHAR(255), 
	"Version__c" VARCHAR(255), 
	"Base_Rate_Variant__c" VARCHAR(255), 
	"Plan_Family__c" VARCHAR(255), 
	"Plan_Template__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Marketing_Plan__c" VALUES(3,'','','2020-12-01','','Encompass Plus','COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','Encompass Plus COINS40/40 DED1500/3000 ACV25/40 ADMEDED50/40 AHHC40/40 APADED50/40 AUB250/NC','Active','2021-12-31','1.0','','7','6');
INSERT INTO "Marketing_Plan__c" VALUES(4,'','','2020-01-01','','Choice Plus','COINS25/75 DED100/1000','Choice Plus COINS25/75 DED100/1000','Workspace','2021-12-31','1.0','','13','8');
INSERT INTO "Marketing_Plan__c" VALUES(5,'','','2020-12-01','','Encompass Plus Advanced','COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','Encompass Plus COINS20/40 DED5000/10000 ACVDED25/40 ADME50/40 AHHCDED40/40 APADED50/40 AUB250/NC','Active','2021-12-31','1.0','','7','6');
INSERT INTO "Marketing_Plan__c" VALUES(6,'','','2020-12-01','','iDirect','DED100/1000 COINS30/60','iDirect DED100/1000 COINS30/60','Workspace','2021-12-31','1.0','','10','7');
INSERT INTO "Marketing_Plan__c" VALUES(7,'','','2020-12-01','','Evolve','COINS20/50 DED0/1000','Evolve COINS20/50 DED0/1000','Workspace','2021-12-31','1.0','','9','9');
INSERT INTO "Marketing_Plan__c" VALUES(10,'','','2020-12-01','','Encompass Plus','','','Workspace','2020-12-31','1.0','','7','6');
INSERT INTO "Marketing_Plan__c" VALUES(11,'','','2020-12-01','','Encompass Plus Variation 2','COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','Encompass Plus COINS20/40 DED1500/1500 ACVDED25/40 ADMEDED50/40 AHHC40/40 APA50/40 AUB250/NC','Workspace','2020-12-31','1.0','','7','6');
CREATE TABLE "Opportunity" (
	id INTEGER NOT NULL, 
	"CloseDate" VARCHAR(255), 
	"DeliveryInstallationStatus__c" VARCHAR(255), 
	"Financial_Arrangement__c" VARCHAR(255), 
	"IsPrivate" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"StageName" VARCHAR(255), 
	"AccountId" VARCHAR(255), 
	"ContactId" VARCHAR(255), 
	"SyncedQuoteId" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Opportunity" VALUES(30,'2020-03-01','','Experience Rated','False','Woodstream Corp NewBusiness  March 1, 2020','Closed Won','2','','');
INSERT INTO "Opportunity" VALUES(35,'2021-11-01','','Community Rated','False','Woodstream Corp NewBusiness  November 1, 2021','Prospecting','2','','');
INSERT INTO "Opportunity" VALUES(66,'2021-02-22','','Experience Rated','False','Salada Biomedical Inc NewBusiness  March 1, 2021','Closed Won','1','','');
CREATE TABLE "Plan_Component__c" (
	id INTEGER NOT NULL, 
	"Effective_Date__c" VARCHAR(255), 
	"Is_Base_Component__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Plan_Component_Code__c" VARCHAR(255), 
	"Product_Component_Desc__c" VARCHAR(255), 
	"Product_Component_Type__c" VARCHAR(255), 
	"Status__c" VARCHAR(255), 
	"Termination_Date__c" VARCHAR(255), 
	"Version__c" VARCHAR(255), 
	"Plan_Family__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Plan_Component__c" VALUES(11,'2020-01-01','True','Encompass Plus Medical','','','Medical','Active','2020-12-31','1.0','7');
INSERT INTO "Plan_Component__c" VALUES(12,'2020-01-01','False','Encompass Plus Additional Services','','','Rider','Active','2020-12-31','1.0','7');
INSERT INTO "Plan_Component__c" VALUES(13,'2020-01-01','True','Choice Plus Medical','','','Medical','Active','2020-12-31','1.0','13');
INSERT INTO "Plan_Component__c" VALUES(14,'2020-01-01','True','Evolve Medical','','','Medical','Active','2020-12-31','1.0','9');
INSERT INTO "Plan_Component__c" VALUES(15,'2020-12-01','True','iDirect Plus','','','Medical','Workspace','2021-12-31','1.0','10');
INSERT INTO "Plan_Component__c" VALUES(19,'2021-01-01','True','Encompass Plus Medical','','','Medical','Active','2021-12-01','1.0','7');
INSERT INTO "Plan_Component__c" VALUES(22,'2020-01-01','False','Encompass Plus Additional Services','','','Rider','Active','2020-12-31','1.0','7');
CREATE TABLE "Plan_Family_Rating_Region__c" (
	id INTEGER NOT NULL, 
	"Name" VARCHAR(255), 
	"Rating_Region_Code__c" VARCHAR(255), 
	"Plan_Family__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "Plan_Family__c" (
	id INTEGER NOT NULL, 
	"Age_Off_Criteria__c" VARCHAR(255), 
	"Brand__c" VARCHAR(255), 
	"Business_Type__c" VARCHAR(255), 
	"Closed_Date__c" VARCHAR(255), 
	"Covered_Members__c" VARCHAR(255), 
	"Description__c" VARCHAR(255), 
	"Discontinued_Date__c" VARCHAR(255), 
	"Effective_Date__c" VARCHAR(255), 
	"Financial_Category_Description__c" VARCHAR(255), 
	"Financial_Category__c" VARCHAR(255), 
	"Line_Of_Business__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Plan_Cycle__c" VARCHAR(255), 
	"RecordTypeId" VARCHAR(255), 
	"Status__c" VARCHAR(255), 
	"Termination_Date__c" VARCHAR(255), 
	"Version__c" VARCHAR(255), 
	"Parent_Plan_Family__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Plan_Family__c" VALUES(7,'First Of Following Month','IHA','Large Group','','Individual+Family','','','2020-01-01','','Experience Rated','HMO','Encompass Plus','Plan Year','01211000004HdldAAC','Active','','1.0','');
INSERT INTO "Plan_Family__c" VALUES(9,'First Of Following Month','IHA','Large Group','','Individual+Family','','','2020-01-01','','Experience Rated','HMO','Evolve','Plan Year','01211000004HdldAAC','Workspace','','1.0','');
INSERT INTO "Plan_Family__c" VALUES(10,'First Of Following Month','','Small Group','','Individual+Family','','','2020-01-01','','Community Rated','HMO','iDirect','Plan Year','01211000004HdldAAC','Workspace','','1.0','');
INSERT INTO "Plan_Family__c" VALUES(13,'First Of Following Month','IHA','Large Group','','Individual+Family','','','2020-01-01','','Experience Rated','HMO','Choice Plus','Plan Year','01211000004HdldAAC','Workspace','','2.0','6');
CREATE TABLE "Plan_Family__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "Plan_Family__c_rt_mapping" VALUES('01211000004HdldAAC','Marketing_Plan_Family');
CREATE TABLE "Plan_Template_Component__c" (
	id INTEGER NOT NULL, 
	"Plan_Component__c" VARCHAR(255), 
	"Plan_Template__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Plan_Template_Component__c" VALUES(9,'11','6');
INSERT INTO "Plan_Template_Component__c" VALUES(10,'12','6');
INSERT INTO "Plan_Template_Component__c" VALUES(11,'13','8');
INSERT INTO "Plan_Template_Component__c" VALUES(12,'14','9');
INSERT INTO "Plan_Template_Component__c" VALUES(13,'15','7');
CREATE TABLE "Plan_Template__c" (
	id INTEGER NOT NULL, 
	"Description__c" VARCHAR(255), 
	"Effective_Date__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Plan_Type__c" VARCHAR(255), 
	"Status__c" VARCHAR(255), 
	"Termination_Date__c" VARCHAR(255), 
	"Version__c" VARCHAR(255), 
	"Plan_Family__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Plan_Template__c" VALUES(6,'','2020-12-01','Encompass Plus','Copay Deductible','Active','2020-12-31','1.0','7');
INSERT INTO "Plan_Template__c" VALUES(7,'','2020-12-01','iDirect','HDHP','Workspace','2021-12-31','1.0','10');
INSERT INTO "Plan_Template__c" VALUES(8,'','2020-01-01','Choice Plus','Copay Deductible','Workspace','2021-12-31','1.0','13');
INSERT INTO "Plan_Template__c" VALUES(9,'','2020-12-01','Evolve','Copay Deductible','Workspace','2021-12-31','1.0','9');
CREATE TABLE "Proposed_Plan__c" (
	id INTEGER NOT NULL, 
	"Effective_Date__c" VARCHAR(255), 
	"RecordTypeId" VARCHAR(255), 
	"Group_Class__c" VARCHAR(255), 
	"Installed_Account__c" VARCHAR(255), 
	"Marketing_Plan__c" VARCHAR(255), 
	"Quote_Request__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "Proposed_Plan__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "Proposed_Plan__c_rt_mapping" VALUES('0124x000000tD4TAAU','Installed_Plan');
INSERT INTO "Proposed_Plan__c_rt_mapping" VALUES('0124x000000tD4UAAU','Proposed_Plan');
CREATE TABLE "Proposed_Rate__c" (
	id INTEGER NOT NULL, 
	"Family__c" VARCHAR(255), 
	"Rate_Tier__c" VARCHAR(255), 
	"Subscriber_And_Child__c" VARCHAR(255), 
	"Subscriber_And_Spouse__c" VARCHAR(255), 
	"Subscriber__c" VARCHAR(255), 
	"Subscriber_and_Children__c" VARCHAR(255), 
	"Proposed_Plan__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "Quote" (
	id INTEGER NOT NULL, 
	"CanCreateQuoteLineItems" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"ContactId" VARCHAR(255), 
	"OpportunityId" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Quote" VALUES(30,'False','New Business Quote Rogers Group LLC February 1, 2021','2','30');
INSERT INTO "Quote" VALUES(35,'False','New Business Quote Fledglingdesign February 1, 2021','1','35');
INSERT INTO "Quote" VALUES(66,'False','New Business Quote 20 Financial Co March 1, 2021','1','66');
CREATE TABLE "QuoteLineItem" (
	id INTEGER NOT NULL, 
	"Quantity" VARCHAR(255), 
	"UnitPrice" VARCHAR(255), 
	"QuoteId" VARCHAR(255), 
	"Product2Id" VARCHAR(255),
	PRIMARY KEY (id)
);
INSERT INTO "QuoteLineItem" VALUES(69,'1.0','1.0','30',1);
INSERT INTO "QuoteLineItem" VALUES(84,'1.0','1.0','35',1);
INSERT INTO "QuoteLineItem" VALUES(85,'1.0','1.0','35',1);
INSERT INTO "QuoteLineItem" VALUES(182,'1.0','1.0','66',1);
CREATE TABLE "Quote_Census__c" (
	id INTEGER NOT NULL, 
	"Date_Of_Birth__c" VARCHAR(255), 
	"Employee_Number__c" VARCHAR(255), 
	"Gender__c" VARCHAR(255), 
	"Last_Name__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Relation__c" VARCHAR(255), 
	"Status__c" VARCHAR(255), 
	"Tobacco_Use__c" VARCHAR(255), 
	"Quote__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Quote_Census__c" VALUES(1,'1985-06-22','3','Female','Jackson','Mary','Spouse','Active','False','30');
INSERT INTO "Quote_Census__c" VALUES(2,'1999-06-01','3','Male','Jackson','Jerry','Dependent','Active','False','30');

CREATE TABLE "Quote_Line_Benefit__c" (
	id INTEGER NOT NULL, 
	"Attribute_Category__c" VARCHAR(255), 
	"Attribute_Code__c" VARCHAR(255), 
	"Attribute_Display_Name__c" VARCHAR(255), 
	"Attribute_Long_Code__c" VARCHAR(255), 
	"Attribute_Value_Amount__c" VARCHAR(255), 
	"CPQ_Disp_Sort__c" VARCHAR(255), 
	"Component_Name__c" VARCHAR(255), 
	"Component_Type__c" VARCHAR(255), 
	"In_Network_Display_Name__c" VARCHAR(255), 
	"Is_Base_Component_Benefit__c" VARCHAR(255), 
	"Is_Key_Benefit__c" VARCHAR(255), 
	"Is_Rate_Impacting__c" VARCHAR(255), 
	"Limits_and_Exceptions__c" VARCHAR(255), 
	"Out_of_Network_Display_Value__c" VARCHAR(255), 
	"Parent_Quote_Line__c" VARCHAR(255), 
	PRIMARY KEY (id)
);

INSERT INTO "Quote_Line_Benefit__c" VALUES(2729,'General Information','COINS','Coinsurance','COINS','40/40','','Encompass Plus Medical','Medical','Network A: Applies Where Indicated Network B: 40%','true','true','true','','40%','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2730,'General Information','DED','Deductible','DED','1500/3000','','Encompass Plus Medical','Medical','Network A: $1,500 / $3,000 Network B: $3,000 / $6,000','true','true','true','','$3,000 / $6,000','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2731,'Dental Services','DS-PR','Preventive and Routine','DS-PR','NC/NC','','Encompass Plus Medical','Medical','Not Covered','true','false','false','','Not Covered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2732,'Dependent Coverage','DEP','Dependent Eligibility','DEP','26/26','','Encompass Plus Medical','Medical','26','true','false','false','','26','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2733,'Diabetic Supplies and Services','DE','Diabetic Equipment (e.g. Blood glucose monitor, etc.)','DE','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2734,'Diabetic Supplies and Services','DIO','Insulin and Other Oral Agents','DIO','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2735,'Diabetic Supplies and Services','DMS','Diabetic Medical Supplies (Test Strips, Syringes, etc.)','DMS','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2736,'Diagnostic Testing Services','AR','Advanced Radiology','AR','100/40','','Encompass Plus Medical','Medical','Network A: $100 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2737,'Diagnostic Testing Services','DT','Laboratory Testing','DT','0/40','','Encompass Plus Medical','Medical','Network A: $0 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2738,'Diagnostic Testing Services','EKG','EKG','EKG','25/40','','Encompass Plus Medical','Medical','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2739,'Diagnostic Testing Services','RR','Routine Radiology','RR','40/40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2740,'Emergency & Urgent Care Services','ER','Emergency Room','ER','150/150','','Encompass Plus Medical','Medical','Network A: $150 copay / visit Network B: $150 copay / visit','true','false','false','','$150 copay / visit','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2741,'Rehabilitation Services','RPR','Pulmonary Rehabilitation','RPR','40/40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2742,'General Information','APL','Annual Maximum','APL','NA/NA','','Encompass Plus Medical','Medical','Not Applicable','true','false','false','','Not Applicable','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2743,'General Information','MOOP','Out-of-Pocket Maximum','MOOP','0/DED40','','Encompass Plus Medical','Medical','Network A: $5,000 / $10,000 Network B: $6,350 / $12,700','true','false','false','','$10,000 / $20,000','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2744,'Hospital and Other Facility Services','INHSPS','Inpatient Hospice','INHSPS','0/DED40','','Encompass Plus Medical','Medical','Network A: $0 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2745,'Hospital and Other Facility Services','INP','Inpatient Hospital','INP','500/40','','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2746,'Hospital and Other Facility Services','INPP','Inpatient Hospital: Physician/Surgeon Fees','INPP','0/40','','Encompass Plus Medical','Medical','Network A: $0 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2747,'Hospital and Other Facility Services','OSP-A','Outpatient Surgical Procedures (Ambulatory Surgery Center)','OSP-A','125/40','','Encompass Plus Medical','Medical','Network A: $125 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2748,'Hospital and Other Facility Services','OSP-H','Outpatient Surgical Procedures (Hospital Facility)','OSP-H','150/40','','Encompass Plus Medical','Medical','Network A: $150 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2749,'Hospital and Other Facility Services','SNF','Skilled Nursing Facility','SNF','250/40','','Encompass Plus Medical','Medical','Network A: $250 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2750,'Maternity Services','PPS-F','Inpatient Maternity','PPS-F','500/40','','Encompass Plus Medical','Medical','Delivery: Network A: $500 copay / admission Physician: Network A: $0 copay / procedure Delivery: Network B: Deductible then 40% coinsurance Physician: Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2751,'Maternity Services','PPS-OV','Physician Services: Prenatal and Postnatal Care','PPS-OV','DED0/40','','Encompass Plus Medical','Medical','Network A: $0 copay / visit Network B: Deductible then $0 copay / visit','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2752,'Mental Health & Substance Abuse','MBHI','Inpatient Mental Health','MBHI','500/40','','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2753,'Mental Health & Substance Abuse','MBHO','Outpatient Mental Health','MBHO','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2754,'Mental Health & Substance Abuse','MISD','Inpatient Substance Abuse - Detox','MISD','500/40','','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2755,'Mental Health & Substance Abuse','MISR','Inpatient Substance Abuse - Rehab','MISR','500/40','','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2756,'Mental Health & Substance Abuse','MOSA','Outpatient Substance Abuse','MOSA','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2757,'Physician and Other Services','ATT','Allergy Testing & Treatment','ATT','DED20/DED40','','Encompass Plus Medical','Medical','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2758,'Physician and Other Services','OPP','Outpatient Surgical Procedures (in physician''s office)','OPP','25/40','','Encompass Plus Medical','Medical','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2759,'Physician and Other Services','TMH','Telemedicine Including Mental Health, Behavioral Health and Substance Use Disorder','TMH','0/NC','','Encompass Plus Medical','Medical','$0 copay / consultation','true','false','false','','Not Covered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2760,'Prescription Drug Coverage','RX-MD','Medicare Part D Creditable Coverage Status','RX-MD','C/NA','','Encompass Plus Medical','Medical','Creditable','true','false','false','','Not Applicable','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2761,'Prescription Drug Coverage','RX-PP','Prescription Plan','RX-PP','4/NC','','Encompass Plus Medical','Medical','$4/$15/$30','true','false','false','','Not Covered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2762,'Rehabilitation Services','RCR','Cardiac Rehabilitation','RCR','40/DED40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2763,'Rehabilitation Services','RCS','Chiropractic Services','RCS','40/DED40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2764,'Rehabilitation Services','RPO','Physical - Occupational - Speech Therapies','RPO','DED20/DED40','','Encompass Plus Medical','Medical','Deductible then 20% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2765,'Dental Services','DS-AD','Accidental Dental','DS-AD','0/NA','','Encompass Plus Medical','Medical','Based on services rendered','true','false','false','','Based on services rendered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2766,'Adult Vision Services','AV-SPL','Standard Plastic Lenses','AV-SPL','10/NC','','Encompass Plus Medical','Medical','Single: $10 Bifocal: $10','true','false','false','','Not Covered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2767,'Adult Vision Services','AV-RE','Routine/ Refractive Exam','AV-RE','0/NC','','Encompass Plus Medical','Medical','$0 copay / visit','true','false','false','','Not Covered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2768,'Adult Vision Services','AV-ME','Medical Eye Exam','AV-ME','40/40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2769,'Adult Vision Services','AV-LV','Laser Vision Correction','AV-LV','15/NC','','Encompass Plus Medical','Medical','15% discount','true','false','false','','Not Covered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2770,'Adult Vision Services','AV-F','Frames','AV-F','60/NC','','Encompass Plus Medical','Medical','$60 allowance','true','false','false','','Not Covered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2771,'Adult Vision Services','AV-C','Conventional Contact Lenses','AV-C','90/NC','','Encompass Plus Medical','Medical','$90 allowance','true','false','false','','Not Covered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2772,'Emergency & Urgent Care Services','ERT','Ambulance','ERT','150/150','','Encompass Plus Medical','Medical','Network A: $150 copay / trip Network B: $150 copay / trip','true','false','false','','$150 copay / trip','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2773,'Additional Services','ACV','Chemotherapy','ACV','25/40','','Encompass Plus Additional Services','Rider','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','false','true','true','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2774,'Additional Services','ADME','Durable Medical Equipment','ADME','DED50/40','','Encompass Plus Additional Services','Rider','Network A: Deductible then 50% coinsurance Network B: Deductible then 50% coinsurance','false','true','true','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2775,'Additional Services','AHHC','Home Health Care','AHHC','40/40','','Encompass Plus Additional Services','Rider','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','false','true','true','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2776,'Additional Services','APA','Prosthetics and Appliances','APA','DED50/40','','Encompass Plus Additional Services','Rider','Network A: Deductible then 50% coinsurance Network B: Deductible then 50% coinsurance','false','true','true','','Deductible then 40% coinsurance','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(2777,'Additional Services','AUB','Unique Benefits','AUB','250/NC','','Encompass Plus Additional Services','Rider','Option 1: $250 gym/wellness services allowance Option 2: Up to $500 per individual/$1,000 per family earned from the purchase of fresh produce','false','true','true','','Not Covered','69');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3679,'General Information','COINS','Coinsurance','COINS','20/40','','Encompass Plus Medical','Medical','Network A: 20% Network B: 40%','true','true','true','','40%','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3680,'General Information','DED','Deductible','DED','5000/10000','','Encompass Plus Medical','Medical','Network A: $5,000 / $10,000 Network B: $10,000 / $15,000','true','true','true','','$10,000 / $15,000','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3681,'Dental Services','DS-PR','Preventive and Routine','DS-PR','NC/NC','','Encompass Plus Medical','Medical','Not Covered','true','false','false','','Not Covered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3682,'Dependent Coverage','DEP','Dependent Eligibility','DEP','26/26','','Encompass Plus Medical','Medical','26','true','false','false','','26','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3683,'Diabetic Supplies and Services','DE','Diabetic Equipment (e.g. Blood glucose monitor, etc.)','DE','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3684,'Diabetic Supplies and Services','DIO','Insulin and Other Oral Agents','DIO','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3685,'Diabetic Supplies and Services','DMS','Diabetic Medical Supplies (Test Strips, Syringes, etc.)','DMS','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3686,'Diagnostic Testing Services','AR','Advanced Radiology','AR','100/40','','Encompass Plus Medical','Medical','Network A: $100 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3687,'Diagnostic Testing Services','DT','Laboratory Testing','DT','0/40','','Encompass Plus Medical','Medical','Network A: $0 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3688,'Diagnostic Testing Services','EKG','EKG','EKG','25/40','','Encompass Plus Medical','Medical','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3689,'Diagnostic Testing Services','RR','Routine Radiology','RR','40/40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3690,'Emergency & Urgent Care Services','ER','Emergency Room','ER','150/150','','Encompass Plus Medical','Medical','Network A: $150 copay / visit Network B: $150 copay / visit','true','false','false','','$150 copay / visit','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3691,'Rehabilitation Services','RPR','Pulmonary Rehabilitation','RPR','40/40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3692,'General Information','APL','Annual Maximum','APL','NA/NA','','Encompass Plus Medical','Medical','Not Applicable','true','false','false','','Not Applicable','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3693,'General Information','MOOP','Out-of-Pocket Maximum','MOOP','0/DED40','','Encompass Plus Medical','Medical','Network A: $5,000 / $10,000 Network B: $6,350 / $12,700','true','false','false','','$10,000 / $20,000','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3694,'Hospital and Other Facility Services','INHSPS','Inpatient Hospice','INHSPS','0/DED40','','Encompass Plus Medical','Medical','Network A: $0 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3695,'Hospital and Other Facility Services','INP','Inpatient Hospital','INP','500/40','','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3696,'Hospital and Other Facility Services','INPP','Inpatient Hospital: Physician/Surgeon Fees','INPP','0/40','','Encompass Plus Medical','Medical','Network A: $0 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3697,'Hospital and Other Facility Services','OSP-A','Outpatient Surgical Procedures (Ambulatory Surgery Center)','OSP-A','125/40','','Encompass Plus Medical','Medical','Network A: $125 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3698,'Hospital and Other Facility Services','OSP-H','Outpatient Surgical Procedures (Hospital Facility)','OSP-H','150/40','','Encompass Plus Medical','Medical','Network A: $150 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3699,'Hospital and Other Facility Services','SNF','Skilled Nursing Facility','SNF','250/40','','Encompass Plus Medical','Medical','Network A: $250 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3700,'Maternity Services','PPS-F','Inpatient Maternity','PPS-F','500/40','','Encompass Plus Medical','Medical','Delivery: Network A: $500 copay / admission Physician: Network A: $0 copay / procedure Delivery: Network B: Deductible then 40% coinsurance Physician: Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3701,'Maternity Services','PPS-OV','Physician Services: Prenatal and Postnatal Care','PPS-OV','DED0/40','','Encompass Plus Medical','Medical','Network A: $0 copay / visit Network B: Deductible then $0 copay / visit','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3702,'Mental Health & Substance Abuse','MBHI','Inpatient Mental Health','MBHI','500/40','','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3703,'Mental Health & Substance Abuse','MBHO','Outpatient Mental Health','MBHO','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3704,'Mental Health & Substance Abuse','MISD','Inpatient Substance Abuse - Detox','MISD','500/40','','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3705,'Mental Health & Substance Abuse','MISR','Inpatient Substance Abuse - Rehab','MISR','500/40','','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3706,'Mental Health & Substance Abuse','MOSA','Outpatient Substance Abuse','MOSA','25/40','','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3707,'Physician and Other Services','ATT','Allergy Testing & Treatment','ATT','DED20/DED40','','Encompass Plus Medical','Medical','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3708,'Physician and Other Services','OPP','Outpatient Surgical Procedures (in physician''s office)','OPP','25/40','','Encompass Plus Medical','Medical','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3709,'Physician and Other Services','TMH','Telemedicine Including Mental Health, Behavioral Health and Substance Use Disorder','TMH','0/NC','','Encompass Plus Medical','Medical','$0 copay / consultation','true','false','false','','Not Covered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3710,'Prescription Drug Coverage','RX-MD','Medicare Part D Creditable Coverage Status','RX-MD','C/NA','','Encompass Plus Medical','Medical','Creditable','true','false','false','','Not Applicable','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3711,'Prescription Drug Coverage','RX-PP','Prescription Plan','RX-PP','4/NC','','Encompass Plus Medical','Medical','$4/$15/$30','true','false','false','','Not Covered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3712,'Rehabilitation Services','RCR','Cardiac Rehabilitation','RCR','40/DED40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3713,'Rehabilitation Services','RCS','Chiropractic Services','RCS','40/DED40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3714,'Rehabilitation Services','RPO','Physical - Occupational - Speech Therapies','RPO','DED20/DED40','','Encompass Plus Medical','Medical','Deductible then 20% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3715,'Dental Services','DS-AD','Accidental Dental','DS-AD','0/NA','','Encompass Plus Medical','Medical','Based on services rendered','true','false','false','','Based on services rendered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3716,'Adult Vision Services','AV-SPL','Standard Plastic Lenses','AV-SPL','10/NC','','Encompass Plus Medical','Medical','Single: $10 Bifocal: $10','true','false','false','','Not Covered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3717,'Adult Vision Services','AV-RE','Routine/ Refractive Exam','AV-RE','0/NC','','Encompass Plus Medical','Medical','$0 copay / visit','true','false','false','','Not Covered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3718,'Adult Vision Services','AV-ME','Medical Eye Exam','AV-ME','40/40','','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3719,'Adult Vision Services','AV-LV','Laser Vision Correction','AV-LV','15/NC','','Encompass Plus Medical','Medical','15% discount','true','false','false','','Not Covered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3720,'Adult Vision Services','AV-F','Frames','AV-F','60/NC','','Encompass Plus Medical','Medical','$60 allowance','true','false','false','','Not Covered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3721,'Adult Vision Services','AV-C','Conventional Contact Lenses','AV-C','90/NC','','Encompass Plus Medical','Medical','$90 allowance','true','false','false','','Not Covered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3722,'Emergency & Urgent Care Services','ERT','Ambulance','ERT','150/150','','Encompass Plus Medical','Medical','Network A: $150 copay / trip Network B: $150 copay / trip','true','false','false','','$150 copay / trip','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3723,'Additional Services','ACV','Chemotherapy','ACV','DED25/40','','Encompass Plus Additional Services','Rider','Network A: Deductible then $25/$40 copay / visit Network B: Deductible then 40% coinsurance','false','true','true','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3724,'Additional Services','ADME','Durable Medical Equipment','ADME','50/40','','Encompass Plus Additional Services','Rider','Network A: 50% coinsurance Network B: Deductible then 50% coinsurance','false','true','true','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3725,'Additional Services','AHHC','Home Health Care','AHHC','DED40/40','','Encompass Plus Additional Services','Rider','Network A: Deductible then $40 copay / visit Network B: Deductible then 40% coinsurance','false','true','true','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3726,'Additional Services','APA','Prosthetics and Appliances','APA','DED50/40','','Encompass Plus Additional Services','Rider','Network A: Deductible then 50% coinsurance Network B: Deductible then 50% coinsurance','false','true','true','','Deductible then 40% coinsurance','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3727,'Additional Services','AUB','Unique Benefits','AUB','250/NC','','Encompass Plus Additional Services','Rider','Option 1: $250 gym/wellness services allowance Option 2: Up to $500 per individual/$1,000 per family earned from the purchase of fresh produce','false','true','true','','Not Covered','84');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3728,'General Information','COINS','Coinsurance','COINS','25/75','','Choice Plus Medical','Medical','25%','true','true','true','','75%','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3729,'General Information','DED','Deductible','DED','100/1000','','Choice Plus Medical','Medical','$100/$2000 Network A','true','true','true','','$2000/$4000 Network B','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3730,'Adult Vision Services','AV-LV','Laser Vision Correction','AV-LV','15/0','','Choice Plus Medical','Medical','15% off retail price or 5% off promotional price','true','false','false','','Not Covered','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3731,'Adult Vision Services','AV-ME','Medical Eye Exam','AV-ME','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3732,'Adult Vision Services','AV-RE','Routine/ Refractive Exam','AV-RE','40/0','','Choice Plus Medical','Medical','$40 copay / visit','true','false','false','','Not Covered','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3733,'Adult Vision Services','AV-SPL','Standard Plastic Lenses','AV-SPL','50/0','','Choice Plus Medical','Medical','Single: $50 Bifocal: $70','true','false','false','','Not Covered','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3734,'Dental Services','DS-AD','Accidental Dental','DS-AD','0/0','','Choice Plus Medical','Medical','Based on services rendered','true','false','false','','Based on services rendered','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3735,'Dental Services','DS-PR','Preventive and Routine','DS-PR','0/0','','Choice Plus Medical','Medical','Not Covered','true','false','false','','Not Covered','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3736,'Dependent Coverage','DEP','Dependent Eligibility','DEP','29/26','','Choice Plus Medical','Medical','26','true','false','false','','29','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3737,'Diabetic Supplies and Services','DE','Diabetic Equipment (e.g. Blood glucose monitor, etc.)','DE','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3738,'Diabetic Supplies and Services','DIO','Insulin and Other Oral Agents','DIO','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3739,'Diabetic Supplies and Services','DMS','Diabetic Medical Supplies (Test Strips, Syringes, etc.)','DMS','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3740,'Diagnostic Testing Services','AR','Advanced Radiology','AR','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3741,'Diagnostic Testing Services','DT','Laboratory Testing','DT','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3742,'Diagnostic Testing Services','EKG','EKG','EKG','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3743,'Diagnostic Testing Services','RR','Routine Radiology','RR','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3744,'Emergency & Urgent Care Services','ER','Emergency Room','ER','20/20','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','20% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3745,'Emergency & Urgent Care Services','ERT','Ambulance','ERT','20/20','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','20% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3746,'General Information','APL','Annual Maximum','APL','0/0','','Choice Plus Medical','Medical','Not Applicable','true','false','false','','Not Applicable','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3747,'Rehabilitation Services','RPR','Pulmonary Rehabilitation','RPR','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3748,'Hospital and Other Facility Services','INHSPS','Inpatient Hospice','INHSPS','0/50','','Choice Plus Medical','Medical','$0 copay / visit','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3749,'Hospital and Other Facility Services','INP','Inpatient Hospital','INP','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3750,'Hospital and Other Facility Services','INPP','Inpatient Hospital: Physician/Surgeon Fees','INPP','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3751,'Hospital and Other Facility Services','OSP-A','Outpatient Surgical Procedures (Ambulatory Surgery Center)','OSP-A','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3752,'Hospital and Other Facility Services','OSP-H','Outpatient Surgical Procedures (Hospital Facility)','OSP-H','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3753,'Hospital and Other Facility Services','SNF','Skilled Nursing Facility','SNF','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3754,'Maternity Services','PPS-F','Inpatient Maternity','PPS-F','20/50','','Choice Plus Medical','Medical','Delivery 20% coinsurance Physician: 20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3755,'Maternity Services','PPS-OV','Physician Services: Prenatal and Postnatal Care','PPS-OV','0/50','','Choice Plus Medical','Medical','$0 copay / visit','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3756,'Mental Health & Substance Abuse','MBHI','Inpatient Mental Health','MBHI','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3757,'Mental Health & Substance Abuse','MBHO','Outpatient Mental Health','MBHO','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3758,'Mental Health & Substance Abuse','MISD','Inpatient Substance Abuse - Detox','MISD','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3759,'Mental Health & Substance Abuse','MISR','Inpatient Substance Abuse - Rehab','MISR','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3760,'Mental Health & Substance Abuse','MOSA','Outpatient Substance Abuse','MOSA','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3761,'Physician and Other Services','ATT','Allergy Testing & Treatment','ATT','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3762,'Physician and Other Services','OPP','Outpatient Surgical Procedures (in physician''s office)','OPP','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3763,'Physician and Other Services','TMH','Telemedicine Including Mental Health, Behavioral Health and Substance Use Disorder','TMH','0/0','','Choice Plus Medical','Medical','$0 copay / consultation','true','false','false','','Not Covered','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3764,'Prescription Drug Coverage','RX-MD','Medicare Part D Creditable Coverage Status','RX-MD','0/0','','Choice Plus Medical','Medical','Creditable','true','false','false','','Not Applicable','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3765,'Prescription Drug Coverage','RX-PP','Prescription Plan','RX-PP','May-00','','Choice Plus Medical','Medical','$5/20%/20%','true','false','false','','Not Covered','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3766,'Rehabilitation Services','RCR','Cardiac Rehabilitation','RCR','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3767,'Rehabilitation Services','RCS','Chiropractic Services','RCS','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3768,'Rehabilitation Services','RPO','Physical - Occupational - Speech Therapies','RPO','20/50','','Choice Plus Medical','Medical','20% coinsurance','true','false','false','','Deductible then 50% coinsurance','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3769,'Adult Vision Services','AV-F','Frames','AV-F','40/0','','Choice Plus Medical','Medical','40% off most retail frames','true','false','false','','Not Covered','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3770,'Adult Vision Services','AV-C','Conventional Contact Lenses','AV-C','15/0','','Choice Plus Medical','Medical','15% off retail price','true','false','false','','Not Covered','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(3771,'General Information','MOOP','Out-of-Pocket Maximum','MOOP','7350/10000','','Choice Plus Medical','Medical','$7,350 / $14,700','true','false','false','','$10,000 / $20,000','85');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8252,'General Information','COINS','Coinsurance','COINS','40/40','1.0','Encompass Plus Medical','Medical','Network A: Applies Where Indicated Network B: 40%','true','true','true','40%','40%','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8253,'General Information','DED','Deductible','DED','1500/3000','1.0','Encompass Plus Medical','Medical','Network A: $1,500 / $3,000 Network B: $3,000 / $6,000','true','true','true','$3,000 / $6,000','$3,000 / $6,000','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8254,'Dental Services','DS-PR','Preventive and Routine','DS-PR','NC/NC','15.0','Encompass Plus Medical','Medical','Not Covered','true','false','false','Not Covered','Not Covered','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8255,'Dependent Coverage','DEP','Dependent Eligibility','DEP','26/26','16.0','Encompass Plus Medical','Medical','26','true','false','false','26','26','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8256,'Diabetic Supplies and Services','DE','Diabetic Equipment (e.g. Blood glucose monitor, etc.)','DE','25/40','9.0','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8257,'Diabetic Supplies and Services','DIO','Insulin and Other Oral Agents','DIO','25/40','9.0','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8258,'Diabetic Supplies and Services','DMS','Diabetic Medical Supplies (Test Strips, Syringes, etc.)','DMS','25/40','9.0','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8259,'Diagnostic Testing Services','AR','Advanced Radiology','AR','100/40','6.0','Encompass Plus Medical','Medical','Network A: $100 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8260,'Diagnostic Testing Services','DT','Laboratory Testing','DT','0/40','6.0','Encompass Plus Medical','Medical','Network A: $0 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8261,'Diagnostic Testing Services','EKG','EKG','EKG','25/40','6.0','Encompass Plus Medical','Medical','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8262,'Diagnostic Testing Services','RR','Routine Radiology','RR','40/40','6.0','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8263,'Emergency & Urgent Care Services','ER','Emergency Room','ER','150/150','4.0','Encompass Plus Medical','Medical','Network A: $150 copay / visit Network B: $150 copay / visit','true','false','false','$150 copay / visit','$150 copay / visit','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8264,'Rehabilitation Services','RPR','Pulmonary Rehabilitation','RPR','40/40','10.0','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8265,'General Information','APL','Annual Maximum','APL','NA/NA','1.0','Encompass Plus Medical','Medical','Not Applicable','true','false','false','Not Applicable','Not Applicable','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8266,'General Information','MOOP','Out-of-Pocket Maximum','MOOP','0/DED40','1.0','Encompass Plus Medical','Medical','Network A: $5,000 / $10,000 Network B: $6,350 / $12,700','true','false','false','$10,000 / $20,000','$10,000 / $20,000','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8267,'Hospital and Other Facility Services','INHSPS','Inpatient Hospice','INHSPS','0/DED40','5.0','Encompass Plus Medical','Medical','Network A: $0 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8268,'Hospital and Other Facility Services','INP','Inpatient Hospital','INP','500/40','5.0','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8269,'Hospital and Other Facility Services','INPP','Inpatient Hospital: Physician/Surgeon Fees','INPP','0/40','5.0','Encompass Plus Medical','Medical','Network A: $0 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8270,'Hospital and Other Facility Services','OSP-A','Outpatient Surgical Procedures (Ambulatory Surgery Center)','OSP-A','125/40','5.0','Encompass Plus Medical','Medical','Network A: $125 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8271,'Hospital and Other Facility Services','OSP-H','Outpatient Surgical Procedures (Hospital Facility)','OSP-H','150/40','5.0','Encompass Plus Medical','Medical','Network A: $150 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8272,'Hospital and Other Facility Services','SNF','Skilled Nursing Facility','SNF','250/40','5.0','Encompass Plus Medical','Medical','Network A: $250 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8273,'Maternity Services','PPS-F','Inpatient Maternity','PPS-F','500/40','7.0','Encompass Plus Medical','Medical','Delivery: Network A: $500 copay / admission Physician: Network A: $0 copay / procedure Delivery: Network B: Deductible then 40% coinsurance Physician: Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8274,'Maternity Services','PPS-OV','Physician Services: Prenatal and Postnatal Care','PPS-OV','DED0/40','7.0','Encompass Plus Medical','Medical','Network A: $0 copay / visit Network B: Deductible then $0 copay / visit','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8275,'Mental Health & Substance Abuse','MBHI','Inpatient Mental Health','MBHI','500/40','8.0','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8276,'Mental Health & Substance Abuse','MBHO','Outpatient Mental Health','MBHO','25/40','8.0','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8277,'Mental Health & Substance Abuse','MISD','Inpatient Substance Abuse - Detox','MISD','500/40','8.0','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8278,'Mental Health & Substance Abuse','MISR','Inpatient Substance Abuse - Rehab','MISR','500/40','8.0','Encompass Plus Medical','Medical','Network A: $500 copay / admission Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8279,'Mental Health & Substance Abuse','MOSA','Outpatient Substance Abuse','MOSA','25/40','8.0','Encompass Plus Medical','Medical','Network A: $25 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8280,'Physician and Other Services','ATT','Allergy Testing & Treatment','ATT','DED20/DED40','3.0','Encompass Plus Medical','Medical','Network A: Deductible then 20% coinsurance Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8281,'Physician and Other Services','OPP','Outpatient Surgical Procedures (in physician''s office)','OPP','25/40','3.0','Encompass Plus Medical','Medical','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8282,'Physician and Other Services','TMH','Telemedicine Including Mental Health, Behavioral Health and Substance Use Disorder','TMH','0/NC','3.0','Encompass Plus Medical','Medical','$0 copay / consultation','true','false','false','Not Covered','Not Covered','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8283,'Prescription Drug Coverage','RX-MD','Medicare Part D Creditable Coverage Status','RX-MD','C/NA','12.0','Encompass Plus Medical','Medical','Creditable','true','false','false','Not Applicable','Not Applicable','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8284,'Prescription Drug Coverage','RX-PP','Prescription Plan','RX-PP','4/NC','12.0','Encompass Plus Medical','Medical','$4/$15/$30','true','false','false','Not Covered','Not Covered','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8285,'Rehabilitation Services','RCR','Cardiac Rehabilitation','RCR','40/DED40','10.0','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8286,'Rehabilitation Services','RCS','Chiropractic Services','RCS','40/DED40','10.0','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8287,'Rehabilitation Services','RPO','Physical - Occupational - Speech Therapies','RPO','DED20/DED40','10.0','Encompass Plus Medical','Medical','Deductible then 20% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8288,'Dental Services','DS-AD','Accidental Dental','DS-AD','0/NA','15.0','Encompass Plus Medical','Medical','Based on services rendered','true','false','false','','Based on services rendered','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8289,'Adult Vision Services','AV-SPL','Standard Plastic Lenses','AV-SPL','10/NC','14.0','Encompass Plus Medical','Medical','Single: $10 Bifocal: $10','true','false','false','Not Covered','Not Covered','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8290,'Adult Vision Services','AV-RE','Routine/ Refractive Exam','AV-RE','0/NC','14.0','Encompass Plus Medical','Medical','$0 copay / visit','true','false','false','Not Covered','Not Covered','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8291,'Adult Vision Services','AV-ME','Medical Eye Exam','AV-ME','40/40','14.0','Encompass Plus Medical','Medical','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','true','false','false','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8292,'Adult Vision Services','AV-LV','Laser Vision Correction','AV-LV','15/NC','14.0','Encompass Plus Medical','Medical','15% discount','true','false','false','Not Covered','Not Covered','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8293,'Adult Vision Services','AV-F','Frames','AV-F','60/NC','14.0','Encompass Plus Medical','Medical','$60 allowance','true','false','false','Not Covered','Not Covered','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8294,'Adult Vision Services','AV-C','Conventional Contact Lenses','AV-C','90/NC','14.0','Encompass Plus Medical','Medical','$90 allowance','true','false','false','Not Covered','Not Covered','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8295,'Emergency & Urgent Care Services','ERT','Ambulance','ERT','150/150','4.0','Encompass Plus Medical','Medical','Network A: $150 copay / trip Network B: $150 copay / trip','true','false','false','$150 copay / trip','$150 copay / trip','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8296,'Additional Services','ACV','Chemotherapy','ACV','25/40','11.0','Encompass Plus Additional Services','Rider','Network A: $25/$40 copay / visit Network B: Deductible then 40% coinsurance','false','true','true','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8297,'Additional Services','ADME','Durable Medical Equipment','ADME','DED50/40','11.0','Encompass Plus Additional Services','Rider','Network A: Deductible then 50% coinsurance Network B: Deductible then 50% coinsurance','false','true','true','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8298,'Additional Services','AHHC','Home Health Care','AHHC','40/40','11.0','Encompass Plus Additional Services','Rider','Network A: $40 copay / visit Network B: Deductible then 40% coinsurance','false','true','true','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8299,'Additional Services','APA','Prosthetics and Appliances','APA','DED50/40','11.0','Encompass Plus Additional Services','Rider','Network A: Deductible then 50% coinsurance Network B: Deductible then 50% coinsurance','false','true','true','Deductible then 40% coinsurance','Deductible then 40% coinsurance','182');
INSERT INTO "Quote_Line_Benefit__c" VALUES(8300,'Additional Services','AUB','Unique Benefits','AUB','250/NC','11.0','Encompass Plus Additional Services','Rider','Option 1: $250 gym/wellness services allowance Option 2: Up to $500 per individual/$1,000 per family earned from the purchase of fresh produce','false','true','true','Not Covered','Not Covered','182');
CREATE TABLE "Quote_Request_Claim_History__c" (
	id INTEGER NOT NULL, 
	"Claim_From__c" VARCHAR(255), 
	"Claim_Reimbursement__c" VARCHAR(255), 
	"Claim_Through__c" VARCHAR(255), 
	"ICD10__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Physician_NPN__c" VARCHAR(255), 
	"Type__c" VARCHAR(255), 
	"Quote__c" VARCHAR(255), 
	PRIMARY KEY (id)
);

CREATE TABLE "Quote_Request_Claim_Summary__c" (
	id INTEGER NOT NULL, 
	"Average_Enrolled_Members__c" VARCHAR(255), 
	"Average_Enrolled_Subscribers__c" VARCHAR(255), 
	"Billed_Premium__c" VARCHAR(255), 
	"Capitation__c" VARCHAR(255), 
	"Claims__c" VARCHAR(255), 
	"Experience_Period_From__c" VARCHAR(255), 
	"Experience_Period_Through__c" VARCHAR(255), 
	"High_Level_Claims__c" VARCHAR(255), 
	"Type__c" VARCHAR(255), 
	"Quote__c" VARCHAR(255), 
	PRIMARY KEY (id)
);

CREATE TABLE "Rate_Factor_Variant__c" (
	id INTEGER NOT NULL, 
	"AdjustmentFactor__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"RateFactor__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "Rate_Factor__c" (
	id INTEGER NOT NULL, 
	"Effective_Date__c" VARCHAR(255), 
	"Factor_Application_Level__c" VARCHAR(255), 
	"Factor_Type__c" VARCHAR(255), 
	"Status__c" VARCHAR(255), 
	"Termination_Date__c" VARCHAR(255), 
	"Version__c" VARCHAR(255), 
	"Plan_Family__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "Rating_Region__c" (
	id INTEGER NOT NULL, 
	"City__c" VARCHAR(255), 
	"Country__c" VARCHAR(255), 
	"County__c" VARCHAR(255), 
	"Covered__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Rating_Region__c" VARCHAR(255), 
	"State__c" VARCHAR(255), 
	"Test5__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Rating_Region__c" VALUES(1,'Buffalo','USA','Erie','True','14201','Erie','NY','asdasds');
INSERT INTO "Rating_Region__c" VALUES(2,'Rochester','USA','Monroe','True','14652','Monroe','NY','');
INSERT INTO "Rating_Region__c" VALUES(3,'Niagara Falls','USA','Niagara','True','14301','Niagara','NY','');
INSERT INTO "Rating_Region__c" VALUES(4,'Newfane','USA','Niagara','True','14108','Niagara','NY','');
INSERT INTO "Rating_Region__c" VALUES(5,'Marilla','USA','Erie','True','14102','Erie','NY','');
INSERT INTO "Rating_Region__c" VALUES(6,'','','','False','87110','','','');
COMMIT;
