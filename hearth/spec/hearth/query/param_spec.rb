# frozen_string_literal: true

module Hearth
  module Query
    describe Param do
      describe '#name' do
        it 'returns the name' do
          expect(Param.new('name').name).to eq('name')
        end
      end

      describe '#value' do
        it 'returns the value' do
          expect(Param.new('name', 'value').value).to eq('value')
        end

        it 'defaults to nil' do
          expect(Param.new('name').value).to be(nil)
        end
      end

      describe '#to_s' do
        it 'url encodes the name and value' do
          param = Param.new('param name', 'val=u!')
          expect(param.to_s).to eq('param%20name=val%3Du%21')
        end

        it 'leaves the trailing = when value is nil' do
          param = Param.new('key')
          expect(param.to_s).to eq('key=')
        end

        it 'can handle arrays' do
          param = Param.new('foo', ['1', nil, '3'])
          expect(param.to_s).to eq('foo=1&foo=&foo=3')
        end
      end

      describe '#==' do
        it 'returns true if two params are the same' do
          expect(Param.new('name')).to eq(Param.new('name'))
        end

        it 'returns false if two params are different' do
          expect(Param.new('name1')).not_to eq(Param.new('name2'))
        end
      end

      describe '#<=>' do
        it 'sorts params' do
          p1 = Param.new('name1')
          p2 = Param.new('name2')
          expect([p2, p1].sort).to eq([p1, p2])
        end
      end
    end
  end
end
