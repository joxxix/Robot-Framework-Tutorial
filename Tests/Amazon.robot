*** Settings ***
Library     SeleniumLibrary
Library     Dialogs
Library     String
Resource    ../PageObjects/AmazonCommons.robot
Variables   ../Locators/AmazonLocators.py
Test Teardown    AmazonCommons.Finish Test Case

*** Variables ***
# PDP = product display page
${xpath-for-quantity-select}    //div[@id='selectQuantity']
${xpath-for-second-quantity-from-dropdown-menu}    //li[@aria-labelledby='quantity_1']
${xpath-for-set-quantity-drop-down}    //span[@class='a-button a-button-dropdown']//span[@class='a-dropdown-prompt']
${xpath-for-add-to-cart-button-in-PDP}    //input[@id='add-to-cart-button']
# successfully added to cart page
${xpath-for-go-to-cart}    //span[@class='a-button a-spacing-top-base a-button-span12 a-button-base celwidget']//span[@class='a-button-inner']

# cart page
${xpath-for-price-of-the-first-item}    (//span[@class='a-size-medium a-color-base sc-price sc-white-space-nowrap sc-product-price a-text-bold'])[1]
${xpath-for-price-of-the-second-item}    (//span[@class='a-size-medium a-color-base sc-price sc-white-space-nowrap sc-product-price a-text-bold'])[2]
${xpath-for-subtotal-price}    //span[@id='sc-subtotal-amount-activecart']
${xpath-for-quantity-of-the-first-item}    (//span[@class='a-button-text a-declarative'])[1]//span[@class='a-dropdown-prompt']
${xpath-for-quantity-of-the-second-item}   (//span[@class='a-button-text a-declarative'])[2]//span[@class='a-dropdown-prompt']
# this xpath is seen once you click on the quantity drop down else it is not found
${xpath-for-quantity-1-from-drop-down-menu}    //li[@aria-labelledby='quantity_1']//a[@id='quantity_1']

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
    AmazonCommons.Search For An Item    hats for men
    
    AmazonCommons.Click The Specified Element From Search Result    1
    # click on quantity change to two
    # clicking on quantity and change it to 2
    AmazonCommons.Set Quantity Of The Item To 2

    # click on add to cart button
    AmazonCommons.Add Item To Cart

    # step 4
    # go to cart from 'go to cart' button on success page
    Wait Until Element Is Visible    ${xpath-for-go-to-cart}
    Click Element    ${xpath-for-go-to-cart}

    # verify that the quantity and the price are correct
    # get price of item -> times it by the quantity and then compare to subtotal
    ${price-var-str}    Get Text    ${xpath-for-price-of-the-first-item}
    ${price-var-str}    Remove String    ${price-var-str}    $
    ${price-var-num}    Convert To Number    ${price-var-str}

    ${subtotal-price-str}    Get Text    ${xpath-for-subtotal-price}
    ${subtotal-price-str}    Remove String    ${subtotal-price-str}    $
    ${subtotal-price-num}    Convert To Number    ${subtotal-price-str}

    # ${quantity}    Get Text   ${xpath-for-quantity-of-the-first-item}

    ${actual-price-times-quantity}    Evaluate    ${price-var-num} * 2
    Should Be Equal As Numbers    ${actual-price-times-quantity}    ${subtotal-price-num}

    # step 5
    # search for hats for women from the cart
    Input Text    ${xpath-for-search-bar-from-landingpage}    hats for women
    Click Button    ${xpath-for-search-submit-button}

    # step 6
    # click on first item and then click on add to cart button (this will add the item with quantity of 1)
    AmazonCommons.Click The Specified Element From Search Result    1

    Wait Until Element Is Visible  ${xpath-for-add-to-cart-button-in-PDP}
    Click Button    ${xpath-for-add-to-cart-button-in-PDP}

    # step 7
    # verify that item was added to cart
    Location Should Contain    amazon.com/cart
    Wait Until Element Is Visible    //h1[normalize-space()='Added to Cart']

    # go to cart from 'go to cart' button on success page
    Wait Until Element Is Visible    ${xpath-for-go-to-cart}
    Click Element    ${xpath-for-go-to-cart}

    # subtotal price should be changed to the new one
    ${subtotal-price-str}    Get Text    ${xpath-for-subtotal-price}
    ${subtotal-price-str}    Remove String    ${subtotal-price-str}    $
    ${subtotal-price-num}    Convert To Number    ${subtotal-price-str}

    # and we need to add the new item's price to the actual-primes-times-quantity
    ${price-var-str}    Get Text    ${xpath-for-price-of-the-first-item}
    ${price-var-str}    Remove String    ${price-var-str}    $
    ${price-var-num}    Convert To Number    ${price-var-str}

    ${actual-price-times-quantity}    Evaluate    ${price-var-num} + ${actual-price-times-quantity}
    Should Be Equal As Numbers    ${actual-price-times-quantity}    ${subtotal-price-num}

    # step 8
    # remove quantity from the second item and make it 1
    Wait Until Element Is Visible    ${xpath-for-quantity-of-the-second-item}
    Click Element    ${xpath-for-quantity-of-the-second-item}
    Wait Until Element Is Visible    ${xpath-for-quantity-1-from-drop-down-menu}    10s
    Click Element    ${xpath-for-quantity-1-from-drop-down-menu}  
    # this sleep is here beacuse it takes some time for amazon to update the subtotal after quantity change
    Sleep    5s

    # verify that the price has changed
    ${subtotal-price-str}    Get Text    ${xpath-for-subtotal-price}
    ${subtotal-price-str}    Remove String    ${subtotal-price-str}    $
    ${subtotal-price-num}    Convert To Number    ${subtotal-price-str}

    ${price-first-item-var-str}    Get Text    ${xpath-for-price-of-the-first-item}
    ${price-first-item-var-str}    Remove String    ${price-first-item-var-str}    $
    ${price-first-item-var-num}    Convert To Number    ${price-first-item-var-str}

    ${price-second-item-var-str}    Get Text    ${xpath-for-price-of-the-second-item}
    ${price-second-item-var-str}    Remove String    ${price-second-item-var-str}    $
    ${price-second-item-var-num}    Convert To Number    ${price-second-item-var-str}

    ${actual-price-times-quantity}    Evaluate    ${price-first-item-var-num} + ${price-second-item-var-num}
    Should Be Equal As Numbers    ${actual-price-times-quantity}    ${subtotal-price-num}

Buy 2 hats from amazon/404
        [Tags]    skip
        Open Browser    https://www.amazon.com/404   chrome
        Input Text    //input[@id='f']    hats for men
        Click Button    //input[@id='g']