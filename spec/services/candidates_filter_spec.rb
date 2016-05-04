require 'rails_helper'

RSpec.describe CandidatesFilter, type: :model do

  subject { described_class.new params }
  let(:params) { {  }.with_indifferent_access }

  describe '#perform' do
    it 'sort by date' do
      rel = subject.perform
      expect(rel).to be_an(Candidate::ActiveRecord_Relation)
      expect(rel.order_values.size).to eql 1
      order = rel.order_values.first
      expect(order).to be_a(Arel::Nodes::Ascending)
      expect(order.direction).to eql :asc
      expect(order.value.name).to eql :date
    end
  end
end
