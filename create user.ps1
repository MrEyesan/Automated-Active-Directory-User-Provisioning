# This script automates the creation of a new user account in Active Directory
# and adds the user to a specified security group.

# 1. Prompt for user information
# Use Read-Host to get input from the user.
$firstName = Read-Host "Enter the new employee's first name"
$lastName = Read-Host "Enter the new employee's last name"
$department = Read-Host "Enter the new employee's department"
$groupName = Read-Host "Enter the security group name to add the user to"

# 2. Generate the username
# This creates a username in the format of first initial + last name.
$username = ($firstName.Substring(0,1) + $lastName).ToLower()

# 3. Create the new user account
# New-ADUser is the cmdlet for creating users.
# -Name: Sets the display name (e.g., "John Doe").
# -SamAccountName: Sets the username for logging in (e.g., "jdoe").
# -GivenName: Sets the first name.
# -Surname: Sets the last name.
# -Department: Sets the user's department.
# -Enabled: Makes the account active.
# -PassThru: Returns the created user object, which is useful for confirmation.
Write-Host "Creating user account for $username..."
try {
    $newUser = New-ADUser -Name "$firstName $lastName" -SamAccountName $username -GivenName $firstName -Surname $lastName -Department $department -Enabled $true -PassThru

    # 4. Add the user to a security group
    # Add-ADGroupMember adds the user to a group.
    Write-Host "Adding user $username to group $groupName..."
    Add-ADGroupMember -Identity $groupName -Members $newUser
    
    # 5. Display a confirmation message
    Write-Host "--------------------------------------------------------"
    Write-Host "Success! New user '$firstName $lastName' ($username) created and added to '$groupName'."
    Write-Host "--------------------------------------------------------"
}
catch {
    Write-Host "An error occurred: $_"
}
