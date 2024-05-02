*** Settings ***
Library    SeleniumLibrary
Variables  ../Locators/AmazonLocators.py

*** Variables ***
${browser}=                chrome
${amazon-landing-page}     https://www.amazon.com
${amazon-cart-page}        amazon.com/cart

#text
${xpath-for-added-to-cart-success-text}    //h1[normalize-space()='Added to Cart']

# landing page
${xpath-for-search-bar-from-landingpage}    //input[@id='twotabsearchtextbox']
${xpath-for-search-submit-button}    //input[@id='nav-search-submit-button']

# PDP = product display page
${xpath-for-quantity-select}    //div[@id='selectQuantity']
${xpath-for-second-quantity-from-dropdown-menu}    //li[@aria-labelledby='quantity_1']
${xpath-for-set-quantity-drop-down}    //span[@class='a-button a-button-dropdown']//span[@class='a-dropdown-prompt']
${xpath-for-add-to-cart-button-in-PDP}    //input[@id='add-to-cart-button']

# successfully added to cart page
${xpath-for-go-to-cart-button}    //span[@class='a-button a-spacing-top-base a-button-span12 a-button-base celwidget']//span[@class='a-button-inner']


*** Keywords ***
Open Amazon.com
    Open Browser    ${amazon-landing-page}    ${browser}

Finish Test Case
    Close All Browsers

#Landing page
Click The Specified Element From Search Result    
    [Documentation]    Element placement starts from 1 to 60 for a page
    [Arguments]    ${element-placement}
    ${xpath-for-the-image-for-the-specific-element}=    Convert To String    //div[@class='s-widget-container s-spacing-small s-widget-container-height-small celwidget slot=MAIN template=SEARCH_RESULTS widgetId=search-results_${element-placement}']
    Wait Until Element Is Visible    ${xpath-for-the-image-for-the-specific-element}
    Click Element    (//div[@data-component-type='s-search-result'])[${element-placement}]//div[@class='a-section aok-relative s-image-square-aspect']

Search For An Item
    [Documentation]    Search for item with text given in arguments section. Sometimes the xpath for the searchbar is different on some pages
    [Arguments]    ${input-text}
    Input Text    ${xpath-for-search-bar-from-landingpage}    ${input-text}
    Click Button    ${xpath-for-search-submit-button}

#PDP
Set Quantity Of The Item To 2
    [Documentation]    Selects the quantity of the item and sets it to two
    Wait Until Element Is Visible    ${xpath-for-quantity-select}
    Click Element    ${xpath-for-quantity-select}

    # changing value to 2
    Wait Until Element Is Visible    ${xpath-for-second-quantity-from-dropdown-menu}
    Click Element    ${xpath-for-second-quantity-from-dropdown-menu}
        
    # verify that quantity has changed
    Wait Until Element Is Visible     ${xpath-for-set-quantity-drop-down}
    Element Text Should Be  ${xpath-for-set-quantity-drop-down}    2

Add Item To Cart
    [Documentation]    Adds the current item to cart, by clicking the 'Add to Cart' button
    Wait Until Element Is Visible  ${xpath-for-add-to-cart-button-in-PDP}
    Click Button    ${xpath-for-add-to-cart-button-in-PDP}

    # verify that "Added to Cart" text exists and that you are on amazon.com/cart
    Location Should Contain    ${amazon-cart-page}
    Wait Until Element Is Visible    ${xpath-for-added-to-cart-success-text}
