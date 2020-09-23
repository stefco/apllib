:Namespace fits
⍝ === VARIABLES ===

    fitstypes←'LXBIJKAEDCMPQ'

    fitstypesizes←(3/1),2 4 8 1 4 8 8 16 8 16

    help ←⊂'FITS: TOOLS FOR WORKING WITH FITS IMAGE FILES'
    help,←⊂''
    help,←⊂'Set `⎕IO` to 0 (zero-indexing):'
    help,←⊂''
    help,←⊂'      ⎕IO←0'
    help,←⊂''
    help,←⊂'Load headers from a LIGO fits file:'
    help,←⊂''
    help,←⊂'      fitspath ←''/Users/s/papers/2020-06-01-thesis_healtree_chapter/'
    help,←⊂'      fitspath,←''S200302c.multiorder.fits'''
    help,←⊂'      h←fits.headers fitspath'
    help,←⊂''
    help,←⊂'Display the first fits header (dropping the history and comment'
    help,←⊂'columns), which should always look like this:'
    help,←⊂''
    help,←⊂'      )copy util DISP'
    help,←⊂'      DISP ⍪¨¯2↓h[0;]'
    help,←⊂''
    help,←⊂' ┌────┬────────┬──────────────────────────┬─┬─┬───┬─┬─┐'
    help,←⊂' │   0│SIMPLE  │conforms to FITS standard │7│0│┌─┐│ │ │'
    help,←⊂' │2880│BITPIX  │array data type           │6│0││ ││8│1│'
    help,←⊂' │   0│NAXIS   │number of array dimensions│6│1│└─┘│0│1│'
    help,←⊂' │    │EXTEND  │                          │7│1│   │ │ │'
    help,←⊂' └────┴────────┴──────────────────────────┴─┴─┴───┴─┴─┘'
    help,←⊂''
    help,←⊂'View the raw shapes of the data associated with each header in the'
    help,←⊂'file (in bytes):'
    help,←⊂''
    help,←⊂'      )copy util DISPLAY'
    help,←⊂'      DISPLAY fits.shape¨↓h'
    help,←⊂''
    help,←⊂' ┌→───────────────┐'
    help,←⊂' │ ┌⊖┐ ┌→───────┐ │'
    help,←⊂' │ │0│ │19200 40│ │'
    help,←⊂' │ └~┘ └~───────┘ │'
    help,←⊂' └∊───────────────┘'
    help,←⊂''
    help,←⊂'View the metadata fields on the second header, which defines the'
    help,←⊂'actual image:'
    help,←⊂''
    help,←⊂'      h[1;1 2]'
    help,←⊂''
    help,←⊂' XTENSION  binary table extension'
    help,←⊂' BITPIX    array data type'
    help,←⊂' NAXIS     number of array dimensions'
    help,←⊂' NAXIS1    length of dimension 1'
    help,←⊂' NAXIS2    length of dimension 2'
    help,←⊂' PCOUNT    number of group parameters'
    help,←⊂' GCOUNT    number of groups'
    help,←⊂' TFIELDS   number of table fields'
    help,←⊂' TTYPE1'
    help,←⊂' TFORM1'
    help,←⊂' TTYPE2'
    help,←⊂' TFORM2'
    help,←⊂' TUNIT2'
    help,←⊂' TTYPE3'
    help,←⊂' TFORM3'
    help,←⊂' TUNIT3'
    help,←⊂' TTYPE4'
    help,←⊂' TFORM4'
    help,←⊂' TUNIT4'
    help,←⊂' TTYPE5'
    help,←⊂' TFORM5'
    help,←⊂' TUNIT5'
    help,←⊂' MOC'
    help,←⊂' PIXTYPE   HEALPIX pixelisation'
    help,←⊂' ORDERING  Pixel ordering scheme: RING, NESTED, or NUNIQ'
    help,←⊂' COORDSYS  Ecliptic, Galactic or Celestial (equatorial)'
    help,←⊂' MOCORDER  MOC resolution (best order)'
    help,←⊂' INDXSCHM  Indexing: IMPLICIT or EXPLICIT'
    help,←⊂' OBJECT    Unique identifier for this event'
    help,←⊂' REFERENC  URL of this event'
    help,←⊂' INSTRUME  Instruments that triggered this event'
    help,←⊂' DATE-OBS  UTC date of the observation'
    help,←⊂' MJD-OBS   modified Julian date of the observation'
    help,←⊂' DATE      UTC date of file creation'
    help,←⊂' CREATOR   Program that created this file'
    help,←⊂' ORIGIN    Organization responsible for this FITS file'
    help,←⊂' RUNTIME   Runtime in seconds of the CREATOR program'
    help,←⊂' DISTMEAN  Posterior mean distance (Mpc)'
    help,←⊂' DISTSTD   Posterior standard deviation of distance (Mpc)'
    help,←⊂' LOGBCI    Log Bayes factor: coherent vs. incoherent'
    help,←⊂' LOGBSN    Log Bayes factor: signal vs. noise'
    help,←⊂' VCSVERS   Software version'
    help,←⊂' VCSREV    Software revision (Git)'
    help,←⊂' DATE-BLD  Software build date'
    help,←⊂''
    help,←⊂'Load the DISTMEAN and DISTSTD values:'
    help,←⊂''
    help,←⊂'      h[1;] fits.readhead ''DISTMEAN'' ''DISTSTD'''
    help,←⊂''
    help,←⊂' 1737.414538 500.2420472'
    help,←⊂''
    help,←⊂'View the BINTABLE fields on the second header:'
    help,←⊂''
    help,←⊂'      ⍪¨fits.binfields h[1;]'
    help,←⊂''
    help,←⊂' UNIQ                 0  8  1  K'
    help,←⊂' PROBDENSITY  sr-1    8  8  1  D'
    help,←⊂' DISTMU       Mpc    16  8  1  D'
    help,←⊂' DISTSIGMA    Mpc    24  8  1  D'
    help,←⊂' DISTNORM     Mpc-2  32  8  1  D'
    help,←⊂''
    help,←⊂'We want the `UNIQ` and `PROBDENSITY` or `PROB` fields. Besides looking at the'
    help,←⊂'BINTABLE fields as above, we can check for membership with `binnames`:'
    help,←⊂''
    help,←⊂'      ''UNIQ'' ''PROBDENSITY'' ''PROB''∊fits.binnames h[1;]'
    help,←⊂''
    help,←⊂' 1 1 0'
    help,←⊂''
    help,←⊂'Load a single column, `UNIQ`, and view its first 10 elements:'
    help,←⊂''
    help,←⊂''
    help,←⊂'      10↑⊃''UNIQ''(fitspath fits.binread)h[1;]'
    help,←⊂''
    help,←⊂' 1024'
    help,←⊂' 1025'
    help,←⊂' 1026'
    help,←⊂' 1027'
    help,←⊂' 1028'
    help,←⊂' 1029'
    help,←⊂' 1030'
    help,←⊂' 1031'
    help,←⊂' 1032'
    help,←⊂' 1033'
    help,←⊂''
    help,←⊂'Load `UNIQ` and `PROBDENSITY` and display their first 10 elements:'
    help,←⊂''
    help,←⊂'      DISP 10↑¨''UNIQ'' ''PROBDENSITY''(fitspath fits.binread)h[1;]'
    help,←⊂''
    help,←⊂'┌────┬───────────────┐'
    help,←⊂'│1024│0.0007709143604│'
    help,←⊂'│1025│0.0009595176541│'
    help,←⊂'│1026│0.001926238858 │'
    help,←⊂'│1027│0.002484437434 │'
    help,←⊂'│1028│0.001501028836 │'
    help,←⊂'│1029│0.003074934707 │'
    help,←⊂'│1030│0.003692214647 │'
    help,←⊂'│1031│0.006983876737 │'
    help,←⊂'│1032│0.003647436636 │'
    help,←⊂'│1033│0.005124141247 │'
    help,←⊂'└────┴───────────────┘'
    help←↑help



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
          dmax dmin←{645 ⎕DR⌽83 ⎕DR ⍵}¨,∘(¯10⌽0,62⍴1)¨0 1
          kinf kninf←323 ⎕DR¨,∘(63↑11⍴1)¨0 1
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
