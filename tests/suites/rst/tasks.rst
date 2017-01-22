Tasks Test Suite
================

This Test Suite tests basic management of the task list, like adding new tasks,
checking them as completed and unchecking them again.

.. note:: Since this is a very simple Test Suite, this file feels a little too
 "cramped" by having more documentation than necessary. But keep in mind that
 this is just a demonstration of the functionality. Having the ability to embed
 the robot Test inside documentation can be really useful in certain cases.


Settings, Variables and Suite Setup/Teardown
--------

This test suite uses the ``Selenium2Library`` to interact with the webpage and
the ``DjangoLibrary`` to manage the Django Application.

.. code:: robotframework

    *** Settings ***
    Library         Selenium2Library  timeout=10  implicit_wait=0
    Library         DjangoLibrary  ${HOSTNAME}  ${PORT}  path=../../demo  manage=../demo/manage.py  settings=demo.settings
    Suite Setup     Start Django and open Browser
    Suite Teardown  Stop Django and close Browser
    Test Teardown   Clear DB

The ``Clear DB`` Keyword is also being used as **Test Teardown** to clear DB
content between each test case.

Variables are simply addressing in which IP and Port the test server will be
listening on and what browser will be used on Selenium.

.. code:: robotframework

    *** Variables ***
    ${HOSTNAME}             127.0.0.1
    ${PORT}                 8001
    ${SERVER}               http://${HOSTNAME}:${PORT}
    ${BROWSER}              firefox

Suite Setup and Teardown are very straight-forward, too. They just open/close
the test server and the browser window.

.. code:: robotframework

    *** Keywords ***
    Start Django and open Browser
        Start Django
        Open Browser  ${SERVER}  ${BROWSER}

    Stop Django and close browser
        Close Browser
        Stop Django


Test Cases
----------


Add a New Task to the List
^^^^^^^^^^^^^^^^^^^^^^^^^^

This is the most basic test. It just adds a new task to the list and make sure
it is present with the correct name.

.. code:: robotframework

    *** Test Case ***
    Add a new Task to the List
        Given I have loaded the ToDo application page
        And the Task list is empty
        When I add a new Task named "First Task"
        Then a new Task item named "First Task" appears on the list


Mark Task as complete
^^^^^^^^^^^^^^^^^^^^^

This test clicks on a Task item that has already been created and checks if it
has been marked as complete.

The main difference between a complete task and an incomplete task is the 

.. code:: robotframework

    *** Test Case ***
    Mark Task as complete
        Given I have created a Task named "First Task"
        When I click on the "First Task" Task
        Then the "First Task" is marked is complete


Revert a Task back to incomplete
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This test clicks on a Task item that has already been marked as complete and
check if it has been marked as incomplete again.

.. code:: robotframework

    *** Test Case ***
    Revert a Task to incomplete
        Given I have created a Task named "First Task"
        And I have marked the "First Task" as complete
        When I click on the "First Task" Task
        Then the "First Task" is marked is complete


High Level Keywords
-------------------

.. note:: Notice that there are multiple ``Keywords`` tables on this file. They
   are merged on runtime, so it's not a problem. This is useful for including
   documentation text between them or to separate them in different
   documentation sections.

Those are the **High Level Keywords**, used on the Test Cases.

.. code:: robotframework

    *** Keywords ***
    I have loaded the ToDo application page
        Go To  ${SERVER}/todo
        Wait until page contains element  identifier=id_description

    the Task list is empty
        Page Should Contain  No items on your list! Start by adding one above...

The "add" button does not have an ``id`` associated with it. To refer to it,
it's better to use an **XPath** directive: ``//button[text()='add']``.

.. note:: XPath is a very valuable tool for testing things with Selenium. 
   I highly recommend learning it!

.. code:: robotframework

    *** Keywords ***
    I add a new Task named ${name}
        Input Text  identifier=id_description  ${name}
        Click Button  xpath=//button[text()='add']

    a new Task item named ${name} appears on the list
        [Teardown]  Capture Page Screenshot
        Wait until page contains element  tag=li
        Element Text Should Be  tag=li  ${name}

The ``I have created a Task named`` Keyword basically just aggregate other 4
keywords, instead of rewriting the functionality. The keywords could be used
directly on the testcases, but creating a new keyword to aggregate them made
the Tests more simple to read and understand.

.. code:: robotframework

    *** Keywords ***
    I have created a Task named ${name}
        I have loaded the ToDo application page
        the Task list is empty
        I add a new Task named ${name}
        a new Task item named ${name} appears on the list

To click on a task, it's necessary to use **XPath** again, looking for an ``a``
tag with the name of the task. Notice that the *XPath* only check if the **text
contains the name**, instead of performing an exact match. This is important
because the ``a`` tag also contains an icon in its text.

.. code:: robotframework

    *** Keywords ***
    I click on the ${name} Task
        Click Element  xpath=//a[text()[contains(., '${name}')]]

To check if an HTML element has a certain class, it's necessary to get it,
store it in an variable and check it against a Regexp. Once again, **XPath** is
used, this expression being specially tricky. It's supposed to match a ``li``
tag with an ``a`` tag inside, containing the Task name in its text.

.. code:: robotframework

    *** Keywords ***
    Check Task item class
        [Arguments]  ${name}  ${expression}
        ${classes}=  Get Element Attribute  xpath=//li[.//a[text()[contains(., '${name}')]]]@class
        Should Match Regexp  ${classes}  ${expression}

Since Selenium might take some time to detect the class change, **it's wise to
repeat the check keyword until it's successful**. To do that, there's a Built
In Keyword called ``Wait Until Keyword Succeeds`` (`Reference
<http://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Wait%20Until%20Keyword%20Succeeds>`_).

The alternative would be to include a fixed delay, but this is **a bad idea**.
This creates unnecessary delays and can make the execution of tests very slow
as the number of tests increase.
    
.. code:: robotframework

    *** Keywords ***
    the ${name} is marked is complete
        Wait Until Keyword Succeeds  5  1  Check Task item class  ${name}  .*checked

    I have marked the ${name} as complete
        I click on the ${name} Task
        the ${name} is marked is complete

    the ${name} is marked is incomplete
        Wait Until Keyword Succeeds  5  1  Check Task item class  ${name}  .*(?!checked)
