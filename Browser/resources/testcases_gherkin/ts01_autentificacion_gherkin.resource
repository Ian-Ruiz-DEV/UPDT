*** Settings ***
Resource    ../po/com001_landing.resource
Resource    ../po/com002_login.resource
Resource    ../shared/setup_teardown.resource


*** Keywords ***
Ingreso a la pagina de inicio
    Abrir pagina de inicio de sesión

Inicio sesion con credenciales validas
    Iniciar Sesión
