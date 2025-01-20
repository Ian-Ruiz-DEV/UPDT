*** Settings ***
Library     SeleniumLibrary
Resource    support_keywords.resource

*** Variables ***

# Variables de inicio de sesión
${input_username}    //input[@id="user-name"]
${input_password}    //input[@id="password"]
${button_login}    //input[@id="login-button"]

#Validación PRODUCTOS
${products_label}    //span[contains(text(),'Products')]

*** Keywords ***
COM001 - Abrir Navegador a Iniciar Sesión
    # Abre el navegador y se dirige a la pagina
    Step    Abrir navegador y dirigirse a "https://www.saucedemo.com/"
    Open Browser    https://www.saucedemo.com/    Chrome
    Maximize Browser Window
    Capture Page Screenshot    ../screenshots/1.open_browser.png
    # Ingresa usuario
    Wait Until Element is Enabled and Visible    ${input_username}    60s
    Step    Ingresar usuario
    Input Text    ${input_username}    standard_user
    # Ingresa contraseña
    Wait Until Element is Enabled and Visible    ${input_password}    60s
    Step    Ingresar contraseña
    Input Text    ${input_password}    secret_sauce
    Capture Page Screenshot    ../screenshots/2.input_user_and_password.png
    # Clic Login
    Wait Until Element is Enabled and Visible    ${button_login}    60s
    Step    Hacer click en el boton login
    Click Button    ${button_login}
    # Muestra la pagina en la que nos encontramos
    ${products}    Get Text    ${products_label}
    Log To Console    > > Nos encontramos en la pantalla: ${products}
    # Valida el inicio de sesión
    ${status}    Run Keyword And Return Status    Element Should Be Visible    ${products_label}
        IF    ${status}
            Log To Console    - - Inicio de Sesión exitoso
            #Capture Page Screenshot    products.png
        ELSE
            Log To Console    - - Inicio de Sesión fallido.
        END