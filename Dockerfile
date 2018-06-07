FROM microsoft/nanoserver

ENV NODE_VERSION="8.9.1" \
    NODE_SHA256="db89c6e041da359561fbe7da075bb4f9881a0f7d3e98c203e83732cfb283fa4a"

WORKDIR C:/

RUN powershell -Command Invoke-WebRequest -OutFile node-v8.9.1-win-x64.zip "https://nodejs.org/dist/v$($env:NODE_VERSION)/node-v8.9.1-win-x64.zip" -UseBasicParsing; \
    if ((Get-FileHash node-v8.9.1-win-x64.zip -Algorithm sha256).Hash -ne $env:NODE_SHA256) {exit 1} ;

RUN powershell -Command Expand-Archive -Path C:/node-v8.9.1-win-x64.zip -DestinationPath C:/ \
    && powershell -Command Rename-Item -Path node-v8.9.1-win-x64 -NewName node

RUN powershell -Command Add-Content -Path $Profile.AllUsersAllHosts -Value '$env:Path = $env:Path + \";C:\node\"'

CMD ["node.exe", "-v"]
