*** Settings ***
Library             Browser
Resource            ../resources/testcases_gherkin/ts01_autentificacion_gherkin.resource
Test Setup          Setup
#Test Teardown       Close Browser

*** Test Cases ***
CP001_Inicio de sesion
    [Documentation]    Este caso de prueba inicia sesión con credenciales válidas
    [Tags]    cp001    autenticacion    v01
    When Ingreso a la pagina de inicio
    #Then Inicio sesion con credenciales validas

*** Keywords ***
#Obtengo los datos de entrada para el caso de prueba desde un archivo Ms Excel
    #[Documentation]    Este keyword invoca la libreria ExcelReader
    #Read Test Case Data