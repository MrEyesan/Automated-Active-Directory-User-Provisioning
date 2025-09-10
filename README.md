# Automated-Active-Directory-User-Provisioning
This project demonstrates the automation of a common IT administration task: creating and provisioning new user accounts in Active Directory. The solution uses a PowerShell script to streamline the manual process of setting up new employees, saving time and reducing the risk of human error.

The project was completed in a virtualized lab environment running Windows Server 2022 and Active Directory Domain Services (AD DS).
# Key Features
* Automated User Creation: Prompts for key user details (name, department, group) and creates a new user account with a standardized username format (first_initial + last_name).
* Password Management: Sets a secure, temporary password and forces the user to change it upon their first login, adhering to modern security best practices.
* Group Membership: Automatically adds the new user to a specified Active Directory security group for proper permissions management.
* Robust Error Handling: Includes checks to prevent the creation of duplicate usernames and provides clear, descriptive error messages to the user.
# Technologies Used 
* PowerShell: The scripting language used to automate the task.
* Active Directory Module for PowerShell: A set of cmdlets for managing Active Directory objects.
* Windows Server 2022: The operating system running in the virtual environment.
# How to Use the Script
To use this script, you must be logged into a Windows Server with Active Directory Domain Services installed and promoted to a domain controller.
1. Open PowerShell ISE as an Administrator.
2. Copy and paste the contents of create_user.ps1 into the editor pane.
3. Run the script by pressing F5 or clicking the "Run Script" button.
4. Follow the prompts to enter the new employee's information.
   The script will handle the user creation and provide a success message upon completion.
# Next Steps & Enhancements
* Prompt for Organizational Unit (OU): Update the script to allow an administrator to specify which OU the user should be placed in.
* CSV Import: Modify the script to read a list of new users from a CSV file, enabling the bulk creation of user accounts.
* Logging: Add logging functionality to record script actions and outputs to a text file for auditing purposes.
