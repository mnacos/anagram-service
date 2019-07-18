# Anagram Service

Example Rails 5.2 web app producing anagrams for one or more words supplied as part of the url.  Only real words are processed/returned, real being defined in terms of a wordlist including terms.

## Specification

The application receives HTTP GET requests with the requested word as the path. It returns the results as JSON.

Example 1

GET /crepitus
```json
    {"crepitus":["cuprites","pictures","piecrust"]}
```

GET /crepitus,paste,kinship,enlist,boaster,fresher,sinks,knits,sort
```json
    {"crepitus":["cuprites","pictures","piecrust"],"paste":["pates","peats","septa","spate","tapes","tepas"],"kinship":["pinkish"],"enlist":["elints","inlets","listen","silent","tinsel"],"boaster":["boaters","borates","rebatos","sorbate"],"fresher":["refresh"],"sinks":["skins"],"knits":["skint","stink","tinks"],"sort":["orts","rots","stor","tors"]}
```

GET /sdfwehrtgegfg
```json
    {"sdfwehrtgegfg":[]}
```

## Requirements

* Ruby 2.5.5
* Rails 5.2.3
* Sqlite3

## Configuration

No configuration is required for this service, as it has no external dependencies.

## Database initialisation

A suitable production wordlist for this service has been included with the source code (db/wordlist.txt). It can be loaded into a sqlite database with this command:

```bash
RAILS_ENV=development bundle exec rake import:wordlist
```

An already populated production.sqlite3 database has been included for ease/speed of deployment.

## Test suite

The test suite can be run with rake:

```bash
bundle exec rake test
```

In addition, performance and scalability of this service may be assessed by running:

```bash
bundle exec rake test:performance
```

This proves that the performance on anagram searches does not degrade with database size.

## Deployment instructions

The easiest way to deploy this somewhere is clicking on this button:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Known issues

Importing the production wordlist into the database takes a long time. The import process could be improved using system and/or database tools or parallelisation.

