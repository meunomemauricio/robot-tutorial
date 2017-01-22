*** Settings ***
Documentation   Tests the process of adding and removing tasks from the list.
Library         Selenium2Library  timeout=10  implicit_wait=0
Library         DjangoLibrary  ${HOSTNAME}  ${PORT}  path=../../demo  manage=../demo/manage.py  settings=demo.settings
Suite Setup     Start Django and open Browser
Suite Teardown  Stop Django and close Browser
Test Teardown   Clear DB

*** Variables ***
${HOSTNAME}             127.0.0.1
${PORT}                 8001
${SERVER}               http://${HOSTNAME}:${PORT}
${BROWSER}              firefox


*** Keywords ***
Start Django and open Browser
    Start Django
    Open Browser  ${SERVER}  ${BROWSER}

Stop Django and close browser
    Close Browser
    Stop Django

Load the ToDo application page
    Go To  ${SERVER}/todo
    Wait until page contains element  identifier=id_description

Make sure the list is empty
    Page Should Contain  No items on your list! Start by adding one above...

Add new Task named
    [Arguments]  ${name}
    Input Text  identifier=id_description  ${name}
    Click Button  xpath=//button[text()='add']

Check if there is a Task named
    [Arguments]  ${name}
    [Teardown]  Capture Page Screenshot
    Wait until page contains element  tag=li
    Element Text Should Be  tag=li  ${name}

Click on Task
    [Arguments]  ${name}
    Click Element  xpath=//a[text()[contains(., '${name}')]]

Mark Task as complete
    [Arguments]  ${name}
    Click on Task  ${name}

Mark Task as incomplete
    [Arguments]  ${name}
    Click on Task  ${name}

Check Task item class
    [Arguments]  ${name}  ${expression}
    ${classes}=  Get Element Attribute  xpath=//li[.//a[text()[contains(., '${name}')]]]@class
    Should Match Regexp  ${classes}  ${expression}

Check if Task is marked as complete
    [Arguments]  ${name}
    Wait Until Keyword Succeeds  5  1  Check Task item class  ${name}  .*checked

Check if Task is marked as incomplete
    [Arguments]  ${name}
    Wait Until Keyword Succeeds  5  1  Check Task item class  ${name}  .*(?!checked)

*** Test Cases ***
Add a new Task to the List
    Load the ToDo application page
    Make sure the list is empty
    Add new Task named  "First Task"
    Check if there is a Task named  "First Task"

Mark Task as complete
    Load the ToDo application page
    Add new Task named  "First Task"
    Check if there is a Task named  "First Task"
    Click on Task  "First Task"
    Check if Task is marked as complete  "First Task"

Revert a Task to incomplete
    Load the ToDo application page
    Add new Task named  "First Task"
    Check if there is a Task named  "First Task"
    Click on Task  "First Task"
    Check if Task is marked as complete  "First Task"
    Click on Task  "First Task"
    Check if Task is marked as incomplete  "First Task"
