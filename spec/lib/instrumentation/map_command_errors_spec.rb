require 'rails_helper'

RSpec.describe Instrumentation::MapCommandErrors, type: :lib do
  let(:response) { described_class.new(errors: errors).map_errors }
  let(:source_message) { 'Some error' }
  let(:other_message) { 'Other error' }
  let(:errors) do
    {
      source: [source_message],
      other: [other_message]
    }
  end

  describe '#map_errors' do
    it 'maps the errors hash to an array of errors' do
      expect(response).to match_array([source_message, other_message])
    end
  end
end
