:NameSpace dll
    path←{
        ⍺←⍵∘,¨'' '-release' '-debug'
        ext←{'Windows'≡7↑⊃'.'⎕WG'APLVERSION': 'dll'⋄'dylib'}⍬
        p←,/↑4⌽¨('/' ⍵ '.' ext (⊃1 ⎕NPARTS ⍺⍺.SourceFile) 'dll/')∘,∘⊂¨⊆⍺
        ⊃p/⍨⎕NEXISTS¨p          
    }
:EndNameSpace


