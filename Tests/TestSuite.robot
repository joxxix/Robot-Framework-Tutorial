*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Resource    ../PageObjects/LoginPage.robot
Resource    ../PageObjects/Socials.robot

*** Keywords ***

*** Variables ***
${browser}=                chrome

*** Test Cases ***
Sample Webdriver
        [Tags]  wd0
        [Documentation]  Sample invocation using WD
        open browser    https://www.facebook.com/   ${browser}
        close all browsers

Basic Search
    [Tags]    wd2
    [Documentation]    This test case verifies the basic search
    # Opens browser and goes to the english ebay site
    open browser    https://www.ebay.co.uk/
    # Waits until the searchbar is visible
    wait until element is visible    //input[@id='gh-ac']       10
    # Inputs the word "Mobile" into the searchbar
    input text    //input[@id='gh-ac']      Mobile
    # Clicks on the search button
    click element    //input[@id='gh-btn']
    # This keyword is searching for a message (results for Mobile) in a specific element
    page should contain element    //h1[@class='srp-controls__count-heading']    results for Mobile
    # Another possible keyword that verifies if the text "results for Mobile" exists
    # on the redirect page ⌄
    #page should contain    results for Mobile
    close browser

Get Specifc Atribute Name
    [Tags]      wd2
    open browser    https://www.ebay.co.uk/
    wait until element is visible    //input[@id='gh-ac']       10
    input text    //input[@id='gh-ac']      Mobile
    click element    //input[@id='gh-btn']

    ${id}=   get text    //*[@id="mainContent"]/div[1]/div/div[1]/div[1]/div[1]/h1/span[2]
    log    The thing I was searching for was: ${id}
    should not be equal    //*[@class='srp-controls__count-heading']/span[2]     Mobile
    close browser

Quick Get Request Test
      [Tags]    back
      ${response}=    GET  https://www.google.com

Quick Get Request With Parameters Test
      [Tags]    back
      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200