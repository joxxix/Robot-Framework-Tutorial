*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${browser}=                chrome
${amazon-landing-page}     https://www.amazon.com

*** Keywords ***
Open Amazon.com
    Open Browser    ${amazon-landing-page}    ${browser}

Finish Test Case
    Close All Browsers

Click The Specified Element From Search Result    
    [Documentation]    Element placement starts from 1 to 60 for a page
    [Arguments]    ${element-placement}
    ${xpath-for-the-image-for-the-specific-element}=    Convert To String    //div[@class='s-widget-container s-spacing-small s-widget-container-height-small celwidget slot=MAIN template=SEARCH_RESULTS widgetId=search-results_${element-placement}']
    Wait Until Element Is Visible    ${xpath-for-the-image-for-the-specific-element}
    Click Element    (//div[@data-component-type='s-search-result'])[${element-placement}]//div[@class='a-section aok-relative s-image-square-aspect']
