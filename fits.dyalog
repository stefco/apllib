:Namespace fits
⍝ === VARIABLES ===

    fitstypes←'LXBIJKAEDCMPQ'

    fitstypesizes←(3/1),2 4 8 1 4 8 8 16 8 16


⍝ === End of variables definition ===

    (⎕IO ⎕ML ⎕WX)←0 1 3

      binfields←{
          r←⍵∘readhead
          i←'TFORM' 'TTYPE' 'TUNIT'∘.,⍕¨1+⎕IO-⍨⍳r'TFIELDS'
          {
              (2↑⍵),{
                  b←fitstypesizes[fitstypes⍳⊃1↓⍵]
                  ⍵,⍨(+\b×¯1↓0,⊃⍵)b
              }↓⍉↑coltype¨↓⊃2↓⍵
          }¯1⌽{
              ⍵/⍨∨⌿~∨\' '=⍵
          }¨(⊂↑(8↑¨2⌷i){
              ⍺{
                  ⍵\↑r ⍺/⍨⍵
              }⍺∊↓1⊃⍵
          }⍵),↑∘↑¨r¨↓2↑i
      }

    binmap←{(mapshape ⍵)⎕MAP ⍺'r'(+/2↑⊃⍵)}

      coltype←{
          {
              ≢⍵:⊃⍵
              'Invalid type specification'⎕SIGNAL 6
          }(('^ *(\d*)[',fitstypes,'] *$')⎕S{
              ⍵.Match{d t←⍵ ⋄ ({0=t:1 ⋄ ⍎t↑d↓⍵}⍺)(⊃⍺↓⍨d+t)}⍵.(,1↓Offsets,⍪Lengths)
          })⍵
      }

      fitsdr←{
          bigr←{⊃83 ⎕DR 256:⍵ ⋄ ⌽⍵}    ⍝ reverse if not big-endian
          out←(⍴,⍺)⍴⊂⍬
          dmax dmin←{645⎕DR⌽83⎕DR⍵}¨,∘(¯10⌽0,62⍴1)¨0 1
          kinf kninf←323⎕DR¨,∘(63↑11⍴1)¨0 1
          _←⍵{
              out[⍵]←⍺{
                  ⍺='L':0=⍵
                  ⍺='X':11 ⎕DR ⍵
                  ⍺='B':2⊥⍵⊤⍨8⍴2     ⍝ might reshape to int16 for ⍵>127
                  ⍺∊'IJM':bigr 163 323 1289['IJM'⍳⍺]⎕DR bigr ⍵
                ⍝⍺='K':{⍵+⍺×2*32}/{⍵{⍺⍴⍨(¯1↓⍵),(2÷⍨¯1↑⍵),2}⍴⍵}(2*32)|bigr 323 ⎕DR bigr ⍵
                  ⍺='K':{⍉↑256⊥¨256|⍉¨⍵⊂⍨(8↑1)⍴⍨⊃¯1↑⍴⍵}⍵
                  ⍺='A':80 ⎕DR ⍵
                  ⍺='E':'32-bit floating point not yet supported.'⎕SIGNAL 6
                  ⍺='D':{
                      11::{
                       ⍝ FIXME handle domain error
                          bigr ⍵
                      }⍵
                      bigr 645 ⎕DR bigr ⍵
                  }⍵
                  ⍺='C':'32-bit complex not yet supported.'⎕SIGNAL 6
                  ⍺='P':'32-bit array descriptor not yet supported.'⎕SIGNAL 6
                  ⍺='Q':'64-bit array descriptor not yet supported.'⎕SIGNAL 6
                  ('Unrecognized fits type: ',⍺)⎕SIGNAL 6
              }¨,⍺⍺[⍵]
              ⍬
          }⌸,⍺
          out
      }

      headers←{
          p←⊂'^ {80}()()$'                                               ⍝ blank line
          p,←⊂'^END {77}()()$'                                            ⍝ end of header
          p,←⊂'^COMMENT .*()()$'                                          ⍝ comments
          p,←⊂'^HISTORY .*()()$'                                          ⍝ history
          p,←⊂'^..{7}= *''((?:[^'']|'''')*)[^/]*/? *(.*)$'                ⍝ strings
          p,←⊂'^..{7}= *[+-]?(\d+(?:\.\d*)?(?:[eEdD]\d*)?)[^/]*/? *(.*)$' ⍝ numbers
          p,←⊂'^..{7}= *([TF])[^/]*/? *(.*)$'                             ⍝ bools
          p,←⊂'^()()'                                                     ⍝ error
          lit←{⍵[⎕IO+1]{⍵[⎕IO+1]↑⍵[⎕IO]↓⍺}¨↓3 2⍴1↓⊃⍵}
          0(0 10⍴⍬){
              (⊃⍺)≥×/⍴⍵:⊃1↓⍺
              h←(0 4⍴⍬){
                  r←⍺⍪↑(p ⎕S{⍵.(PatternNum,¯1↓,1↓Offsets,⍪Lengths)})↓36↑⍵↓⍨⊃⍴⍺
                  t←⎕IO⌷⍉r
                  1∊¯36↑t:{
                      7∊t:('Unrecognized metadata format: ',∊'→ '∘,¨⍵/⍨t=7)⎕SIGNAL 6
                      i c l←⍵{↑¨(↑∨/⍵)∘/¨¨⍵(↓1↓⍉r)(↓⍺)}t∘=¨4 5 6+⎕IO
                      (80×⍴t)(↑8↑¨l)({
                          ⍵/⍨∨⌿~⌽∧\⌽' '=⍵
                      }↑c[⎕IO+2;]↓¨l)(5+1⍳¨⍨↓⍉i)(1-⍨⎕IO++⌿i×+\i),({
                          ({⍵/⍨(⍵≠'''')∨2|⍳⍴⍵}¨⍵/⍨⎕IO⌷i)(⍎¨⍵/⍨i⌷⍨⎕IO+1)(∊'T'=⍵/⍨i⌷⍨⎕IO+2)
                      }l{
                          (⍵⊃⍨⎕IO+1)↑⍺↓⍨⊃⍵
                      }¨↓⍉2↑c),⍵∘{
                          ↑8↓¨⍺/⍨t=⍵
                      }¨2 3+⎕IO
                  }↓⍵↑⍨⍴t
                  r ∇ ⍵
              }⍵↓⍨80÷⍨⊃⍺
              size←(h readhead'BITPIX')×{
                  'XTENSION'∊⍥↓⊃1↓h:⍵{(⊃1↓⍵)×⍺+⊃⍵}h readhead,∘'COUNT'¨'PG' ⋄ ⍵
              }{⍬≡⍵:0 ⋄ ×/⍵}shape h
              h[⎕IO]←⊂(⍺,⍥⊃h),2880×⌈size÷2880×8
              (+/⊃h)(h⍪⍨⊃1↓⍺)∇ ⍵
          }(80 ¯1 80)⎕MAP ⍵'r'
      }

      mapshape←{
          ¯1⌽(shape ⍵),{
              8|⍵:'[GCOUNT×]BITPIX must be multiple of 8'⎕SIGNAL 6
              83,⍨⍵÷8
          }×/⍵ readhead ⍵{'XTENSION'∊⍥↓⊃1↓⍺:'GCOUNT'⍵ ⋄ ⍵}'BITPIX'
      }

    readhead←{⍺{(,1↓⍵)⌷¨⊃∘⍺¨⎕IO⌷⍵}⍉((⊃1↓⍺)⍳⍥↓⍉8↑⍉↑⍵)∘.⌷2↑3↓⍺}

    shape←{⌽⍵∘readhead{⍺⍺ ⍵∘,¨⍕¨1+⎕IO-⍨⍳⍺⍺ ⍵}'NAXIS'}

    binnames←{⍺⍺∘((↓⊃binfields ⍵)~¨' ')⊆⍺}


      binread←{
          h←binfields ⍵
          ⍺←⍳⊃⍴⊃h
          c u d b s k←↑¨↓⍉h∘.⌷⍨∊((~∘' '¨↓⊃h)∘⍳@{~×10|⎕DR¨⍵})⊆⍺
          k fitsdr(({(2↑⍵),×/2↓⍵}mapshape ⍵)⎕MAP ⍺⍺'r'(+/2↑⊃⍵))∘{
              ⍉(⊃1↓⍵)↑(⊃⍵)↓⍉⍺
          }¨↓⍉↑d(b×s)
      }


:EndNamespace
