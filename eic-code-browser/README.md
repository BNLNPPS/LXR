# LXR Cross Referencer for EIC source code

This github repo collects the modified LXR source code and corresponding scripts/configuration files, 
used to download the EIC source code, and generate the LXR index.

The LXR Crosss Referencer link is https://eic-code-browser.sdcc.bnl.gov/lxr/source

## Required Software

- [LXR](https://lxr.sourceforge.io/en/index.php) version 2.3.5 with some modifications.
- [Universal Ctags](https://ctags.io/) 5.9.0, replacing the system ctags (Exuberant Ctags), which is out of development.
- [glimpse](https://github.com/gvelez17/glimpse) version 4.18.7
- mysql Ver 15.1 Distrib 5.5.65-MariaDB.
- [flex-devel](https://github.com/westes/flex), needed by glimpse

## Configurations

### The LXR configuration
The lxr is configured in [the file lxr-conf/lxr.conf](eic-code-browser/lxr-conf/lxr.conf).

In the configuration file, the parameter **host_names** specifies the list of URL, recognizable by the LXR server.
```perl
        ,       'host_names' => [ 'http://localhost', 'https://localhost'
                                                , 'http://eic-code-browser.sdcc.bnl.local:80'
                                                , 'https://eic-code-browser.sdcc.bnl.local:80' 
                                                , 'http://eic-code-browser:80'
                                                , 'http://eic-code-browser.sdcc.bnl.gov:80'
                                                , 'https://eic-code-browser:80'
                                                , 'https://eic-code-browser.sdcc.bnl.gov:80'
                                                ]
```

And the parameter **sourceroot** tells LXR  where to get the source files from:
```perl
        , 'sourceroot' => '/home/lxrsource/eic/source'
```

### The httpd configuration

The httpd configuration for the LXR server is defined in [the file apache-lxrserver.conf](eic-code-browser/httpd/apache-lxrserver.conf).
It is defined through the apache macro **VHost**:
```macro
Use VHost eic-code-browser /usr/local/share/lxr/eic-lxr
```
where */usr/local/share/lxr/eic-lxr* is the location of the LXR source code and configuration file.

## Nightly source code downloading and indexing

A cron job is running under the account *apache* **nightly at 3am**. 
The corresponding cron job script is [cron-eic_lxr.sh](eic-code-browser/cronJob/cron-eic_lxr.sh).
This script does:
- Call another script [eic-clonePacks_and_cleanup.sh](eic-code-browser/cronJob/eic-clonePacks_and_cleanup.sh), 
  which downloads all repos (currently just the **main branch**) listed in [the repo list file](eic-code-browser/cronJob/repo-list.txt).
  and copied all header files in a temporary ePIC container, installed via [the script install.sh](https://eic.github.io/eic-shell/install.sh)
- Then generate the LXR index by running the command `./genxref --url=http://localhost/lxr`.

