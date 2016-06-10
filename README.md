#### Building
##### Stack
Install stack, follow the instructions here:
[http://docs.haskellstack.org/en/stable/install\_and\_upgrade/](http://docs.haskellstack.org/en/stable/install_and_upgrade/)

##### Prepare stack for this application
`stack setup`

##### Build this application
`stack build`

#### Running
`stack exec alpha-words-exe <path-to-dictionary> <string-of-characters>`

Example: `stack exec alpha-words-exe /usr/share/dict/words foobar`

Launching without string-of-characters will start an interactive mode,
preferably started with rlwrap

`rlwrap stack exec alpha-words-exe`

If no dictionary is given, it will default to the one in the previous example
`/usr/share/dict/words`

To visualize words based on a prioritized subset, input available characters as
"&lt;prioritized&gt; &lt;rest&gt;" and a second column will contain words that
will use all prioritized characters. This is useful if you really want to use
some word ASAP, maybe they are worth more or disappear the next round. If you
for example have the characters `fooar` and really want to use `f` and `o`,
input `fo oar` and the result will be something like this in interactive mode:
<table style="width:100%">
  <tr><td> fro  </td><td> fro  </td></tr>
  <tr><td> oaf  </td><td> oaf  </td></tr>
  <tr><td> oar  </td><td>      </td></tr>
  <tr><td> fora </td><td> fora </td></tr>
  <tr><td> roof </td><td> roof </td></tr>
</table>
