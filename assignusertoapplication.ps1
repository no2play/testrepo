# Install AzureAD module if not already installed
# Install-Module -Name AzureAD -Force -AllowClobber

# Connect to Azure AD
Connect-AzureAD

# Define your Application ID
$appId = "1862df10-40ee-4d36-b5a2-34ce315253a1"

# Retrieve the Service Principal of the Application using Application ID
$servicePrincipal = Get-AzureADServicePrincipal -Filter "AppId eq '$appId'"

if ($null -eq $servicePrincipal) {
    Write-Host "Application not found. Exiting..."
    exit
}

# Get all users you want to assign (for example, all users in the directory)
$users = Get-AzureADUser -All $true

# Loop through each user and assign to the application
foreach ($user in $users) {
    # Ensure the user is not already assigned to the application
    $existingAssignment = Get-AzureADUserAppRoleAssignment -ObjectId $user.ObjectId | Where-Object { $_.ResourceId -eq $servicePrincipal.ObjectId }

    if ($existingAssignment) {
        Write-Host "User $($user.UserPrincipalName) already assigned to the application. Skipping..."
    } else {
        # Assign user to the application (no Role ID needed)
        try {
            Write-Host "Assigning user $($user.UserPrincipalName) to the application..."
            New-AzureADUserAppRoleAssignment -ObjectId $user.ObjectId -PrincipalId $user.ObjectId -ResourceId $servicePrincipal.ObjectId
        } catch {
            Write-Host "Failed to assign user $($user.UserPrincipalName): $_"
        }
    }
}

Write-Host "Script completed."
