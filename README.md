# gist-sync-action
Github action to mirror a file into a Gist

## Setup
1. Create a new public Gist (https://gist.github.com)
2. Create a token with the `gist` scope (https://github.com/settings/tokens/new)
3. Create the file you'll be syncing to your Gist

## Usage
```
on: [push]

jobs:
  gist-sync:
    name: gist-sync
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - uses: popsiclestick/gist-sync-action@v1.0.0
        id: sync
        with:
          auth_token: ${{ secrets.GIST_TOKEN }}
          auth_user: <USER_NAME>
          auth_email: <USER_EMAIL>
          gist_url: https://gist.github.com/<USER_NAME>/<GIST_ID>
          file: file-to-sync
          history: true or false
```
