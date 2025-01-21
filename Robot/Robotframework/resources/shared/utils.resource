*** Settings ***
Library     String
Library     SeleniumLibrary

*** Variables ***
${screenshot}    0
${TEST_DATA}
${GENERAL_MENU}
${GENERAL_SUBMENU}

*** Keywords ***
Highlight
    [Documentation]    Highlight an element on the page using default values.
    [Arguments]
    ...                     ${locator}
    ...                     ${duration}=400ms
    ...                     ${width}=4px
    ...                     ${style}=solid
    ...                     ${color}=red
    Highlight Elements      ${locator}
    ...                     ${duration}
    ...                     ${width}
    ...                     ${style}
    ...                     ${color}

Capture Image Evidence
    [Documentation]    Capture an image of the current page and save it in the output directory
    ${image_dir}=    Get Variable Value    $IMAGE_DIR    ${OUTPUT_DIR}/image
    ${screenshot}=    Evaluate    ${screenshot} + 1
    Set Test Variable    ${screenshot}
    Capture Page Screenshot    ${image_dir}/evidence_${screenshot}

Step
    [Arguments]             ${description}
    [Documentation]    Log a step in the console and in the log
    ${step}=    Get Variable Value    $STEP    0
    ${step}=    Evaluate    ${step} + 1
    Set Test Variable    $STEP    ${step}
    ${datetime}=    Get Time
    ${message}=    Format String
    ...                     {} - STEP {:>3} - {}
    ...                     ${datetime}
    ...                     ${STEP}
    ...                     ${description}
    Log    ${message}    console=${TRUE}

Log Console And Log
    [Documentation]
    ...    Allow us to enter a message both in console and in the log
    [Arguments]    ${message}
    ${timestamp}=    Get Time
    Log    ${message}
    Log To Console    ${timestamp} -- ${message}

Replace values in locator
    [Arguments]    ${old_locator}    ${option}
    ${locator} =	Replace String    string=${old_locator}    search_for=value    replace_with=${option}
    Set Test Variable    ${locator}
    RETURN    ${locator}