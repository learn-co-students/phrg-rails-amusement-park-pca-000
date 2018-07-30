require 'spec_helper'

describe 'rubocop analysis' do
  xit 'has no offenses' do
    expect(`rubocop`).to match(/no\ offenses\ detected/)
  end
end
