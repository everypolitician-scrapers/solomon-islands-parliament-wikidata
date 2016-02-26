#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/9th_Parliament_of_Solomon_Islands',
  xpath: '//h2[span[@id="Members"]]/following-sibling::table[1]//tr[td]/td[2]//a[not(@class="new")]/@title',
) 
EveryPolitician::Wikidata.scrape_wikidata(names: { en: names })
