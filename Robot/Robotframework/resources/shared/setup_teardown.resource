*** Settings ***
Library     Collections
Library     DateTime
Library     SeleniumLibrary
Resource    utils.resource
Resource    ../shared/global_vars.resource

*** Variables ***
${BROWSER}          chrome
${SLOWMO}           1000ms
${TIMEOUT}          60s
@{ARGS}             --start-maximized
&{VIEWPORT}         width=1920    height=1070
${ENABLE_VIDEO}     ${FALSE}
${headless}         ${FALSE}
${ENABLE_HAR}       ${FALSE}

*** Keywords ***
Setup
    [Documentation]    Configuración inicial para la ejecución de los casos de prueba automatizados
    ${datetime}=    Get Current Date    result_format=%Y%m%d%H%M%S
    Set Suite Variable    $VIDEO_DIR    ${OUTPUT_DIR}/${SUITE_NAME}/${TEST_NAME}_${datetime}/video
    Set Suite Variable    $IMAGE_DIR    ${OUTPUT_DIR}/${SUITE_NAME}/${TEST_NAME}_${datetime}/image
    Set Suite Variable    $DOWNLOADS_DIR    ${OUTPUT_DIR}/${SUITE_NAME}/${TEST_NAME}_${datetime}/downloads
    Set Suite Variable    $HAR_DIR      ${OUTPUT_DIR}/${SUITE_NAME}/${TEST_NAME}_${datetime}/har
    
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Run Keyword If    ${headless}    Call Method    ${options}    add_argument    --headless
    FOR    ${arg}    IN    @{ARGS}
        Call Method    ${options}    add_argument    ${arg}
    END
    
    Open Browser    ${GLOBAL_URL}    ${BROWSER}    options=${options}
    
    Set Selenium Timeout    ${TIMEOUT}
    ${har_config}=    Create Dictionary    path=${HAR_DIR}
    ${context}=    Create Dictionary
    ...    viewport=${NONE}
    Log Dictionary          dictionary=${context}
    Register Keyword To Run On Failure    ${NONE}

Teardown
    Close Browser
    IF    '${TEST STATUS}' == 'FAIL'
        Log To Console    Agregar a archivo
    END