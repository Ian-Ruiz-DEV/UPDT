*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/testcases_gherkin/TC001_test_gherkin.resource

*** Test Cases ***
TC01 Compra Exitosa
    [Documentation]    Este caso de prueba inicia sesión con credenciales válidas
    [Tags]    cp001    autenticacion    v01
    When Ingreso a la pagina de inicio