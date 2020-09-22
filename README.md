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

You can now load `foo` either by specifying the full path to the `foo.dyalog`
object created or by simply specifying `foo` (since this working copy should be
in your SALT `workdir` path):

```apl
⎕SE.SALT.Load 'foo'
```

## Further reading on SALT

[Dyalog SALT Reference Guide](http://docs.dyalog.com/14.0/Dyalog%20APL%20SALT%20Reference%20Guide.pdf)
[PowerPoint intro to SALT (2008)](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjn5aufyf3rAhWEzVkKHWdmBlkQFjACegQIBRAB&url=https%3A%2F%2Fwww.dyalog.com%2Fuploads%2Fconference%2Fdyalog08%2Fpresentations%2FW04_Baronet_SALTandSVN%2FSALT%2520in%2520Dyalog.ppt&usg=AOvVaw2jH-Aasg69OKj6R9UL9Z8s)
