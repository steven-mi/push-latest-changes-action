# Push Latest Changes Action
This action pushes the latest changes from one repository to another. You can:
- select the branch
- ignore files

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
      - uses: steven-mi/push-latest-changes-action@v0.1
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          repository: test1
          owner: steven-mi
```