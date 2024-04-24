*** Settings ***
Library     SeleniumLibrary
Variables   ../Locators/LoginPage.py

*** Variables ***
${user-details-in-BG}      ЛИЧНИ ДАННИ
${invalid-email-or-password-message-in-BG}      Невалиден e-mail или парола

*** Keywords ***
click login/register
    wait until element is visible    ${loginRegisterButton}
    click element                    ${loginRegisterButton}

input email into login forum
    [Arguments]     ${username}
    wait until element is visible    ${emailInputForLogin}
    input text                       ${emailInputForLogin}        ${username}

input password into login forum
    [Arguments]     ${password}
    wait until element is visible    ${passwordinputforlogin}
    input password                   ${passwordinputforlogin}     ${password}

verify that login was succesful
    wait until element is visible        ${userdetailstitletext}
    ${var-user-details}=  get text       ${userdetailstitletext}
    should be equal                      ${user-details-in-BG}    ${var-user-details}

input false password into password forum
    [Arguments]     ${falsePassword}
    wait until element is visible    ${passwordinputforlogin}
    input password                   ${passwordinputforlogin}     ${falsePassword}

verify that login was not succesful
    wait until element is visible                 ${invalidEmailOrPasswordMessage}
    ${var-fail-to-login-message}=  get text       ${invalidEmailOrPasswordMessage}
    should be equal                               ${invalid-email-or-password-message-in-BG}    ${var-fail-to-login-message}

login into GGBG
    [Documentation]     this is a test case that logs you into GGBG
    [Arguments]     ${emailInput}     ${passwordInput}
    # click login
    click login/register

    # input email
    input email into login forum    ${emailInput}

    # input password
    input password into login forum     ${passwordInput}

    # click login button
    click element    ${loginButton}

    # verify that you are redirected to your profile page
    verify that login was succesful

fail to login into GGBG
    [Documentation]     this is a test case that fails to log you into GGBG, by inputing an invalid password
    [Arguments]     ${emailInput}   ${invalidPasswordInput}
    click login/register

    input email into login forum    ${emailInput}

    input false password into password forum    ${invalidPasswordInput}

    click element    ${loginbutton}

    verify that login was not succesful