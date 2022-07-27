function Push-FileToSPODrive {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)]
        [String]
        $DriveId,

        [Parameter(Mandatory=$true)]
        [System.IO.FileInfo]
        $FilePath,

        [Parameter(Mandatory=$false)]
        [string]
        $DriveDirectory,

        [Parameter(Mandatory=$True)]
        [PSCustomObject]
        $Token
    )
    
    begin {
        $Content = Get-Content -Path $Filepath | Out-String
        $Filename = (Get-Item -path $Filepath).Name
        if($DriveDirectory){
            $Source = "drives/$DriveId/root:/$DriveDirectory/$($Filename):/content"
        }
        else{
            $Source = "drives/$DriveId/root:/$($Filename):/content"
        }
        
    }
    
    process {
        $UploadFileSplat = @{
            Token = $Token
            Method = 'PUT'
            Resource = $Source
            Body = $Content
        }
        
        Invoke-GraphApiRequest @UploadFileSplat
    }
}
