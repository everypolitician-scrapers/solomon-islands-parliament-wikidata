#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/9th_Parliament_of_Solomon_Islands',
  xpath: '//h2[span[@id="Members"]]/following-sibling::table[1]//tr[td]/td[2]//a[not(@class="new")]/@title',
  as_ids: true,
)

query = <<SPARQL
  SELECT DISTINCT ?item WHERE {
    ?item p:P39 [ ps:P39 wd:Q17633943 ; pq:P2937 ?term ] .
    ?term p:P31/pq:P1545 ?ordinal .
    FILTER (xsd:integer(?ordinal) >= 10)
  }
SPARQL
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s | names)
