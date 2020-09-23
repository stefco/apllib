# Stef's APL Libraries

Some utility functions for experimenting in Dyalog APL.

## Getting Started

Clone this repository and add the path to your APL SALT path (replacing the
path below with the actual path to the repository location):

```apl
⎕SE.SALT.Settings 'workdir ',(⎕SE.SALT.Settings 'workdir'),':/Users/s/dev/apllib'
```

Make the settings permanent (not just for this session):

```apl
⎕SE.SALT.Settings '-permanent'
```

Save a new namespace, called `foo` in this example, to the location of this
repository (again, replace the path with the actual work directory):

```apl
⎕SE.SALT.Save #.foo '/Users/s/dev/apllib/'
```

or simply

```apl
]save #.foo '/Users/s/dev/apllib/'
```

You can now load `foo` either by specifying the full path to the `foo.dyalog`
object created or by simply specifying `foo` (since this working copy should be
in your SALT `workdir` path):

```apl
⎕SE.SALT.Load 'foo'
```

or simply

```apl
]load foo
```

### Further reading on SALT

[Dyalog SALT Reference Guide](http://docs.dyalog.com/14.0/Dyalog%20APL%20SALT%20Reference%20Guide.pdf)
[PowerPoint intro to SALT (2008)](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjn5aufyf3rAhWEzVkKHWdmBlkQFjACegQIBRAB&url=https%3A%2F%2Fwww.dyalog.com%2Fuploads%2Fconference%2Fdyalog08%2Fpresentations%2FW04_Baronet_SALTandSVN%2FSALT%2520in%2520Dyalog.ppt&usg=AOvVaw2jH-Aasg69OKj6R9UL9Z8s)

## `fits`: Utils for FITS image format

Load the `fits` library:

```apl
]load fits
```

Set `⎕IO` to 0 (zero-indexing):

```apl
⎕IO←0
```

Load headers from a LIGO fits file:

```apl
fitspath←'/Users/s/papers/2020-06-01-thesis_healtree_chapter/S200302c.multiorder.fits'
h←fits.headers fitspath
```

Display the first fits header (dropping the history and comment columns), which
should always look like this:

```apl
)copy util DISP
DISP ⍪¨¯2↓h[0;]
```

```
┌────┬────────┬──────────────────────────┬─┬─┬───┬─┬─┐
│   0│SIMPLE  │conforms to FITS standard │7│0│┌─┐│ │ │
│2880│BITPIX  │array data type           │6│0││ ││8│1│
│   0│NAXIS   │number of array dimensions│6│1│└─┘│0│1│
│    │EXTEND  │                          │7│1│   │ │ │
└────┴────────┴──────────────────────────┴─┴─┴───┴─┴─┘
```

View the raw shapes of the data associated with each header in the file (in
bytes):

```apl
)copy util DISPLAY
DISPLAY fits.shape¨↓h
```

```
┌→───────────────┐
│ ┌⊖┐ ┌→───────┐ │
│ │0│ │19200 40│ │
│ └~┘ └~───────┘ │
└∊───────────────┘
```

View the metadata fields on the second header, which defines the actual image:

```apl
h[1;1 2]
```

```
 XTENSION  binary table extension
 BITPIX    array data type
 NAXIS     number of array dimensions
 NAXIS1    length of dimension 1
 NAXIS2    length of dimension 2
 PCOUNT    number of group parameters
 GCOUNT    number of groups
 TFIELDS   number of table fields
 TTYPE1
 TFORM1
 TTYPE2
 TFORM2
 TUNIT2
 TTYPE3
 TFORM3
 TUNIT3
 TTYPE4
 TFORM4
 TUNIT4
 TTYPE5
 TFORM5
 TUNIT5
 MOC
 PIXTYPE   HEALPIX pixelisation
 ORDERING  Pixel ordering scheme: RING, NESTED, or NUNIQ
 COORDSYS  Ecliptic, Galactic or Celestial (equatorial)
 MOCORDER  MOC resolution (best order)
 INDXSCHM  Indexing: IMPLICIT or EXPLICIT
 OBJECT    Unique identifier for this event
 REFERENC  URL of this event
 INSTRUME  Instruments that triggered this event
 DATE-OBS  UTC date of the observation
 MJD-OBS   modified Julian date of the observation
 DATE      UTC date of file creation
 CREATOR   Program that created this file
 ORIGIN    Organization responsible for this FITS file
 RUNTIME   Runtime in seconds of the CREATOR program
 DISTMEAN  Posterior mean distance (Mpc)
 DISTSTD   Posterior standard deviation of distance (Mpc)
 LOGBCI    Log Bayes factor: coherent vs. incoherent
 LOGBSN    Log Bayes factor: signal vs. noise
 VCSVERS   Software version
 VCSREV    Software revision (Git)
 DATE-BLD  Software build date
```

Load the DISTMEAN and DISTSTD values:

```apl
h[1;] fits.readhead 'DISTMEAN' 'DISTSTD'
```

```
1737.414538 500.2420472
```

View the BINTABLE fields on the second header:

```apl
⍪¨fits.binfields h[1;]
```

```
 UNIQ                 0  8  1  K
 PROBDENSITY  sr-1    8  8  1  D
 DISTMU       Mpc    16  8  1  D
 DISTSIGMA    Mpc    24  8  1  D
 DISTNORM     Mpc-2  32  8  1  D
```

We want the `UNIQ` and `PROBDENSITY` or `PROB` fields. Besides looking at the
BINTABLE fields as above, we can check for membership with `binnames`:

```apl
'UNIQ' 'PROBDENSITY' 'PROB'∊fits.binnames h[1;]
```

```
1 1 0
```

Load a single column, `UNIQ`, and view its first 10 elements:


```apl
10↑⊃'UNIQ'(fitspath fits.binread)h[1;]
```

```
1024
1025
1026
1027
1028
1029
1030
1031
1032
1033
```

Load `UNIQ` and `PROBDENSITY` and display their first 10 elements:

```apl
DISP 10↑¨'UNIQ' 'PROBDENSITY'(fitspath fits.binread)h[1;]
```

```
┌────┬───────────────┐
│1024│0.0007709143604│
│1025│0.0009595176541│
│1026│0.001926238858 │
│1027│0.002484437434 │
│1028│0.001501028836 │
│1029│0.003074934707 │
│1030│0.003692214647 │
│1031│0.006983876737 │
│1032│0.003647436636 │
│1033│0.005124141247 │
└────┴───────────────┘
```
