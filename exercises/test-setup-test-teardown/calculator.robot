*** Settings ***
Resource    common.resource

Suite setup       Start Mint Calendar
Test teardown     Clear screen
Suite teardown    Close All Applications

*** Test Cases ***
Add 7 and 9 in the calculator
    Click element    accessibility_id=7
    Click element    accessibility_id=+
    Click element    accessibility_id=9
    Click element    accessibility_id==
    Element Should Contain Text    //android.widget.EditText    16

Multiply 5 and 4 in the calculator
    Click element    accessibility_id=5
    Click element    accessibility_id=×
    Click element    accessibility_id=4
    Click element    accessibility_id==
    Element Should Contain Text    //android.widget.EditText    20