$temp_path = "C:\Users\Public\Documents\"

$installer_url1 = "https://testestorageaa.blob.core.windows.net/installers/AutomationAnywhereBotAgent.msi"
$installer_file1 = $temp_path + [System.IO.Path]::GetFileName( $installer_url1 )

$installer_url2 = "https://testestorageaa.blob.core.windows.net/installers/ChromeSetup.exe"
$installer_file2 = $temp_path + [System.IO.Path]::GetFileName( $installer_url2 )

$extension_url = "https://testestorageaa.blob.core.windows.net/installers/kammdlphdfejlopponbapgpbgakimokm.zip"
$extension_file = $temp_path + [System.IO.Path]::GetFileName( $extension_url )

$installer_folder = $temp_path + [System.IO.Path]::GetFileName( $extension_url ).split(".")[0]
$chrome_installer = "C:\Program Files\Google\Chrome\Application\chrome.exe"

Try
{
    Invoke-WebRequest -Uri $installer_url1 -OutFile $installer_file1

    Invoke-WebRequest -Uri $installer_url2 -OutFile $installer_file2
    
    Invoke-WebRequest -Uri $extension_url -OutFile $extension_file

    Start-Process -FilePath $installer_file2 -ArgumentList "/silent /install" -Wait

    Start-Process -FilePath $installer_file1 -ArgumentList "/quiet" -Wait

    Expand-Archive $extension_file -DestinationPath $temp_path

    & $chrome_installer --load-extension=$installer_folder
} 
Catch
{
   Write-Output ( $_.Exception.ToString() )
   Break
}