# frozen_string_literal: true

require 'rails_helper'

describe PostFilterService do
  net1 = SocialNetwork.create(name: 'facebook')
  net2 = SocialNetwork.create(name: 'twitter')
  user1 = User.create(full_name: Faker::Name.name)
  user2 = User.create(full_name: Faker::Name.name)
  user3 = User.create(full_name: Faker::Name.name)
  user4 = User.create(full_name: Faker::Name.name)
  let!(:post1) { create(:post, user: user1, social_network: net1, content: 'Custom content') }
  let!(:post2) { create(:post, user: user2, social_network: net1) }
  let!(:post3) { create(:post, user: user3, social_network: net2) }
  let!(:post4) { create(:post, user: user4, social_network: net2, title: 'Custom title') }

  describe '#call' do
    context 'without filtering params' do
      subject(:service) { PostFilterService.new }

      it 'should return posts' do
        result = service.call
        expect(result[0].size).to eql(4)
      end
    end

    context 'with social_network param present' do
      subject(:service) { PostFilterService.new(network_id: net2.id) }

      it 'should return filtered posts by social_network' do
        result = service.call
        expect(result[0].size).to eql(2)
        expect(result[0].first.social_network.name).to eql('twitter')
      end
    end

    context 'with user_id param present' do
      subject(:service) { PostFilterService.new(user_id: user4.id) }

      it 'should return filtered posts by user_id' do
        result = service.call
        expect(result[0].size).to eql(1)
        expect(result[0].first.user_id).to eql(user4.id)
      end
    end

    context 'with text param present' do
      subject(:service) { PostFilterService.new(text: 'custom') }

      it 'should return filtered posts by content or title' do
        result = service.call
        expect(result[0].size).to eql(2)
      end
    end
  end
end
