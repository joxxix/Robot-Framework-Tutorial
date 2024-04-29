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
    ${xpath-for-the-image-for-the-specific-element}=    Convert To String    //div[@class='s-widget-container s-spacing-small s-widget-container-height-small celwidget slot=MAIN template=SEARCH_RESULTS widgetId=search-results_${element-placement}']//div[@class='s-product-image-container aok-relative s-text-center s-image-overlay-grey puis-image-overlay-grey s-padding-left-small s-padding-right-small puis-spacing-small s-height-equalized puis puis-vdxk37aq8336s2lo8m9ejy9mry']
    Wait Until Element Is Visible    ${xpath-for-the-image-for-the-specific-element}
    Click Element    ${xpath-for-the-image-for-the-specific-element}
