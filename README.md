#### Building
##### Stack
Install stack, follow the instructions here:
http://docs.haskellstack.org/en/stable/install_and_upgrade/

##### Prepare stack for this application
`stack setup`

##### Build this applications
`stack build`

#### Running
`stack exec alpha-words-exe <path-to-dictionary> <string-of-characters>`

Example: `stack exec alpha-words-exe /usr/share/dict/words foobar`
