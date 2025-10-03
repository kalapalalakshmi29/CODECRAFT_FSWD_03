@echo off
echo Starting FreshMart Backend Server...
echo.
echo Installing dependencies...
npm install
echo.
echo Starting server on http://localhost:3001
echo MongoDB will connect to: mongodb://localhost:27017/freshmart_ecommerce
echo.
npm start