# This script automates the creation of a new user account in Active Directory
# and adds the user to a specified security group.
# This version includes a user existence check and forces a password change on first logon.

# 1. Prompt for user information
# Use Read-Host to get input from the user.
$firstName = Read-Host "Enter the new employee's first name"
$lastName = Read-Host "Enter the new employee's last name"
$department = Read-Host "Enter the new employee's department"
$groupName = Read-Host "Enter the security group name to add the user to"

# 2. Add a password prompt for the initial, temporary password.
# Use Read-Host with the -AsSecureString parameter for security.
$password = Read-Host -AsSecureString "Enter a temporary password for the new user"

# 3. Generate the username
# This creates a username in the format of first initial + last name.
$username = ($firstName.Substring(0,1) + $lastName).ToLower()

# 4. Check if the user already exists before attempting to create them.
# Get-ADUser will return an object if the user exists.
Write-Host "Checking if user '$username' already exists..."
try {
    $existingUser = Get-ADUser -Identity $username -ErrorAction Stop
    Write-Host "An error occurred: User account '$username' already exists. Aborting script."
    return
}
catch {
    Write-Host "Username is available. Continuing with user creation..."
}

# 5. Create the new user account with the password.
Write-Host "Creating user account for $username..."
try {
    $newUser = New-ADUser -Name "$firstName $lastName" -SamAccountName $username -GivenName $firstName -Surname $lastName -Department $department -AccountPassword $password -Enabled $true -PassThru

    # 6. Force the user to change their password at the next logon.
    # The correct cmdlet is Set-ADUser, not Set-ADAccountPassword.
    Set-ADUser -Identity $newUser -ChangePasswordAtLogon $true
    
    # 7. Add the user to a security group.
    # We'll use a try...catch block here to handle errors if the group doesn't exist.
    Write-Host "Adding user '$username' to group '$groupName'..."
    try {
        Add-ADGroupMember -Identity $groupName -Members $newUser
    }
    catch {
        Write-Host "Warning: Could not add user to group '$groupName'. The group may not exist. Please check your spelling."
    }
    
    # 8. Display a final confirmation summary.
    Write-Host "--------------------------------------------------------"
    Write-Host "Success! New user account created with the following details:"
    Write-Host "Full Name: $($newUser.Name)"
    Write-Host "Username: $($newUser.SamAccountName)"
    Write-Host "Department: $($newUser.Department)"
    Write-Host "Password Change Required: True"
    Write-Host "--------------------------------------------------------"
}
catch {
    Write-Host "An error occurred during user creation: $_"
}
