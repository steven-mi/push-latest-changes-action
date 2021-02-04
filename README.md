# Push Latest Changes Action
This action pushes the latest changes from one repository to another.

## Example usage

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
        uses: steven-mi/push-latest-changes-action@v1
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }} # Token for the repo
          repository: test1 # Destination repisitory to push changes
          branch: main # Branch to push changes to
          force: false # Enable force push
          directory: "." # A list of files to be ignored as a comma-separated string e.g. ".hallo,.bye"
          ignore: ""
```
