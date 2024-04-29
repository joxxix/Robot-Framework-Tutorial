*** Settings ***
Library     SeleniumLibrary
Library     Dialogs
Resource    ../PageObjects/AmazonCommons.robot
Variables   ../Locators/AmazonLocators.py
Test Teardown    AmazonCommons.Finish Test Case

*** Variables ***
${xpath-for-search-bar-from-landingpage}    //input[@id='twotabsearchtextbox']
${xpath-for-search-submit-button}    //input[@id='nav-search-submit-button']
${xpath-for-quantity-select}    //div[@id='selectQuantity']
${xpath-for-second-quantity-from-dropdown-menu}    //li[@aria-labelledby='quantity_1']
${xpath-for-set-quantity}    //span[@class='a-button a-button-dropdown']//span[@class='a-dropdown-prompt']
# PDP = product display page
${xpath-for-add-to-cart-button-in-PDP}    //input[@id='add-to-cart-button']

*** Keywords ***


*** Test Cases ***
Buy 2 hats from amazon.com
    [Tags]    amazon
    [Documentation]    
    ...    The point of this test case is to automate this scenario 
    ...    Go to amazon.com and search for "hats for men",
    ...    add the first hat to the cart with quantity of 2
    ...    search for "hats for women", add the first hat to the cart with quantity of 1,
    ...    change the quantity to 1 for the men's hat
    ...    verify that all the steps are done as specified
    # step 1
    AmazonCommons.Open Amazon.com
    # step 2
    Execute Manual Step    Please do the CAPTCHA and press PASS when you are done. Pressing Fail will close the browser and fail the test.
    # ⌄ This will be automatically added to the field box for failure ⌄
    ...    Captcha was too hard!
    # step 3
    # search for "hats for men"
    Input Text    ${xpath-for-search-bar-from-landingpage}    hats for men
    Click Button    ${xpath-for-search-submit-button}
    
    AmazonCommons.Click The Specified Element From Search Result    1
    # click on quantity change to two
    # clicking on quantity
    Wait Until Element Is Visible    ${xpath-for-quantity-select}
    Click Element    ${xpath-for-quantity-select}
    # changing value to two
    Wait Until Element Is Visible    ${xpath-for-second-quantity-from-dropdown-menu}
    Click Element    ${xpath-for-second-quantity-from-dropdown-menu}
    # verify that quantity has changed
    Wait Until Element Is Visible     ${xpath-for-set-quantity}
    Element Text Should Be  ${xpath-for-set-quantity}    2
    # click on add to cart button
    Wait Until Element Is Visible  ${xpath-for-add-to-cart-button-in-PDP}
    Click Button    ${xpath-for-add-to-cart-button-in-PDP}
    # verify that "Added to Cart" text exists and that you are on amazon.com/cart
    Location Should Contain    amazon.com/cart
    Wait Until Element Is Visible    //h1[normalize-space()='Added to Cart']
    # step 4

Buy 2 hats from amazon/404
        [Tags]    skip
        Open Browser    https://www.amazon.com/404   chrome
        Input Text    //input[@id='f']    hats for men
        Click Button    //input[@id='g']