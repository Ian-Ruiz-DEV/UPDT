*** Settings ***
Library     SeleniumLibrary

*** Variables ***

${step_number}    0

*** Keywords ***
Wait Until Element is Enabled and Visible
    [Arguments]    ${locator}    ${TIMEOUT}
    ${visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    IF  ${visible}
        ${enabled}    Run Keyword And Return Status    Wait Until Element Is Enabled    ${locator}    ${TIMEOUT}
        IF  not ${enabled}
            Fail    - - El elemento ${locator} no se encuentra activo.
        END
        
    ELSE
        Fail    - - El elemento ${locator} no se encuentra visible.
    END
    
Step
    [Arguments]    ${message}
    ${step_number}    Evaluate    ${step_number} + 1
    Log To Console    Paso ${step_number} : ${message}
    Set Test Variable    ${step_number}