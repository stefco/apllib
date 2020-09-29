:NameSpace dll
    cpath←{⍵{⍺,⍨'dll/',⍨⍵↓⍨⎕IO+-'/'⍳⍨⌽⍵}⍺⍺.SourceFile}
:EndNameSpace
