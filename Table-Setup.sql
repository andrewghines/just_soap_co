/* 
 * Capstone database and table set up.  We have tables set to handle customer information,
 * products, and a shopping basket.
 */
DROP DATABASE IF EXISTS SOAP_COMPANY;
CREATE DATABASE IF NOT EXISTS SOAP_COMPANY;

USE SOAP_COMPANY;

CREATE TABLE `SOAP_COMPANY`.`CUSTOMER` 
    ( `CUSTOMER_ID` INT NOT NULL AUTO_INCREMENT ,
      `CUSTOMER_LOGIN` VARCHAR(50) NOT NULL ,
      `CUSTOMER_EMAIL` VARCHAR(255) NOT NULL ,
      `CUSTOMER_ENC_PASSWORD` VARCHAR(255) NOT NULL ,
      `CUSTOMER_FIRST_NAME` VARCHAR(50) NOT NULL ,
      `CUSTOMER_LAST_NAME` VARCHAR(50) NOT NULL , 
      PRIMARY KEY (`CUSTOMER_ID`),
      UNIQUE `CUSTOMER_LOGIN_UNIQUE` (`CUSTOMER_LOGIN`)
    )
ENGINE = InnoDB;

CREATE TABLE `SOAP_COMPANY`.`COUNTRY`
    ( `COUNTRY_ID` INT NOT NULL AUTO_INCREMENT ,
      `COUNTRY_NAME` VARCHAR(100) NOT NULL ,
      `COUNTRY_ISO_2` VARCHAR(2) ,
      `COUNTRY_ISO_3` VARCHAR(3) ,
      PRIMARY KEY (`COUNTRY_ID`) ,
      UNIQUE `COUNTRY_ISO_2_UNIQUE` (`COUNTRY_ISO_2`) ,
      UNIQUE `COUNTRY_ISO_3_UNIQUE` (`COUNTRY_ISO_3`)
    )
ENGINE = InnoDB;

CREATE TABLE `SOAP_COMPANY`.`ADDRESS`
    ( `ADDRESS_TYPE` VARCHAR(50) NOT NULL ,
      `CUSTOMER_ID` INT NOT NULL ,
      `COUNTRY_ID` INT NOT NULL,
      `ADDRESS_STREET_ADDRESS` VARCHAR(50) NOT NULL ,
      `ADDRESS_CITY` VARCHAR(50) NOT NULL ,
      `ADDRESS_STATE` VARCHAR(2),
      `ADDRESS_ZIP` VARCHAR(5),
      PRIMARY KEY (`ADDRESS_TYPE`, `CUSTOMER_ID`),
      FOREIGN KEY (`COUNTRY_ID`) REFERENCES `SOAP_COMPANY`.`COUNTRY`(`COUNTRY_ID`)
    )
ENGINE = InnoDB;

CREATE TABLE `SOAP_COMPANY`.`BASKET_STATUS`
    ( `BASKET_STATUS_ID` INT NOT NULL,
      `BASKET_STATUS_NAME` VARCHAR(50) NOT NULL ,
      `BASKET_STATUS_DESCRIPTION` VARCHAR(2048) NOT NULL ,
      `BASKET_NEXT_STATUS` INT ,
      PRIMARY KEY (`BASKET_STATUS_ID`)
    )
ENGINE = InnoDB;

CREATE TABLE `SOAP_COMPANY`.`BASKET`
    ( `BASKET_ID` INT NOT NULL AUTO_INCREMENT ,
      `CUSTOMER_ID` INT NOT NULL ,
      `PAYMENT_ID` INT ,
      `BASKET_CREATE_DATE` DATE NOT NULL ,
      `BASKET_STATUS_ID` INT NOT NULL ,
      PRIMARY KEY (`BASKET_ID`),
      FOREIGN KEY (`BASKET_STATUS_ID`) REFERENCES `SOAP_COMPANY`.`BASKET_STATUS`(`BASKET_STATUS_ID`)
    )
ENGINE = InnoDB;

CREATE TABLE `SOAP_COMPANY`.`PAYMENT_STATUS`
    ( `PAYMENT_STATUS_ID` INT NOT NULL ,
      `PAYMENT_STATUS_NAME` VARCHAR(50) NOT NULL ,
      `PAYMENT_STATUS_DESCRIPTION` VARCHAR(2048) NOT NULL ,
      PRIMARY KEY (`PAYMENT_STATUS_ID`)
    )
ENGINE = InnoDB;

CREATE TABLE `SOAP_COMPANY`.`PAYMENT`
    ( `PAYMENT_ID` INT NOT NULL AUTO_INCREMENT ,
      `PAYMENT_TYPE` VARCHAR(50) NOT NULL ,
      `PAYMENT_STATUS_ID` INT NOT NULL ,
      `PAYMENT_AMOUNT` DOUBLE NOT NULL ,
      `PAYMENT_CARD_NUMBER` VARCHAR(50) ,
      PRIMARY KEY (`PAYMENT_ID`),
      FOREIGN KEY (`PAYMENT_STATUS_ID`) REFERENCES `SOAP_COMPANY`.`PAYMENT_STATUS`(`PAYMENT_STATUS_ID`)
    )
ENGINE = InnoDB;

CREATE TABLE `SOAP_COMPANY`.`PRODUCT`
    (
      `PRODUCT_ID` INT NOT NULL AUTO_INCREMENT ,
      `PRODUCT_NAME` VARCHAR(50) NOT NULL ,
      `PRODUCT_DESCRIPTION` TEXT ,
      `PRODUCT_PRICE` DOUBLE NOT NULL,
      PRIMARY KEY (`PRODUCT_ID`),
      FULLTEXT (`PRODUCT_NAME`,`PRODUCT_DESCRIPTION`)
    )
ENGINE = InnoDB;

CREATE TABLE `SOAP_COMPANY`.`PURCHASE`
    (
      `PURCHASE_ID` INT NOT NULL AUTO_INCREMENT ,
      `PRODUCT_ID` INT NOT NULL,
      `BASKET_ID` INT NOT NULL,
      `PURCHASE_QUANTITY` INT NOT NULL,
      PRIMARY KEY (`PURCHASE_ID`),
      FOREIGN KEY (`PRODUCT_ID`) REFERENCES `SOAP_COMPANY`.`PRODUCT`(`PRODUCT_ID`),
      FOREIGN KEY (`BASKET_ID`) REFERENCES `SOAP_COMPANY`.`BASKET`(`BASKET_ID`)
    )
ENGINE = InnoDB;

INSERT INTO `SOAP_COMPANY`.`BASKET_STATUS` (`BASKET_STATUS_ID`, `BASKET_STATUS_NAME`, `BASKET_STATUS_DESCRIPTION`, `BASKET_NEXT_STATUS`) VALUES
  (0, 'NEW_BASKET', 'New Basket', 1),
  (1, 'PROCESSING', 'Processing Payment', 2),
  (2, 'CHECKOUT', 'Basket has been checked out', NULL),
  (3, 'CANCELLED', 'Basket Cancelled', NULL);

INSERT INTO `SOAP_COMPANY`.`PAYMENT_STATUS` (`PAYMENT_STATUS_ID`, `PAYMENT_STATUS_NAME`, `PAYMENT_STATUS_DESCRIPTION`) VALUES
  (0, 'NEW_PAYMENT', 'New Payment'),
  (1, 'PROCESSING', 'Payment is processing'),
  (2, 'APPROVED', 'Payment approved'),
  (3, 'DENIED', 'Payment was denied');

INSERT INTO `SOAP_COMPANY`.PRODUCT (`PRODUCT_NAME`, `PRODUCT_DESCRIPTION`, `PRODUCT_PRICE`) VALUES
  ('Folly Shores', 'Summer beach fun with a hint of green apple', 9.99),
  ('Cucumber Melon', 'Smells like a day at the spa', 9.99),
  ('Nautical Winds', 'Fresh nautical scent', 9.99),
  ('Peppermint Lemongrass', 'Classic, clean scent', 9.99),
  ('Peppermint Sandalwood', 'Peppermin with a light wood scent', 9.99),
  ('Fresh Lavender', 'Classic, fresh lavender', 9.99),
  ('Coffee', 'Coffee lovers rejoice!  *exfoliating*', 9.99),
  ('Pine Tar', 'The great outdoors condensed into a bar of soap', 9.99),
  ('Sweet Bourbon', 'Sweet smelling musk with a splash of bourbon', 9.99);

INSERT INTO `SOAP_COMPANY`.`COUNTRY` (`COUNTRY_ISO_2`, `COUNTRY_NAME`, `COUNTRY_ISO_3`) VALUES
  ('AF', "Afghanistan", 'AFG'),
  ('AX', "Åland Islands", 'ALA'),
  ('AL', "Albania", 'ALB'),
  ('DZ', "Algeria", 'DZA'),
  ('AS', "American Samoa", 'ASM'),
  ('AD', "Andorra", 'AND'),
  ('AO', "Angola", 'AGO'),
  ('AI', "Anguilla", 'AIA'),
  ('AQ', "Antarctica", 'ATA'),
  ('AG', "Antigua and Barbuda", 'ATG'),
  ('AR', "Argentina", 'ARG'),
  ('AM', "Armenia", 'ARM'),
  ('AW', "Aruba", 'ABW'),
  ('AU', "Australia", 'AUS'),
  ('AT', "Austria", 'AUT'),
  ('AZ', "Azerbaijan", 'AZE'),
  ('BS', "Bahamas", 'BHS'),
  ('BH', "Bahrain", 'BHR'),
  ('BD', "Bangladesh", 'BGD'),
  ('BB', "Barbados", 'BRB'),
  ('BY', "Belarus", 'BLR'),
  ('BE', "Belgium", 'BEL'),
  ('BZ', "Belize", 'BLZ'),
  ('BJ', "Benin", 'BEN'),
  ('BM', "Bermuda", 'BMU'),
  ('BT', "Bhutan", 'BTN'),
  ('BO', "Bolivia", 'BOL'),
  ('BQ', "Bonaire, Sint Eustatius and Saba", 'BES'),
  ('BA', "Bosnia and Herzegovina", 'BIH'),
  ('BW', "Botswana", 'BWA'),
  ('BV', "Bouvet Island (Bouvetøya)", 'BVT'),
  ('BR', "Brazil", 'BRA'),
  ('IO', "British Indian Ocean Territory (Chagos Archipelago)", 'IOT'),
  ('VG', "British Virgin Islands", 'VGB'),
  ('BN', "Brunei Darussalam", 'BRN'),
  ('BG', "Bulgaria", 'BGR'),
  ('BF', "Burkina Faso", 'BFA'),
  ('BI', "Burundi", 'BDI'),
  ('KH', "Cambodia", 'KHM'),
  ('CM', "Cameroon", 'CMR'),
  ('CA', "Canada", 'CAN'),
  ('CV', "Cabo Verde", 'CPV'),
  ('KY', "Cayman Islands", 'CYM'),
  ('CF', "Central African Republic", 'CAF'),
  ('TD', "Chad", 'TCD'),
  ('CL', "Chile", 'CHL'),
  ('CN', "China", 'CHN'),
  ('CX', "Christmas Island", 'CXR'),
  ('CC', "Cocos (Keeling) Islands", 'CCK'),
  ('CO', "Colombia", 'COL'),
  ('KM', "Comoros", 'COM'),
  ('CD', "Congo", 'COD'),
  ('CG', "Congo", 'COG'),
  ('CK', "Cook Islands", 'COK'),
  ('CR', "Costa Rica", 'CRI'),
  ('CI', "Cote d'Ivoire", 'CIV'),
  ('HR', "Croatia", 'HRV'),
  ('CU', "Cuba", 'CUB'),
  ('CW', "Curaçao", 'CUW'),
  ('CY', "Cyprus", 'CYP'),
  ('CZ', "Czechia", 'CZE'),
  ('DK', "Denmark", 'DNK'),
  ('DJ', "Djibouti", 'DJI'),
  ('DM', "Dominica", 'DMA'),
  ('DO', "Dominican Republic", 'DOM'),
  ('EC', "Ecuador", 'ECU'),
  ('EG', "Egypt", 'EGY'),
  ('SV', "El Salvador", 'SLV'),
  ('GQ', "Equatorial Guinea", 'GNQ'),
  ('ER', "Eritrea", 'ERI'),
  ('EE', "Estonia", 'EST'),
  ('ET', "Ethiopia", 'ETH'),
  ('FO', "Faroe Islands", 'FRO'),
  ('FK', "Falkland Islands (Malvinas)", 'FLK'),
  ('FJ', "Fiji", 'FJI'),
  ('FI', "Finland", 'FIN'),
  ('FR', "France", 'FRA'),
  ('GF', "French Guiana", 'GUF'),
  ('PF', "French Polynesia", 'PYF'),
  ('TF', "French Southern Territories", 'ATF'),
  ('GA', "Gabon", 'GAB'),
  ('GM', "Gambia", 'GMB'),
  ('GE', "Georgia", 'GEO'),
  ('DE', "Germany", 'DEU'),
  ('GH', "Ghana", 'GHA'),
  ('GI', "Gibraltar", 'GIB'),
  ('GR', "Greece", 'GRC'),
  ('GL', "Greenland", 'GRL'),
  ('GD', "Grenada", 'GRD'),
  ('GP', "Guadeloupe", 'GLP'),
  ('GU', "Guam", 'GUM'),
  ('GT', "Guatemala", 'GTM'),
  ('GG', "Guernsey", 'GGY'),
  ('GN', "Guinea", 'GIN'),
  ('GW', "Guinea-Bissau", 'GNB'),
  ('GY', "Guyana", 'GUY'),
  ('HT', "Haiti", 'HTI'),
  ('HM', "Heard Island and McDonald Islands", 'HMD'),
  ('VA', "Holy See (Vatican City State)", 'VAT'),
  ('HN', "Honduras", 'HND'),
  ('HK', "Hong Kong", 'HKG'),
  ('HU', "Hungary", 'HUN'),
  ('IS', "Iceland", 'ISL'),
  ('IN', "India", 'IND'),
  ('ID', "Indonesia", 'IDN'),
  ('IR', "Iran", 'IRN'),
  ('IQ', "Iraq", 'IRQ'),
  ('IE', "Ireland", 'IRL'),
  ('IM', "Isle of Man", 'IMN'),
  ('IL', "Israel", 'ISR'),
  ('IT', "Italy", 'ITA'),
  ('JM', "Jamaica", 'JAM'),
  ('JP', "Japan", 'JPN'),
  ('JE', "Jersey", 'JEY'),
  ('JO', "Jordan", 'JOR'),
  ('KZ', "Kazakhstan", 'KAZ'),
  ('KE', "Kenya", 'KEN'),
  ('KI', "Kiribati", 'KIR'),
  ('KP', "Korea", 'PRK'),
  ('KR', "Korea", 'KOR'),
  ('KW', "Kuwait", 'KWT'),
  ('KG', "Kyrgyz Republic", 'KGZ'),
  ('LA', "Lao People's Democratic Republic", 'LAO'),
  ('LV', "Latvia", 'LVA'),
  ('LB', "Lebanon", 'LBN'),
  ('LS', "Lesotho", 'LSO'),
  ('LR', "Liberia", 'LBR'),
  ('LY', "Libya", 'LBY'),
  ('LI', "Liechtenstein", 'LIE'),
  ('LT', "Lithuania", 'LTU'),
  ('LU', "Luxembourg", 'LUX'),
  ('MO', "Macao", 'MAC'),
  ('MG', "Madagascar", 'MDG'),
  ('MW', "Malawi", 'MWI'),
  ('MY', "Malaysia", 'MYS'),
  ('MV', "Maldives", 'MDV'),
  ('ML', "Mali", 'MLI'),
  ('MT', "Malta", 'MLT'),
  ('MH', "Marshall Islands", 'MHL'),
  ('MQ', "Martinique", 'MTQ'),
  ('MR', "Mauritania", 'MRT'),
  ('MU', "Mauritius", 'MUS'),
  ('YT', "Mayotte", 'MYT'),
  ('MX', "Mexico", 'MEX'),
  ('FM', "Micronesia", 'FSM'),
  ('MD', "Moldova", 'MDA'),
  ('MC', "Monaco", 'MCO'),
  ('MN', "Mongolia", 'MNG'),
  ('ME', "Montenegro", 'MNE'),
  ('MS', "Montserrat", 'MSR'),
  ('MA', "Morocco", 'MAR'),
  ('MZ', "Mozambique", 'MOZ'),
  ('MM', "Myanmar", 'MMR'),
  ('NA', "Namibia", 'NAM'),
  ('NR', "Nauru", 'NRU'),
  ('NP', "Nepal", 'NPL'),
  ('NL', "Netherlands", 'NLD'),
  ('NC', "New Caledonia", 'NCL'),
  ('NZ', "New Zealand", 'NZL'),
  ('NI', "Nicaragua", 'NIC'),
  ('NE', "Niger", 'NER'),
  ('NG', "Nigeria", 'NGA'),
  ('NU', "Niue", 'NIU'),
  ('NF', "Norfolk Island", 'NFK'),
  ('MK', "North Macedonia", 'MKD'),
  ('MP', "Northern Mariana Islands", 'MNP'),
  ('NO', "Norway", 'NOR'),
  ('OM', "Oman", 'OMN'),
  ('PK', "Pakistan", 'PAK'),
  ('PW', "Palau", 'PLW'),
  ('PS', "Palestine", 'PSE'),
  ('PA', "Panama", 'PAN'),
  ('PG', "Papua New Guinea", 'PNG'),
  ('PY', "Paraguay", 'PRY'),
  ('PE', "Peru", 'PER'),
  ('PH', "Philippines", 'PHL'),
  ('PN', "Pitcairn Islands", 'PCN'),
  ('PL', "Poland", 'POL'),
  ('PT', "Portugal", 'PRT'),
  ('PR', "Puerto Rico", 'PRI'),
  ('QA', "Qatar", 'QAT'),
  ('RE', "Réunion", 'REU'),
  ('RO', "Romania", 'ROU'),
  ('RU', "Russian Federation", 'RUS'),
  ('RW', "Rwanda", 'RWA'),
  ('BL', "Saint Barthélemy", 'BLM'),
  ('SH', "Saint Helena, Ascension and Tristan da Cunha", 'SHN'),
  ('KN', "Saint Kitts and Nevis", 'KNA'),
  ('LC', "Saint Lucia", 'LCA'),
  ('MF', "Saint Martin", 'MAF'),
  ('PM', "Saint Pierre and Miquelon", 'SPM'),
  ('VC', "Saint Vincent and the Grenadines", 'VCT'),
  ('WS', "Samoa", 'WSM'),
  ('SM', "San Marino", 'SMR'),
  ('ST', "Sao Tome and Principe", 'STP'),
  ('SA', "Saudi Arabia", 'SAU'),
  ('SN', "Senegal", 'SEN'),
  ('RS', "Serbia", 'SRB'),
  ('SC', "Seychelles", 'SYC'),
  ('SL', "Sierra Leone", 'SLE'),
  ('SG', "Singapore", 'SGP'),
  ('SX', "Sint Maarten (Dutch part)", 'SXM'),
  ('SK', "Slovakia (Slovak Republic)", 'SVK'),
  ('SI', "Slovenia", 'SVN'),
  ('SB', "Solomon Islands", 'SLB'),
  ('SO', "Somalia", 'SOM'),
  ('ZA', "South Africa", 'ZAF'),
  ('GS', "South Georgia and the South Sandwich Islands", 'SGS'),
  ('SS', "South Sudan", 'SSD'),
  ('ES', "Spain", 'ESP'),
  ('LK', "Sri Lanka", 'LKA'),
  ('SD', "Sudan", 'SDN'),
  ('SR', "Suriname", 'SUR'),
  ('SJ', "Svalbard & Jan Mayen Islands", 'SJM'),
  ('SZ', "Eswatini", 'SWZ'),
  ('SE', "Sweden", 'SWE'),
  ('CH', "Switzerland", 'CHE'),
  ('SY', "Syrian Arab Republic", 'SYR'),
  ('TW', "Taiwan", 'TWN'),
  ('TJ', "Tajikistan", 'TJK'),
  ('TZ', "Tanzania", 'TZA'),
  ('TH', "Thailand", 'THA'),
  ('TL', "Timor-Leste", 'TLS'),
  ('TG', "Togo", 'TGO'),
  ('TK', "Tokelau", 'TKL'),
  ('TO', "Tonga", 'TON'),
  ('TT', "Trinidad and Tobago", 'TTO'),
  ('TN', "Tunisia", 'TUN'),
  ('TR', "Türkiye", 'TUR'),
  ('TM', "Turkmenistan", 'TKM'),
  ('TC', "Turks and Caicos Islands", 'TCA'),
  ('TV', "Tuvalu", 'TUV'),
  ('UG', "Uganda", 'UGA'),
  ('UA', "Ukraine", 'UKR'),
  ('AE', "United Arab Emirates", 'ARE'),
  ('GB', "United Kingdom of Great Britain and Northern Ireland", 'GBR'),
  ('US', "United States of America", 'USA'),
  ('UM', "United States Minor Outlying Islands", 'UMI'),
  ('VI', "United States Virgin Islands", 'VIR'),
  ('UY', "Uruguay", 'URY'),
  ('UZ', "Uzbekistan", 'UZB'),
  ('VU', "Vanuatu", 'VUT'),
  ('VE', "Venezuela", 'VEN'),
  ('VN', "Vietnam", 'VNM'),
  ('WF', "Wallis and Futuna", 'WLF'),
  ('EH', "Western Sahara", 'ESH'),
  ('YE', "Yemen", 'YEM'),
  ('ZM', "Zambia", 'ZMB'),
  ('ZW', "Zimbabwe", 'ZWE');