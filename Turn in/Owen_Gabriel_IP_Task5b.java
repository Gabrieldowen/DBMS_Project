import java.sql.Connection;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

// added for reading csv
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.Writer;
import java.io.FileWriter;

public class sample {

    // Database credentials
    final static String HOSTNAME = "<owen0152>-sql-server.database.windows.net";
    final static String DBNAME = "cs-dsa-4513-sql-db";
    final static String USERNAME = "<owen0152>";
    final static String PASSWORD = "<Treefrogdb515!>";

    // Database connection string
    final static String URL = String.format("jdbc:sqlserver://owen0152-sql-server.database.windows.net:1433;database=cs-dsa-4513-sql-db;user=owen0152@owen0152-sql-server;password=Treefrogdb515!;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;");

    // Query templates
    final static String QUERY_TEMPLATE_1 = "EXEC [dbo].[usp_InsertCustomer] ?, ?, ?" ;

    final static String QUERY_TEMPLATE_2 = "EXEC [dbo].[usp_CreateNewDepartment] ?, ?";
    final static String QUERY_TEMPLATE_3 = "EXEC [dbo].[usp_CreateProcess] ?, ?, ?, ?, ?, ?";
    final static String QUERY_TEMPLATE_4 = "EXEC [dbo].[usp_CreateAssembly] ?, ?, ?, ?, ?";
    final static String QUERY_TEMPLATE_5 = "EXEC [dbo].[usp_CreateAccount] ?, ?, ?, ?";
    final static String QUERY_TEMPLATE_6 = "EXEC [dbo].[usp_CreateJob] ?, ?, ?, ?";
    final static String QUERY_TEMPLATE_7 = "EXEC [dbo].[usp_CompleteJob] ?, ?, ?, ?, ?, ?, ?, ?, ?";
    final static String QUERY_TEMPLATE_8 = "EXEC [dbo].[usp_CreateTransaction] ?, ?, ?";
    final static String QUERY_TEMPLATE_9 = "EXEC [dbo].[usp_GetAssemblyCost] ?";
    final static String QUERY_TEMPLATE_10 = "EXEC [dbo].[usp_GetDepartmentTime] ?, ?, ?";
    final static String QUERY_TEMPLATE_11 = "EXEC [dbo].[usp_GetCompletedProcesses] ?";
    final static String QUERY_TEMPLATE_12 = "EXEC [dbo].[usp_GetCustomer] ?, ?";
    final static String QUERY_TEMPLATE_13 = "EXEC [dbo].[usp_DeleteJobs] ?, ?";
    final static String QUERY_TEMPLATE_14 = "EXEC [dbo].[usp_ChangeColor] ?, ?";
    final static String QUERY_TEMPLATE_15 = "EXEC [dbo].[usp_InsertCustomer] ?, ?, ?";
    final static String QUERY_TEMPLATE_16 =  "EXEC [dbo].[usp_GetCustomer] ?, ?";

    // User input prompt//
    final static String PROMPT = 
            "\nPlease select one of the options below: \n" +
            "1) Insert new Customer; \n" + 
            "2) Insert New Department; \n" + 
            "3) Insert new Process;\n" +
            "4) Insert new Assembly; \n" + 
            "5) Insert new Account; \n" + 
            "6) Insert new Job;\n" +
            "7) Complete Job; \n" + 
            "8) Insert Transaction; \n" + 
            "9) Get Assembly Cost;\n" +
            "10) Get Department Work Hours; \n" + 
            "11) Get completed jobs; \n" + 
            "12) Get Customers;\n"+
            "13) Delete Cut Jobs; \n" + 
            "14) Change Paint color; \n" + 
            "15) Import;\n"+
            "16) Export; \n" + 
            "17) Exit!";

    public static void main(String[] args) throws SQLException {

        System.out.println("WELCOME TO THE JOB-SHOP ACCOUNTING DATABASE SYSTEM!");

        final Scanner sc = new Scanner(System.in); // Scanner is used to collect the user input
        String option = ""; // Initialize user option selection as nothing
        while (!option.equals("17")) { // As user for options until option 3 is selected
            System.out.println(PROMPT); // Print the available options
            option = sc.next(); // Read in the user option selection

            switch (option) { // Switch between different options
            
                case "1": // Create new customer
                    
                	sc.nextLine();
                    System.out.println("Please enter Customer Name:");
                    final String Name = sc.nextLine();

                    System.out.println("Please enter Address:");
                    final String Address = sc.nextLine(); 
                    
                    System.out.println("Please enter Category 1-10:");
                    final int Category = sc.nextInt(); 
                    

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_1)) {
                            // Populate the query template with the data collected from the user
                            statement.setString(1, Name);
                            statement.setString(2, Address);
                            statement.setInt(3, Category);

                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                    }
                    break;
                case "2": // Create a new Department
                    
                	sc.nextLine();
                    System.out.println("Please enter Department Number:");
                    final int DepartmentNumber = sc.nextInt();

                    System.out.println("Please enter Department Data:");
                    sc.nextLine();
                    final String DepartmentData = sc.nextLine(); 
                    

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_2)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, DepartmentNumber);
                            statement.setString(2, DepartmentData);

                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                    }
                    break;
                case "3": //Create New Process

                	sc.nextLine();
                    System.out.println("Please enter Process ID:");
                    final int ProcessID = sc.nextInt();

                    System.out.println("Please enter Process Type (1:Fit, 2:Paint, 3:Cut):");
                    sc.nextLine();
                    final int ProcessTypeID = sc.nextInt();
                    
                    System.out.println("Please enter Department Number:");
                    sc.nextLine();
                    final int Department = sc.nextInt();
                    
                    // below code just gives a different prompt based on Process Type
                    String Attr1 = "";
                    String Attr2 = "";
                    if(ProcessTypeID == 1) {
                    	System.out.println("Please enter Fit Type:");
                    	sc.nextLine();
                        Attr1 = sc.nextLine();
                    }
                    else if(ProcessTypeID == 2) {
                    	System.out.println("Please enter paint type");
                    	sc.nextLine();
                        Attr1 = sc.nextLine();
                        
                        System.out.println("Please enter paint method");
                        Attr2 = sc.nextLine();
                    }
                    else if(ProcessTypeID == 3) {
                    	System.out.println("please enter cutting type:");
                    	sc.nextLine();
                        sc.nextLine();
                        
                        System.out.println("please enter machine type");
                        sc.nextLine();
                    }
                    

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_3)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, ProcessID);
                            statement.setInt(2, ProcessTypeID);
                            statement.setInt(3, Department);
                            statement.setInt(4, ProcessID);
                            statement.setString(5, Attr1);
                            statement.setString(6, Attr2);

                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                    }

                    break;
                case "4": // Create Assembly
                	sc.nextLine();
                    System.out.println("Please enter Assembly ID:");
                    final int AssemblyID = sc.nextInt();

                    System.out.println("Please enter Date Ordered (YYYY-MM-DD):");                  
                    sc.nextLine();
                    final String DateOrdered = sc.nextLine();
                    
                    System.out.println("Please enter Assembly Details:");               
                    final String AssemblyDetails = sc.nextLine();
                    
                    System.out.println("Please enter Customer Name:");                    
                    final String CustomerName = sc.nextLine();
                    
                    System.out.println("Please enter Associated ProcessID:");                    
                    final int ProcessID2 = sc.nextInt();
                    
                    

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_4)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, AssemblyID);
                            statement.setString(2, DateOrdered);
                            statement.setString(3, AssemblyDetails);
                            statement.setString(4, CustomerName);
                            statement.setInt(5, ProcessID2);


                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                    }

                    break;
                case "5": // create a new account
                	sc.nextLine();
                    System.out.println("Please enter Account Number:");
                    final int AccountNumber = sc.nextInt();
                    
                    sc.nextLine();
                    System.out.println("Please enter Account Type (1:Assembly, 2:Department, 3:Process):");                    
                    final int AccountTypeID = sc.nextInt();
                    
                    // need to get a different kind of id depending on account type
                    // i.e. process ID for a account with type process
                    int AssociationID = 0;
                    if(AccountTypeID == 1) {
                    	System.out.println("Please enter AssemblyID:");
                        AssociationID = sc.nextInt();
                    }
                    if(AccountTypeID == 2) {
                    	System.out.println("Please enter DepartmentID:");
                        AssociationID = sc.nextInt();
                    }
                    if(AccountTypeID == 3) {
                    	System.out.println("Please enter ProcessID:");
                        AssociationID = sc.nextInt();
                    }
                    sc.nextLine();
                    System.out.println("Please enter Todays Date (YYYY-MM-DD):");                    
                    final String DateCreated = sc.nextLine();
                    

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_5)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, AccountNumber);
                            statement.setInt(2, AssociationID);
                            statement.setString(3, DateCreated);
                            //statement.setString(4, Details);
                            statement.setInt(4, AccountTypeID);


                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                    }

                    break;
                    
                case "6": //Create Job
                	sc.nextLine();
                    System.out.println("Please enter new Job ID:");
                    final int JobID = sc.nextInt();

                    System.out.println("Please enter AssemblyID:");                  
                    sc.nextLine();
                    final String Assemblyid = sc.nextLine();
                    
                    System.out.println("Please enter Process ID:");               
                    final String Processid = sc.nextLine();
                    
                    System.out.println("Please enter Job start Date (YYYY-MM-DD):");                    
                    final String DateStart = sc.nextLine();

                    
                    

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_6)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, JobID);
                            statement.setString(2, Assemblyid);
                            statement.setString(3, Processid);
                            statement.setString(4, DateStart);


                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                    }

                    break;
                case "7": // Complete Job
                	sc.nextLine();
                    System.out.println("Please enter Job ID:");
                    final int Jobid = sc.nextInt();
                    
                    sc.nextLine();
                    System.out.println("Please enter Job End Date (YYYY-MM-DD):");                    
                    final String DateEnd = sc.nextLine();
                    
                    
                    System.out.println("Please enter Job Type ID:");
                    final int JobTypeID = sc.nextInt();
                    
                    sc.nextLine();
                    System.out.println("Please enter Labor Time:");
                    float LaborTime = sc.nextFloat();
                    
                    
                    String Color = "";
                    float Volume = 0;
                    String MachineType = "";
                    float MachineTime = 0;
                    String Material = "";


                    // depending on the job type enter different parameters
                    if(JobTypeID == 1) {

                    }
                    if(JobTypeID == 2) {	
                    	System.out.println("Please enter Paint volume:");
                    	Volume = sc.nextFloat();
                    	
                    	sc.nextLine();
                    	
                    	System.out.println("Please enter paint Color:");
                    	Color = sc.nextLine();
                       	
                    }
                    if(JobTypeID == 3) {
                    	System.out.println("Please enter Machine Time:");
                    	MachineTime = sc.nextFloat();
                    	
                    	sc.nextLine();
                    	
                    	System.out.println("Please enter Machine Type:");
                    	MachineType = sc.nextLine();
                    	
                    	System.out.println("Please enter Material:");
                    	Material = sc.nextLine();
                    }
                    
                    
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_7)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, Jobid);
                            statement.setInt(2, JobTypeID);
                            statement.setString(3, DateEnd);
                            statement.setFloat(4, LaborTime);
                            statement.setString(5, Color);
                            statement.setFloat(6, Volume);
                            statement.setString(7, MachineType);
                            statement.setFloat(8, MachineTime);
                            statement.setString(9, Material);


                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                    }
                

                    break;
                case "8": // Create a new Transaction
                	sc.nextLine();
                    System.out.println("Please enter new Transaction Number:");
                    final int TransactionNumber = sc.nextInt();

                    System.out.println("Please enter Job Number:");                  
                    sc.nextLine();
                    final int JobNumber = sc.nextInt();
                    
                    sc.nextLine();
                    System.out.println("Please enter SupCost:");               
                    final float SupCost = sc.nextFloat();
                    
                    
                    
                    sc.nextLine();
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_8)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, TransactionNumber);
                            statement.setInt(2, JobNumber);
                            statement.setFloat(3, SupCost);



                            System.out.println("Dispatching the query...");
                            // Actually execute the populated query
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                    }

                    break;
                case "9": // Get cost related to an assembly
                	sc.nextLine();
                    System.out.println("Please enter Assembly Number:");
                    final int AssemblyNum = sc.nextInt();   
                    
                    sc.nextLine();
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_9)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, AssemblyNum);

                            System.out.println("Dispatching the query...");

                            
                            System.out.println("Contents of the Assembly Cost:");
                            System.out.println("AccountNumber | AssemblyID | Details ");
                            // Execute the query and get the result set
                            try (ResultSet resultSet = statement.executeQuery()) {
                                // Process the result set
                                while (resultSet.next()) {
                                	 System.out.println(String.format("%d | %d | %.2f  ",
                                             resultSet.getInt(1),
                                             resultSet.getInt(2),
                                             resultSet.getFloat(3)));                     
                                }
                            }

                            System.out.println("Query executed successfully.");
                        }
                        }

                    break;
                case "10": // gets total labor hours for a given department
                	sc.nextLine();
                    System.out.println("Please enter Department Number:");
                    final int DepartmentNum = sc.nextInt();   
                    
                    sc.nextLine();
                    System.out.println("Please enter the start of the date range (YYYY-MM-DD):");  
                    final String StartDate = sc.nextLine();  
                    

                    System.out.println("Please enter the end of the date range (YYYY-MM-DD):");
                    final String EndDate = sc.nextLine();  
                    
                    
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_10)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, DepartmentNum);
                            statement.setString(2, StartDate);
                            statement.setString(3, EndDate);

                            System.out.println("Dispatching the query...");

                            
                            System.out.println("Department Labor hours:");
                            // Execute the query and get the result set
                            try (ResultSet resultSet = statement.executeQuery()) {
                                // Process the result set
                                while (resultSet.next()) {
                                	 System.out.println(String.format("| %.2f |",
                                             resultSet.getFloat(1)
                                            ));                     
                                }
                            }

                            System.out.println("Query executed successfully.");
                        }
                        }

                    break;
                case "11": // Gets completed processes
                	sc.nextLine();
                    System.out.println("Please enter Assembly Number:");
                    final int AssemblyN = sc.nextInt();   
                    
                    sc.nextLine();  
                    
                    
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_11)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, AssemblyN);

                            System.out.println("Dispatching the query...");

                            
                            System.out.println("Contents completed processes for that assembly:");
                            System.out.println("ProcessID | Department No. | JobID | Date Ended ");
                            // Execute the query and get the result set
                            try (ResultSet resultSet = statement.executeQuery()) {
                                // Process the result set
                                while (resultSet.next()) {
                                	 System.out.println(String.format("%d | %d | %d | %s  ",
                                             resultSet.getInt(1),
                                             resultSet.getInt(2),
                                             resultSet.getInt(3),
                                			 resultSet.getString(4)));                     
                                }
                            }
                            
                            System.out.println("Query executed successfully.");
                        }
                        }

                    break;
                case "12": // Gets user within given category range
                	sc.nextLine();
                    System.out.println("Please enter Catergory Lower bound 1-10:");
                    final int CategoryMin = sc.nextInt();
                    
                    sc.nextLine();
                    System.out.println("Please enter Catergory Upper bound 1-10:");
                    final int CategoryMax = sc.nextInt();  
                    
                    sc.nextLine();  
                    
                    
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_12)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, CategoryMin);
                            statement.setInt(2, CategoryMax);


                            System.out.println("Dispatching the query...");

                            
                            System.out.println("Contents of the Assembly Cost:");
                            System.out.println("Name | Addresss | Category ");
                            // Execute the query and get the result set
                            try (ResultSet resultSet = statement.executeQuery()) {
                                // Process the result set
                                while (resultSet.next()) {
                                	 System.out.println(String.format("%s | %s | %d",
                                			 resultSet.getString(1),
                                			 resultSet.getString(2),
                                             resultSet.getInt(3)));                     
                                }
                            }
                            
                            System.out.println("Query executed successfully.");
                        }
                        }

                    break;
                case "13": // Deletes cut jobs within range of IDs given
                	sc.nextLine();
                    System.out.println("Please enter JobID Lower bound:");
                    final int JobIDMin = sc.nextInt();
                    
                    sc.nextLine();
                    System.out.println("Please enter JobID Upper bound:");
                    final int JobIDMax = sc.nextInt();  
                    
                    sc.nextLine();  
                    
                    
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_13)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, JobIDMin);
                            statement.setInt(2, JobIDMax);


                            System.out.println("Dispatching the query...");

                            // Execute the query and get the result set
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                        }

                    break;
                case "14": // Changed color of a paint job
                	sc.nextLine();
                    System.out.println("Please enter JobID:");
                    final int PaintJobID = sc.nextInt();
                    
                    sc.nextLine();
                    System.out.println("Please enter New Color:");
                    final String NewColor = sc.nextLine();  
                    
                    
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_14)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, PaintJobID);
                            statement.setString(2, NewColor);


                            System.out.println("Dispatching the query...");

                            // Execute the query and get the result set
                            final int rows_inserted = statement.executeUpdate();
                            System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
                        }
                        }
                    break;
                case "15": // import csv

                	sc.nextLine();
                    System.out.println("Please enter csv file location:");
                    final String FileLocation = sc.nextLine();
                    
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                    	String csvFilePath = FileLocation;
                        try (BufferedReader reader = new BufferedReader(new FileReader(csvFilePath))) {
                            String line;
                            
                            //remove header
                            reader.readLine();


                            try (PreparedStatement preparedStatement = connection.prepareStatement(QUERY_TEMPLATE_15)) {
                                while ((line = reader.readLine()) != null) { //read file into no more lines
                                    String[] columns = line.split(","); // Adjust the delimiter if needed

                                    // Assuming your CSV has three columns (adjust as needed)
                                    preparedStatement.setString(1, columns[0]);
                                    preparedStatement.setString(2, columns[1]);
                                    preparedStatement.setString(3, columns[2]);

                                    // Execute the query
                                    preparedStatement.executeUpdate();
                                }
                                System.out.println("Query executed successfully.");
                            }
                        } catch (IOException | SQLException e) {
                            e.printStackTrace();
                        }
                        }

                    break;
                case "16": // export to csv
                	
                	sc.nextLine();
                    System.out.println("Please enter Catergory Lower bound 1-10:");
                    final int CategoryLow = sc.nextInt();
                    
                    sc.nextLine();
                    System.out.println("Please enter Catergory Upper bound 1-10:");
                    final int CategoryUp = sc.nextInt();  
                    
                    sc.nextLine();  
                    System.out.println("Please enter output file name:");
                    final String FileName = sc.nextLine();
                    final String FilePath = FileName + ".csv";
                    
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(QUERY_TEMPLATE_12)) {
                            // Populate the query template with the data collected from the user
                            statement.setInt(1, CategoryLow);
                            statement.setInt(2, CategoryUp);


                            System.out.println("Dispatching the query...");
                            
                            // Execute the query and get the result set
                            try (ResultSet resultSet = statement.executeQuery();
                            		Writer writer = new FileWriter(FilePath)) {
                                // Process the result set

                                    // Write CSV header
                            		writer.write("CustomerName,Address,Category\n");

                                
	                                while (resultSet.next()) {
	                        			 writer.write(resultSet.getString(1) + ",");
	                        			 writer.write(resultSet.getString(2) + ",");
	                        			 writer.write(resultSet.getString(3) + ",\n");                    
	                                }
                            	} catch (IOException e) {
                            	    e.printStackTrace(); // Handle the exception appropriately
                            	}
                            }
                            
                            System.out.println("Query executed successfully.");
                        }
                        

                    break;
                    
                case "17": // Do nothing, the while loop will terminate upon the next iteration
                    System.out.println("Exiting! Good-buy!");
                    break;
                default: // Unrecognized option, re-prompt the user for the correct one
                    System.out.println(String.format(
                        "Unrecognized option: %s\n" + 
                        "Please try again!", 
                        option));
                    break;
            }
        }

        sc.close(); // Close the scanner before exiting the application
    }
}
