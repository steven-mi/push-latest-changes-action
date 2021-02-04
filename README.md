# Push Latest Changes Action
This action pushes the latest changes from one repository to another. You can:
- select the branch
- ignore files

## Example usage


uses: actions/push-changes-actionn@v1
with:
  github-token: ${{ secrets.GITHUB_TOKEN }}
  repository: TARGET_REPOSITORY_NAME
  owner: TARGET_REPOSITORY_OWNER_NAME