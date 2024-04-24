*** Settings ***
Library     SeleniumLibrary
Resource    ../PageObjects/LoginPage.robot
Resource    ../PageObjects/Socials.robot

*** Keywords ***

*** Variables ***
${ggbg-home-page}=         https://www.ggbg.bg/bg/
${username}=               joxxixmv@gmail.com
${password}=               Kurvibelo123
${invalid-password}=       password
${browser}=                chrome

*** Test Cases ***
Positive Login Into GGBG
    [Tags]      ggbg    positive
    [Documentation]     This is a positive test case for Login into GGBG
    open browser    ${ggbg-home-page}   ${browser}
    LoginPage.login into GGBG   ${username}     ${password}
    close browser

Negative Login Into GGBG
    [Tags]    ggbg      negative
    [Documentation]     This is a negative test case for Login into GGBG
    open browser    ${ggbg-home-page}   ${browser}
    LoginPage.fail to login into GGBG   ${username}    ${invalid-password}
    close browser

Does Socials Button Redirect To Facebook
    [Tags]     ggbg     home
    [Documentation]     This is a test case where I click on the facebook logo on the top-nav bar, and I should be redirected to the facebook page of GGBG
    open browser        ${ggbg-home-page}   ${browser}
    Socials.does socials redirect
    Close Browser