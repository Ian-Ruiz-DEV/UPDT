*** Settings ***
Library     Browser
Resource    ../shared/utils.resource


*** Variables ***
## CREDENCIALES ##
${CAMPO_USUARIO}        //input[@id="logonIdentifier"]
${CAMPO_CONTRASENA}     //input[@id="password"]

## BOTON ##
${BOTON_LOGIN}                              //button[@id="next"]

*** Keywords ***
Iniciar Sesión
    [Documentation]    Inicia sesión con los datos de usuario y contraseña proporcionados.
    Step    Ingresar Usuario "${TEST_DATA}[correo_usuario]"
    # Esperamos a que cargue el campo de Usuario en la pagina de inicio
    Wait For Elements State    ${CAMPO_USUARIO}    stable
    Wait For Elements State    ${CAMPO_USUARIO}    visible
    Highlight    ${CAMPO_USUARIO}
    # Ingresamos el usuario proporcionado en el archivo de datos
    Type Text    ${CAMPO_USUARIO}    ${TEST_DATA}[correo_usuario]
    Step    Ingresar Contraseña "********"
    Wait For Elements State    ${CAMPO_CONTRASENA}    stable
    Wait For Elements State    ${CAMPO_CONTRASENA}    visible
    Highlight    ${CAMPO_CONTRASENA}
    # Escibimos la contraseña en el campo correspondiente
    Log Console And Log    ${CAMPO_CONTRASENA}
    Type Text    ${CAMPO_CONTRASENA}    $decrypted    
    # Validación de tipo de usuario
    Step    Hacer Click en Boton "Entrar"
    # Esperamos a que aparezca el boton de "Entrar" y damos click en el para iniciar sesión
    Wait For Elements State    ${BOTON_LOGIN}    stable
    Wait For Elements State    ${BOTON_LOGIN}    visible
    Highlight    ${BOTON_LOGIN}
    Click    ${BOTON_LOGIN}
    Sleep    10s