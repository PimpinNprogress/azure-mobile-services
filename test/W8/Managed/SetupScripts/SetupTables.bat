@echo off
if "%1" == "" goto :Error
goto :Start

:Error
echo usage: %0 ^<application name^>
echo   where application name is an Azure Mobile Service app.
echo   To run the login tests, the application needs to be configured
echo   with all four providers.
goto :TheEnd

:Start
azure mobile table create %1 w8Admin
azure mobile table create %1 w8Application
azure mobile table create %1 w8Authenticated
azure mobile table create %1 w8RoundTripTable
azure mobile table create %1 w8Movies
azure mobile table create %1 w8PushTest
azure mobile table create %1 ParamsTestTable

azure mobile table update -p insert=admin,read=admin,update=admin,delete=admin %1 w8Admin
azure mobile table update -p insert=application,read=application,update=application,delete=application %1 w8Application
azure mobile table update -p insert=user,read=user,update=user,delete=user %1 w8Authenticated

azure mobile script upload %1 table/w8Movies.insert -f w8Movies.insert.js
azure mobile script upload %1 table/w8RoundTripTable.insert -f w8RoundTripTable.insert.js
azure mobile script upload %1 table/w8RoundTripTable.read -f w8RoundTripTable.read.js
azure mobile script upload %1 table/w8RoundTripTable.update -f w8RoundTripTable.update.js
azure mobile script upload %1 table/w8PushTest.insert -f w8PushTest.insert.js
azure mobile script upload %1 table/ParamsTestTable.insert -f ParamsTestTable.insert.js
azure mobile script upload %1 table/ParamsTestTable.read -f ParamsTestTable.read.js
azure mobile script upload %1 table/ParamsTestTable.update -f ParamsTestTable.update.js
azure mobile script upload %1 table/ParamsTestTable.delete -f ParamsTestTable.delete.js

:TheEnd