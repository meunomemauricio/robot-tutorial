*** Settings ***
Documentation   Tests the process of adding and removing tasks from the list.
...             This test suite implements the same exact tests as the other
...             one, but using the Gherkin language.
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

I have loaded the ToDo application page
    Go To  ${SERVER}/todo
    Wait until page contains element  identifier=id_description

the Task list is empty
    Page Should Contain  No items on your list! Start by adding one above...

I add a new Task named ${name}
    Input Text  identifier=id_description  ${name}
    Click Button  xpath=//button[text()='add']

a new Task item named ${name} appears on the list
    [Teardown]  Capture Page Screenshot
    Wait until page contains element  tag=li
    Element Text Should Be  tag=li  ${name}

I have created a Task named ${name}
    I have loaded the ToDo application page
    the Task list is empty
    I add a new Task named ${name}
    a new Task item named ${name} appears on the list

I click on the ${name} Task
    Click Element  xpath=//a[text()[contains(., '${name}')]]

Check Task item class
    [Arguments]  ${name}  ${expression}
    ${classes}=  Get Element Attribute  xpath=//li[.//a[text()[contains(., '${name}')]]]@class
    Should Match Regexp  ${classes}  ${expression}

the ${name} is marked is complete
    Wait Until Keyword Succeeds  5  1  Check Task item class  ${name}  .*checked

I have marked the ${name} as complete
    I click on the ${name} Task
    the ${name} is marked is complete

the ${name} is marked is incomplete
    Wait Until Keyword Succeeds  5  1  Check Task item class  ${name}  .*(?!checked)


*** Test Cases ***
Add a new Task to the List
    Given I have loaded the ToDo application page
    And the Task list is empty
    When I add a new Task named "First Task"
    Then a new Task item named "First Task" appears on the list

Mark Task as complete
    Given I have created a Task named "First Task"
    When I click on the "First Task" Task
    Then the "First Task" is marked is complete

Revert a Task to incomplete
    Given I have created a Task named "First Task"
    And I have marked the "First Task" as complete
    When I click on the "First Task" Task
    Then the "First Task" is marked is complete
