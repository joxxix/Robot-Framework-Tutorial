*** Settings ***
Library     RequestsLibrary

*** Keywords ***

*** Variables ***
${X-Api-Key}    NjNkYjAxN2EtODU2ZS00ZDQ3LTk2YzQtMjkyYmI5Y2MxZjVk
${get-curr-user-info-endpoint}     https://api.clockify.me/api/v1
${user-end-point}    /user
${workspace-end-point}    workspaces/${workspace-id}/member-profile/${user-id}
${get-all-workspaces-end-point}    /workspaces
${user-id}    65d893dc02c47e2ed8ec8031
${workspace-id}    641aa28840c08e2beb4bf190

*** Test Cases ***
Current User Info And Workspace Is Valid
      [Tags]    clocky
      &{headers}     Create Dictionary    X-API-KEY=${X-Api-Key}
      Log To Console    ${headers}
      Create Session   alias=my-session  url=${get-curr-user-info-endpoint}    headers=${headers}
      ${response}=    GET On Session   my-session    url=${user-end-point}  expected_status=200
      ${response}=    GET On Session    my-session    url=${get-all-workspaces-end-point}    expected_status=200

Current User Info Is Valid
      [Tags]    clocky
      &{headers}     Create Dictionary    X-API-KEY=${X-Api-Key}
      Log To Console    ${headers}
      Create Session   alias=my-session  url=${get-curr-user-info-endpoint}
      ${response}=    GET     url=${get-curr-user-info-endpoint}${user-end-point}  expected_status=200   headers=${headers}