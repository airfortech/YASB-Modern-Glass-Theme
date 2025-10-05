$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3"

$data = (Get-ItemProperty -Path $path).Settings

if ($data[8] -eq 3) {
    Write-Output "Taskbar auto-hide is currently ON. Turning it OFF..."
    $data[8] = 2
} elseif ($data[8] -eq 2) {
    Write-Output "Taskbar auto-hide is currently OFF. Turning it ON..."
    $data[8] = 3
} else {
    Write-Output "Unknown state detected ($($data[8])). No changes applied."
    exit
}

Set-ItemProperty -Path $path -Name Settings -Value $data

Stop-Process -Name explorer -Force
Start-Sleep -Seconds 1
Start-Process explorer.exe

&"C:\Program Files\YASB\yasbc.exe" reload

Write-Output "Done."
