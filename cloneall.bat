SET _ORG=<specify org name here>

gh auth login -p https -h <specify GH host here> -w

## If you have more than one GH host with the same ORG name you may want to hard code logouts for those other hosts here,
## otherwise the GH CLI may select the wrong host if you are logged into more than one.
# gh auth logout -h <specify other GH host(s) here> 

gh repo list %_ORG% --limit 1000
gh repo list %_ORG% --limit 1000 --json nameWithOwner --jq .[].nameWithOwner > repo_list.txt
for /F "tokens=1,2 delims=/" %%G in (repo_list.txt) do gh repo clone %%G/%%H || (
  Echo Repo [%%G/%%H] already exists, attempting to 'fetch' remote updates
  cd %%H && (
    git fetch --all --verbose
    cd ..
  )
)
