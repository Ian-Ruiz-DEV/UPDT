*** Settings ***
Library     Browser
Resource    ../shared/utils.resource
Resource    ../shared/global_vars.resource


*** Variables ***
${IDENTIFICADOR}      //h3[contains(text(), 'Bienvenido')]


*** Keywords ***
Abrir pagina de inicio de sesión
    [Documentation]    Ingresa la URL de SICATEL Web y espera a que cargue la página
    Step    Abrir Sitio Web (${GLOBAL_URL})
    New Page    url=${GLOBAL_URL}
    Wait For Elements State    ${IDENTIFICADOR}    stable
    Wait For Elements State    ${IDENTIFICADOR}    visible
    Highlight    ${IDENTIFICADOR}
    Log Console And Log    RESULTADO ESPERADO: Se muestra la pantalla de inicio
    Capture Image Evidence