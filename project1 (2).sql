CREATE TABLE `layoffs_table1` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_table1
SELECT *, ROW_NUMBER () OVER (PARTITION BY company, location, industry,total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
FROM layoffs_table
;

SELECT *
FROM layoffs_table1
WHERE company = "Cazoo" or funds_raised_millions = 2000
;	-- Search for Duplicate Data --

SELECT * 
FROM layoffs_table1
WHERE row_num > 1;	-- Duplicate Data --

Delete 
FROM layoffs_table1
WHERE row_num > 1;	-- Delete Duplicate Data --

SELECT company, TRIM(company)
FROM layoffs_table1; 	-- Trim Check For "Company" --

UPDATE layoffs_table1
SET company = TRIM(company);	 -- Update "company" --

SELECT DISTINCT(industry)
FROM layoffs_table1
ORDER BY 1;	 -- Industry Check / Two rows blanks --

UPDATE layoffs_table1
SET industry = "Crypto"
WHERE industry LIKE "Crypto%";	 -- Update "industry" --

SELECT DISTINCT(REPLACE (Country, "United States.", "United States"))
FROM layoffs_table1
ORDER BY country ASC; 	-- Cleaning Country --

UPDATE layoffs_table1
SET country = REPLACE (Country, "United States.", "United States");		-- Update Country --

SELECT `date`,
STR_TO_DATE(`date`, "%m/%d/%y")
FROM layoffs_table1;	-- Date Cleaning Check --

UPDATE layoffs_table
SET `date` = STR_TO_DATE(`date`,"%m/%d/%Y");	-- Update Date --

ALTER TABLE layoffs_table1
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_table1
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL; 	-- Checking Null In total_laid_off & percentage_laid_off --

DELETE 
FROM layoffs_table1
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL; -- Delete Null In total_laid_off & percentage_laid_off --

SELECT *
FROM layoffs_table1;

SELECT *
FROM layoffs_table1
WHERE industry IS NULL OR industry = ''; 	-- Checking NULL & Space in "industry" --

UPDATE layoffs_table1
SET industry = null
WHERE industry = '';






