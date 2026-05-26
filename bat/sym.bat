:: 管理者権限で，このスクリプトと同じディレクトリにあるバッチファイルを "C:\Windows\*" にシンボリックリンクとして登録する
@echo off

:: 管理者権限で実行しているか確認
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 管理者権限で再実行します...
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %*", "", "runas", 1 >> "%temp%\admin.vbs"
    cscript //nologo "%temp%\admin.vbs"
    del "%temp%\admin.vbs"
    exit
)

:: 引数の確認
if "%~1"=="" (
    call utf8
    echo 第 1 引数に，バッチファイル名を指定してください．
    pause
    exit /b 1
)

:: 引数を変数に設定
set name=%~1

:: このスクリプト自身がシンボリックリンクの場合，PowerShell でリンク先の実体ディレクトリを解決する
set "target_dir=%~dp0"
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "$t = (Get-Item '%~f0').Target; if ($t) { Split-Path $t -Parent } else { Split-Path '%~f0' -Parent }"`) do set "target_dir=%%I\"

:: シンボリックリンクの作成（既存のリンクやリンク切れも含めて事前に削除）
del "C:\Windows\%name%.bat" 2>nul
mklink "C:\Windows\%name%.bat" "%target_dir%%name%.bat"
pause