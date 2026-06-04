/*
-------------------------------------------------------------------------------------------------------------------------------------------------------------
Prupose:- This udf is designed to load the data into bronze layer tables from both crm and erp source systems and calculates the total time duration as well.
We are doing full load.
---------------------------------------------------------------------------------------------------------------------------------------------------------------
*/

CREATE OR ALTER PROCEDURE Bronze.load_bronze as 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME , @batch_end_time DATETIME;

	SET @batch_start_time=GETDATE();
	BEGIN TRY
		PRINT '======================================================================================';
		PRINT 'Loading data into Bronze layer From CRM Source System';
		PRINT '======================================================================================';

		SET @start_time =GETDATE();
		PRINT '>> Truncating the table Bronze.crm_cust_info ';
		TRUNCATE TABLE Bronze.crm_cust_info;

		PRINT '>> Insering the data into the table Bronze.crm_cust_info ';
		BULK INSERT Bronze.crm_cust_info
		FROM 'C:\Users\Bluep\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT '>> Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds';
			PRINT '----------------------------'


		SET @start_time =GETDATE();
		PRINT '>> Truncating the table Bronze.crm_prd_info ';
		TRUNCATE TABLE Bronze.crm_prd_info;

		PRINT '>> Insering the data into the table Bronze.crm_prd_info ';
		BULK INSERT Bronze.crm_prd_info
		FROM 'C:\Users\Bluep\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT '>> Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds';

		SET @start_time =GETDATE();
		PRINT '>> Truncating the table Bronze.crm_sales_details ';
		TRUNCATE TABLE Bronze.crm_sales_details;

		PRINT '>> Insering the data into the table Bronze.crm_sales_details ';
		BULK INSERT Bronze.crm_sales_details
		FROM 'C:\Users\Bluep\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT '>> Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds';

		PRINT '=======================================================================================';
		PRINT 'Loading of data into Bronze layer from ERP Source System';
		PRINT '=======================================================================================';

		SET @start_time =GETDATE();
		PRINT '>> Truncating the table Bronze.erp_cust_az12 ';
		TRUNCATE TABLE Bronze.erp_cust_az12;

		PRINT '>> Insering the data into the table Bronze.erp1-cust_az12 ';
		BULK INSERT Bronze.erp_cust_az12
		FROM 'C:\Users\Bluep\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT '>> Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds';


		SET @start_time =GETDATE();
		PRINT '>> Truncating the table Bronze.erp_loc_a101 ';
		TRUNCATE TABLE Bronze.erp_loc_a101;

		PRINT '>> Insering the data into the table Bronze.erp_loc_a101';
		BULK INSERT Bronze.erp_loc_a101
		FROM 'C:\Users\Bluep\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT '>> Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds';

		SET @start_time =GETDATE();
		PRINT '>> Truncating the table Bronze.erp_px_cat_g1v2 ';
		TRUNCATE TABLE Bronze.erp_px_cat_g1V2;

		PRINT '>> Insering the data into the table Bronze.erp_px_cat_g1v2 ';
		BULK INSERT Bronze.erp_px_cat_g1V2
		FROM 'C:\Users\Bluep\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\px_cat_g1V2.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
			);
			SET @end_time =GETDATE();
			PRINT '>> Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +' seconds';
			SET @batch_end_time = GETDATE();

	PRINT '>>Batch load Duration ' + CAST(DATEDIFF(second, @batch_start_time ,@batch_end_time ) AS NVARCHAR) + ' seconds';

		END TRY

BEGIN CATCH
PRINT '----------------------------------------------------------';
PRINT 'ERROR OCCURED DURING BRONZE LAYER';
PRINT 'ERROR_MESSAGE'+ ERROR_MESSAGE();
PRINT 'ERROR_NUMBER' + CAST (ERROR_NUMBER() AS NVARCHAR);
PRINT 'ERROR_NUMBER' + CAST (ERROR_STATE() AS NVARCHAR);
PRINT '----------------------------------------------------------'
END CATCH

END
