   
require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order_complete) { FactoryBot.create(:order_complete_a) }
  let(:order_complete_b) { FactoryBot.create(:order_complete_b) }
  let(:order_complete_c)  { FactoryBot.create(:order_complete_c) }

  describe 'associations' do
    it { should belong_to(:merchant) }
    it { should belong_to(:shopper) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:created_at) }
  end

  describe 'creation validations' do
    context 'valid' do
      it 'should create an order correctly' do
        expect(order_complete.valid?).to eq true
      end
    end
    context 'invalid' do
      it 'should not create an order without merchant' do
        order_complete.merchant = nil
        expect(order_complete.valid?).to eq false
      end
      it 'should not create an order without shopper' do
        order_complete.merchant = nil
        expect(order_complete.valid?).to eq false
      end
    end
  end

  describe 'fee calculations' do
    # 1% fee for amounts smaller than 50 €
    it 'should return the 1% of 36 => 0.36' do
      expect(order_complete.fee_order.to_f).to eq 0.36
    end
		# 0.95% for amounts between 50€ - 300€
    it 'should return the 0.95% of 293 => 2.7835 ' do
      expect(order_complete_b.fee_order.to_f).to eq 2.7835
    end
		# 0.85% for amounts over 300€
    it 'should return the 0.85% of 369 => 3.1365000000000003' do
      expect(order_complete_c.fee_order.to_f).to eq 3.1365000000000003
    end
  end
end