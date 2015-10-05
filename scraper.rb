#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'
require 'nokogiri'
require 'open-uri'
require 'pry'

def noko_for(url)
  Nokogiri::HTML(open(url).read) 
end

def wikinames(url)
  noko = noko_for(url)
  noko.xpath('//h2[span[@id="Members"]]/following-sibling::table[1]//tr[td]/td[2]//a[not(@class="new")]/@title').map(&:text)
end

names = wikinames('https://en.wikipedia.org/wiki/9th_Parliament_of_Solomon_Islands')

WikiData.ids_from_pages('en', names).each_with_index do |p, i|
  data = WikiData::Fetcher.new(id: p.last).data('fr') rescue nil
  unless data
    warn "No data for #{p}"
    next
  end
  puts data
  ScraperWiki.save_sqlite([:id], data)
end
