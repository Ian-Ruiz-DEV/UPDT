*** Settings ***
Library     Collections
Library     DateTime
Library     Browser
Resource    utils.resource
Resource    ../shared/global_vars.resource

*** Variables ***
${BROWSER}          chromium
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
    New Browser
    ...                     browser=${BROWSER}
    ...                     headless=${headless}
    ...                     args=${ARGS}
    ...                     slowMo=${SLOWMO}
    ${har_config}=    Create Dictionary    path=${HAR_DIR}
    ${context}=    Create Dictionary
    ...    viewport=${NONE}
    IF    $ENABLE_VIDEO
        Set To Dictionary    ${context}    recordVideo={"dir": r"${VIDEO_DIR}", "size": ${VIEWPORT}}
    END
    Set Browser Timeout     timeout=${TIMEOUT}
    IF    $ENABLE_HAR
        New Context             &{context}    acceptDownloads=True     recordHar=${har_config}
    ELSE
        New Context             &{context}    acceptDownloads=True
    END
    Log Dictionary          dictionary=${context}
    Register Keyword To Run On Failure    ${NONE}

Teardown
    Close Browser
    IF    '${TEST STATUS}' == 'FAIL'
        Log To Console    Agregar a archivo
    END