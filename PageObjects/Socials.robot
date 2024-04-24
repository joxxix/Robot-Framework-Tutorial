*** Settings ***
Library     SeleniumLibrary
Variables   ../Locators/Socials.py

*** Variables ***
${ggbg-facebook-page}      https://www.facebook.com/ggbg.bg1/
${ggbg-window-title}       GGBG.bg - Tранспорт и доставка на покупки и пратки от онлайн магазини в Англия, Германия, Испания и САЩ до България

*** Keywords ***
does socials redirect
    click element    ${facebookPageButton}
    @{windows-handles}  get window handles

    # switches to the first window of the browser and verifies if the title of the window is the one of GGBG
    switch window    ${windows-handles}[0]
    wait until element is visible    ${ggbglogoelement}
    title should be    ${ggbg-window-title}

    # switches to the second window and verifies if the url of the page is the one for GGBG's facebook page
    switch window    ${windows-handles}[1]
    wait until element is visible    ${facebookLogo}
    location should be    ${ggbg-facebook-page}

