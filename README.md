# Obelisk+Rhyolite GHC 8.10 Issue

This repository is a minimal recreation of an issue that I have run into while
using Obelisk and Rhyolite with GHC 8.10.7.

## Repository Setup

This section documents how I setup this repository.  Please see the commits
for details.

Run `ob init`:

```
$ mkdir /tmp/obelisk-rhyolite-810-issue
$ cd /tmp/obelisk-rhyolite-810-issue
$ ob init
```

Use Obelisk `develop` `HEAD`:

```
$ nix-thunk unpack .obelisk/impl
$ (cd .obelisk/impl && git checkout develop)
$ nix-thunk pack .obelisk/impl
```

Use Reflex Platform `develop` `HEAD`:

```
$ mkdir dep
$ (cd dep && git clone https://github.com/reflex-frp/reflex-platform.git)
$ nix-thunk pack dep/reflex-platform
$ vi default.nix
```

Set `useGHC810 = true`:

```
$ vi default.nix
```

Use Rhyolite `aa/ghc810`:

```
$ cd dep
$ git clone https://github.com/obsidiansystems/rhyolite.git
$ (cd rhyolite && git checkout aa/ghc810)
$ nix-thunk pack rhyolite
$ cd ..
$ vi default.nix
```

Add `rhyolite-frontend` dependency:

```
$ vi frontend/frontend.cabal
```

## The Error

With Obelisk packed, I am able to run `ob run` or `ob shell` without errors.
Perhaps there is something in my cache that allows this, but I am not sure.

```
$ ob shell
shell$ exit
```

Unpack Obelisk:

```
$ nix-thunk unpack .obelisk/impl
```

With Obelisk unpacked, I get an error.  I have not been able to figure out
what is causing this error or how to resolve it.

```
$ ob shell
error: builder for '/nix/store/3mnd3jf3kbflw8a9716bp87py7scqzgd-tabulation-0.1.0.0.drv' failed with exit code 1;
       last 5 log lines:
       > setupCompilerEnvironmentPhase
       > Build with /nix/store/26k0ndap2lmh08l9x3ah8yhmbkzm5qj3-ghc-8.10.7.
       > unpacking sources
       > unpacking source archive /home/tcard/tmp/obelisk-rhyolite-810-issue/.obelisk/impl/lib/tabulation
       > do not know how to unpack source archive /home/tcard/tmp/obelisk-rhyolite-810-issue/.obelisk/impl/lib/tabulation
       For full logs, run 'nix log /nix/store/3mnd3jf3kbflw8a9716bp87py7scqzgd-tabulation-0.1.0.0.drv'.
```
