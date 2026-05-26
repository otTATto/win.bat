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

:: シンボリックリンクの作成
if exist "C:\Windows\%name%.bat" (
    :: 既に存在する場合，削除してから作成
    del "C:\Windows\%name%.bat"
)
mklink "C:\Windows\%name%.bat" "%~dp0%name%.bat"
pause