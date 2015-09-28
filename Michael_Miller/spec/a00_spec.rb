require 'rspec'
require 'a00'

describe '#folding_cipher' do
  it 'should use the folding cipher' do
    expect(folding_cipher('a')).to eq('z')
    expect(folding_cipher('d')).to eq('w')
  end

  it 'should encode words correctly' do
    expect(folding_cipher('hello')).to eq('svool')
    expect(folding_cipher('goodbye')).to eq('tllwybv')
  end

  it 'should decode words correctly' do
    expect(folding_cipher('svool')).to eq('hello')
    expect(folding_cipher('tllwybv')).to eq('goodbye')
  end
end

describe "#factors" do
  # given a number, return an ordered array of its factors.

  it "returns factors of 10 in order" do
    expect(factors(10)).to eq([1, 2, 5, 10])
  end

  it "returns just two factors for primes" do
    expect(factors(13)).to eq([1, 13])
  end
end

describe '#jumble_sort' do
  it 'should default to alphabetical order' do
    expect(jumble_sort('hello')).to eq('ehllo')
  end

  it 'should take an alphabet array and sort by that order' do
    alph = ('a'..'z').to_a
    hello = 'hello'.chars.to_a
    alph -= hello
    alphabet = (hello += alph)

    expect(jumble_sort('hello', alphabet)).to eq('hello')
  end

  it 'should be able to do reverse alphabetical order' do
    reverse = ('a'..'z').to_a.reverse
    expect(jumble_sort('hello', reverse)).to eq('ollhe')
  end
end

describe "#dups" do
  # Write a new Array method (using monkey-patching) that will return
  # whether or not an array has duplicated elements.

  it "solves a simple example" do
    expect([1, 3, 0, 1].dups).to eq(true)
  end

  it "works with two dups" do
    expect([1, 3, 0, 3, 1].dups).to eq(true)
  end

  it "finds multi-dups" do
    expect([1, 3, 4, 3, 0, 3].dups).to eq(true)
  end

  it "returns {} when no dups found" do
    expect([1, 3, 4, 5].dups).to eq(false)
  end
end

describe "symmetrical?" do
  # Write String#symmetrical?. This method should return true
  # if the string is the same when reversed. You may NOT use
  # String#reverse or Array#reverse (or their ! equivalents)
  # in your implementation.
  it "doesn't use reverse" do
    word = "some string"
    expect(word).to_not receive(:reverse)
    expect(word).to_not receive(:reverse!)
    word.symmetrical?
  end

  it "detects palindromes with an odd number of letters" do
    word = "racecar"
    expect(word.symmetrical?).to eq(true)
  end

  it "detects palindromes with an even number of letters" do
    word = "toot"
    expect(word.symmetrical?).to eq(true)
  end

  it "doesn't detect false positives" do
    word = "racelikecar"
    expect(word.symmetrical?).to eq(false)
  end

  it "can handle multi word palindromes" do
    sentence = "too hot to hoot"
    expect(sentence.symmetrical?).to eq(true)
  end
end

