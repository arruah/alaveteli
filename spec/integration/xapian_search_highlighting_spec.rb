require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'highlighting search results' do
    include HighlightHelper

    it 'ignores stopwords' do
        phrase = 'department of humpadinking'
        search = ActsAsXapian::Search.new([PublicBody], phrase, :limit => 1)
        matches = search.words_to_highlight(:regex => true)
        highlight_matches(phrase, matches).should == '<mark>department</mark> of <mark>humpadinking</mark>'
    end

    it 'ignores case' do
        search_phrase = 'department of humpadinking'
        search = ActsAsXapian::Search.new([PublicBody], search_phrase, :limit => 1)
        matches = search.words_to_highlight(:regex => true)
        highlight_matches('Department of Humpadinking', matches).should == '<mark>Department</mark> of <mark>Humpadinking</mark>'
    end

    it 'highlights stemmed words' do
        phrase = 'department'
        search = ActsAsXapian::Search.new([PublicBody], phrase, :limit => 1)
        matches = search.words_to_highlight(:regex => true)

        search.words_to_highlight(:regex => false).should == ['depart']
        highlight_matches(phrase, matches).should == '<mark>department</mark>'
    end

end
