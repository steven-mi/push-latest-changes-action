# Push Latest Changes Action
With this simple GitHub action, you can easily push the latest changes from one repository to the other. Furthermore, you can ignore certain files, allowing open sourcing of projects without sharing the credentials.

## Getting Started
First generate a personal access token by going to your **Developer settings**. Next, add your PAT as a secret to your repository and create a GitHub action with the following content:

```
name: Push Latest Changes 

on:
  push
    
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Push Latest Changes
        uses: steven-mi/push-latest-changes-action@v1.0
        with:
          github-token: ${{ secrets.PAT }} # generated PAT token
          repository: test1 # Destination repisitory to push changes
          branch: main # Branch to push changes to
          force: false # Enable force push
          directory: "." # Directory to push changes to
          ignore: "" # A list of files to be ignored as a comma-separated string e.g. ".hallo,.bye"
```

**Note:** Make sure that your PAT allows write access to your repository

## License
Apache License 2.0 see [LICENSE](LICENSE)
