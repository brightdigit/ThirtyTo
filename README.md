<!-->
# ThirtyTo

[![SwiftPM](https://img.shields.io/badge/SPM-Linux%20%7C%20iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-success?logo=swift)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@brightdigit-blue.svg?style=flat)](http://twitter.com/brightdigit)
![GitHub](https://img.shields.io/github/license/brightdigit/ThirtyTo)
![GitHub issues](https://img.shields.io/github/issues/brightdigit/ThirtyTo)



[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/ThirtyTo)](https://codecov.io/gh/brightdigit/ThirtyTo)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/brightdigit/ThirtyTo)](https://www.codefactor.io/repository/github/brightdigit/ThirtyTo)
[![codebeat badge](https://codebeat.co/badges/4f86fb90-f8de-40c5-ab63-e6069cde5002)](https://codebeat.co/projects/github-com-brightdigit-ThirtyTo-master)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/ThirtyTo)](https://codeclimate.com/github/brightdigit/ThirtyTo)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/ThirtyTo?label=debt)](https://codeclimate.com/github/brightdigit/ThirtyTo)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/ThirtyTo)](https://codeclimate.com/github/brightdigit/ThirtyTo)

[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

[What is ThirtyTo?](https://www.crockford.com/base32.html)

[Documentation Here](/docs/README.md)
-->

<p align="center">
    <img alt="ThirtyTo" title="ThirtyTo" src="Assets/logo.svg" height="200">
</p>
<h1 align="center"> ThirtyTo </h1>

Share your local development server easily with your Apple devices.

[![SwiftPM](https://img.shields.io/badge/SPM-Linux%20%7C%20iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-success?logo=swift)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@brightdigit-blue.svg?style=flat)](http://twitter.com/brightdigit)
![GitHub](https://img.shields.io/github/license/brightdigit/ThirtyTo)
![GitHub issues](https://img.shields.io/github/issues/brightdigit/ThirtyTo)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/brightdigit/ThirtyTo/ThirtyTo.yml?label=actions&logo=github&?branch=main)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FThirtyTo%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/brightdigit/ThirtyTo)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FThirtyTo%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/brightdigit/ThirtyTo)


[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/ThirtyTo)](https://codecov.io/gh/brightdigit/ThirtyTo)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/brightdigit/ThirtyTo)](https://www.codefactor.io/repository/github/brightdigit/ThirtyTo)
[![codebeat badge](https://codebeat.co/badges/54695d4b-98c8-4f0f-855e-215500163094)](https://codebeat.co/projects/github-com-brightdigit-ThirtyTo-main)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/ThirtyTo)](https://codeclimate.com/github/brightdigit/ThirtyTo)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/ThirtyTo?label=debt)](https://codeclimate.com/github/brightdigit/ThirtyTo)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/ThirtyTo)](https://codeclimate.com/github/brightdigit/ThirtyTo)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

# Table of Contents

* [Introduction](#introduction)
   * [Requirements](#requirements)
   * [Using Ngrok](#using-ngrok)
   * [Using the Cloud for Meta-Server Access](#using-the-cloud-for-meta-server-access)
* [Features](#features)
* [Installation](#installation)
   * [Cloud Setup](#cloud-setup)
   * [Server Installation](#server-installation)
   * [Client Installation](#client-installation)
* [License](#license)

# Introduction

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In dictum non consectetur a erat nam at lectus urna. Maecenas accumsan lacus vel facilisis volutpat est velit.

## Requirements 

**Apple Platforms**

- Xcode 13.3 or later
- Swift 5.5.2 or later
- iOS 14 / watchOS 6 / tvOS 14 / macOS 12 or later deployment targets

**Linux**

- Ubuntu 18.04 or later
- Swift 5.5.2 or later

## Why use Base32

### Beneifts

### Drawbacks

<!--
## Using Ngrok

Ngrok is a fantastic service for setting up local development server for outside access. Let's say you need to share your local development server because you're testing on an actual device which can't access your machine via your local network. You can run `ngrok` to setup an https address which tunnels to your local development server:

```bash
> vapor run serve -p 1337
> ngrok http 1337
```
Now you'll get a message saying your vapor app is served through ngrok:

```
Forwarding https://c633-2600-1702-4050-7d30-cc59-3ffb-effa-6719.ngrok.io -> http://localhost:1337 
```

Great! So how can I make sure my app uses that address for the host name?

* Hard Code It! 
* Parse Environment Variable?
* Magic?

That's where ThirtyTo comes in...

## Using the Cloud for Meta-Server Access

With ThirtyTo you save the address (such as `https://c633-2600-1702-4050-7d30-cc59-3ffb-effa-6719.ngrok.io`) to a key-value storage and pull that address from your Apple device during development.
-->

# Usage

Lorem markdownum es nisi regem, abit collumque ignibus, date aliud cervice
redderet: aderat. Sensi [Actoridaeque](http://invenio-taedis.net/) ipsius in
vicina, transformat vinctum paternis; in nec **et est**. Solum populosque auras,
est pellis cupit debes erat date amorem, Aeaciden corpore occiderat.

Alis sanguis modo! Sim Argo, suis Cimoli coniuge. Furores quas.

1. Pedibus humum
2. Conplexa temptasse digitos
3. In petit quem quoque summis rutilos tu

Aspicit ore candida caput perveni *vultuque* coniugio remissurus veni crescitque
animos ipsumque. Est priores ipsa, cum requies primum orat stravimus hac? Rex in
quod si inguine addidit auctor genas diluvio et quem pugnant aequalis, saltumque
minoribus quam, quotiens turis?

## Encoding and Decoding Data

Lorem markdownum te Emathion tamen [exhortantur
aurato](http://www.infiducia.io/caencu) aut ubi **fuit cautibus**, inde ille non
nympharum geminam; est. Conscendit quartus, petisti, pudor Cassiope *corda*
suus, erubuit suffundit vestigia mitissima aduncae? Cura versus; dedit mare
urbem valido. Quoniam in [fine](http://mihi.net/), superesse, pius gladios;
honores Hyperionis ille.

    itunes_mirror += mipsCleanVlb;
    tag = compact(fileBotnet(keystroke, cameraPram),
            crossplatformTrimAnalyst.networking(23, -4), hdmi);
    driveUndoMarketing(virusUtf);
    teraflopsIm.cellLionLayout.graymail(clickBounce + ict, defaultSystem);

In somnus reserata conripimus velamine vix rursus culpa. Vacuas villo.

> Accipiam illi vela luctata solo, poma
> [venistis](http://iunoniaea.net/foresqueet.html), regia fores, sola. Priamus
> ardebant soporem, possederat, thalami consumpta infelicem plena formam.

Iuvenes fuit natus terga tenebo eburnae vos dextra ignotos erat
[caeleste](http://www.et.org/ille) de galea liberioris iungi cognosceret movens
genae? Animos auctor crudelibus lupis coniugis inposuitque **hiatu sorte
excussit** Iuppiter Phlegethontide. Attonitas dabitur locorum *per aut* infelix,
et de credar Amphimedon duri: sacra alius sensit.

### Using Group Separators

Lorem markdownum submovet qui. Mihi lumina causas. Quam nec, matrum Credulitas
adsiduis foret auditur Tritoniacam nostri. Ipsum cupit unda fas Priami clangore
levant. Diro arcus mansit, formae, violavit silvas muneris vulnera fata,
micuerunt.

    spreadsheet = ppp.window_model_ppp.resourcesRosettaKernel(of) + igp;
    if (http_radcab_web(motherboard * 1, modifier, print_c)) {
        textUnmountAdf = internet_and_cisc(point, insertionText, 1) + drive;
        apple_spam.podcast.compact(tiger_snapshot, 4);
    } else {
        clip = serviceWeb;
        lossyDuplexBox(dbms(databaseSinkSample), ethernetDialServer);
        tween_tiff_document /= control(712371, footerVduPermalink, asp);
    }
    if (-5 < mirrored + modem + spool) {
        leopardBackupDdr.newbiePci = status_zone;
    }
    memory_teraflops_rich.ergonomicsDvrMinimize(webmasterHardPaper);
    var portPumOverwrite = graphic(del_flood.deleteCompile.odbc_icf(delete_left,
            language_multicasting_syntax));

Pectora ego studeat inpia, et ignes inponique lustrat Lucina. Dentibus sed mecum
absens ad cuncta cultum *faciente* oculos; felix fixa pomoque venitque; ceu
tecta domus luctus convicia.

1. Aquilone ferro
2. Parum Iapygis ore latus quid nymphas
3. Sit temptatis possis
4. Ingenti revolutaque aevoque socer patria sceptrum ut
5. Et illac auctor manere
6. Quidem Oileos aliquemque

### Adding a Checksum

## Creating an Identifier

Lorem markdownum duas, qui data superare trisulcis rex haec unius! Rupe quo aut,
cum per, pius attactu. Repperit canenda deiectuque coepit vertitur violentus
quoque! Siccoque corpus. Illa intima Bacchum nativum.

Verque aves ab verba. Hoc auris sed formosissimus malorum virum: cum locoque
genuit, lumina velamina, huc. Materiam cetera, forte, deus tibi hiberna vates
revocamina. Tenebat validisne quod post longe parvis, sic superari!

- Atque et volvitur corpora
- Est ab protinus cornua renuente medii dum
- Modo suo convertit temporis Lapithas numenque coronat

### UUID

### What is ULID?

# Installation

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In dictum non consectetur a erat nam at lectus urna. Maecenas accumsan lacus vel facilisis volutpat est velit.

<!--
## Cloud Setup

If you haven't already setup an account with ngrok and install the command-line tool via homebrew. Next let's setup a key-value storage with kvdb.io which is currently supported. _If you have another service, please create an issue in the repo. Your feedback is helpful._ 

Sign up at kvdb.io and get a bucket name you'll use. You'll be using that for your setup. Essentially there are three components you'll need:

* path to ngrok on your machine - if you installed via homebrew it's `/opt/homebrew/bin/ngrok` but you can find out using: `which ngrok` after installation
* your kvdb.io bucket name 
* your kvdb.io key - you just need to pick something unique for your server and client to use

Now let's setup your Vapor server application...
## Server Installation

To integrate **ThirtyTo** into your Vapor app using SPM, specify it in your Package.swift file:

```swift    
let package = Package(
  ...
  dependencies: [
    .package(url: "https://github.com/brightdigit/ThirtyTo.git", from: "0.1.0")
  ],
  targets: [
      .target(
          name: "YourVaporServerApp",
          dependencies: [
            .product(name: "ThirtyToVapor", package: "ThirtyTo"), ...
          ]),
      ...
  ]
)
```

`ThirtyToVapor` is the product which gives us the `ThirtyToLifecycleHandler` we'll use to integrate `ThirtyTo` with your Vapor app. Simply add `ThirtyToLifecycleHandler` to your application:

```swift
let app = Application(env)
...
app.lifecycle.use(
  ThirtyToLifecycleHandler(
    ngrokPath: "/opt/homebrew/bin/ngrok",
    bucketName: "bucket-name",
    key: "application key name"
  )
)
```

This will run `ngrok` and setup the forwarding address. Once it receives the address it saves it your kvdb bucket with key setup here.

Remember the ngrok path is the path from your development machine while the bucket name is from kvdb.io. However, the key can be anything you want as long as it's consistent and used by your client. Speaking of your client, let's talk about setting this up in your iOS app.

## Client Installation

In your Xcode project, add the swift package for ThirtyTo at:

```
https://github.com/brightdigit/ThirtyTo.git
```

In your application target, you only need a reference to the `ThirtyTo` library. 

Now to pull the url saved by your service, all you have to call is:

```swift
import ThirtyTo

let baseURL = try await KVdb.url(withKey: key, atBucket: bucketName)
```

At the point, you'll have the base url of your Vapor application and can begin using it in your application!
-->
# License 

This code is distributed under the MIT license. See the [LICENSE](https://github.com/brightdigit/ThirtyTo/LICENSE) file for more info.
