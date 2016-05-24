require 'rails_helper'

describe UsersHelper do

  describe '#submissions' do
    context 'if the user owns the submissions' do

      let(:user) {
        FactoryGirl.create(:user)
      }

      let(:experiences) {
        FactoryGirl.create_list(:experience, 5, user: user)
      }

      let(:ideas) {
        FactoryGirl.create_list(:idea, 5, user: user)
      }

      let(:recipes) {
        FactoryGirl.create_list(:recipe, 5, user: user)
      }

      let(:solutions) {
        FactoryGirl.create_list(:solution, 5, user: user)
      }

      let(:suggestions) {
        FactoryGirl.create_list(:suggestion, 5, user: user)
      }

      it 'pulls back all experiences' do
        user.experiences << experiences
        expect(submissions(user, user).size).to eq 5
      end

      it 'pulls back all ideas' do
        user.ideas << ideas
        expect(submissions(user, user).size).to eq 5
      end

      it 'pulls back all recipes' do
        user.recipes << recipes
        expect(submissions(user, user).size).to eq 5
      end

      it 'pulls back all solutions' do
        user.solutions << solutions
        expect(submissions(user, user).size).to eq 5
      end

      it 'pulls back all suggestions' do
        user.suggestions << suggestions
        expect(submissions(user, user).size).to eq 5
      end

      it 'pulls back everything' do
        user.experiences << experiences
        user.ideas << ideas
        user.recipes << recipes
        user.solutions << solutions
        user.suggestions << suggestions

        expect(submissions(user, user).size).to eq 25
      end
    end

    context 'if the user does not own the submissions' do

      let(:user) {
        FactoryGirl.create(:user)
      }

      let(:other_user) {
        FactoryGirl.create(:user)
      }

      let(:experiences) {
        pub = FactoryGirl.create_list(:experience, 5, user: user, published_at: Time.now)
        unpub = FactoryGirl.create_list(:experience, 15, user: user)
        pub + unpub
      }

      let(:ideas) {
        pub = FactoryGirl.create_list(:idea, 5, user: user, published_at: Time.now)
        unpub = FactoryGirl.create_list(:idea, 15, user: user)
        pub + unpub
      }

      let(:recipes) {
        pub = FactoryGirl.create_list(:recipe, 5, user: user, published_at: Time.now)
        unpub = FactoryGirl.create_list(:recipe, 15, user: user)
        pub + unpub
      }

      let(:solutions) {
        pub = FactoryGirl.create_list(:solution, 5, user: user, published_at: Time.now)
        unpub = FactoryGirl.create_list(:solution, 15, user: user)
        pub + unpub
      }

      let(:suggestions) {
        FactoryGirl.create_list(:suggestion, 15, user: user)
      }


      it 'pulls back all published experiences' do
        user.experiences << experiences
        expect(submissions(user, other_user).size).to eq 5
      end

      it 'pulls back all published ideas' do
        user.ideas << ideas
        expect(submissions(user, other_user).size).to eq 5
      end

      it 'pulls back all published recipes' do
        user.recipes << recipes
        expect(submissions(user, other_user).size).to eq 5
      end

      it 'pulls back all published solutions' do
        user.solutions << solutions
        expect(submissions(user, other_user).size).to eq 5
      end

      it 'pulls back all suggestions' do
        user.suggestions << suggestions
        expect(submissions(user, other_user).size).to eq 15
      end

      it 'pulls back everything that is published' do
        user.experiences << experiences
        user.ideas << ideas
        user.recipes << recipes
        user.solutions << solutions
        user.suggestions << suggestions

        expect(submissions(user, other_user).size).to eq 35
      end
    end
  end

  describe '#display_commenters' do
    let(:entity) {
      FactoryGirl.create(:experience)
    }

    context 'with no commenters' do

      it 'returns an empty string' do
        expect(display_commenters(entity)).to eq ''
      end
    end

    context 'with one commenter' do

      let!(:comment) {
        comment = Comment.build_from(entity, FactoryGirl.create(:user, first_name: 'John', last_name: 'Doe').id, {body: 'Test comment!!'})
        comment.save!
      }
      it 'returns the single user\'s display name' do
        expect(display_commenters(entity)).to eq 'John D'
      end
    end

    context 'with two commenters' do
      let!(:comments) {
        names = [%w(John Doe), %w(Jane Doe)]
        2.times do |idx|
          comment = Comment.build_from(entity, FactoryGirl.create(:user, first_name: names[idx][0], last_name: names[idx][1]).id, {body: 'Test comment!!'})
          comment.save!
        end
      }

      it 'returns both commenters\' display name' do
        expect(display_commenters(entity)).to eq 'John D and Jane D'
      end
    end

    context 'with three commenters' do
      let!(:comments) {
        names = [%w(John Doe), %w(Jane Doe), %w(Barack Obama)]
        3.times do |idx|
          comment = Comment.build_from(entity, FactoryGirl.create(:user, first_name: names[idx][0], last_name: names[idx][1]).id, {body: 'Test comment!!'})
          comment.save!
        end
      }

      it 'shows the first two commenters and phrases the remainder correctly' do
        expect(display_commenters(entity)).to eq 'John D, Jane D and 1 other'
      end
    end

    context 'with more than three commenters' do
      let!(:comments) {
        names = [%w(John Doe), %w(Jane Doe), %w(Barack Obama), %w(Bill Gates)]
        4.times do |idx|
          comment = Comment.build_from(entity, FactoryGirl.create(:user, first_name: names[idx][0], last_name: names[idx][1]).id, {body: 'Test comment!!'})
          comment.save!
        end
      }

      it 'shows the first two commenters and phrases the remainder correctly' do
        expect(display_commenters(entity)).to eq 'John D, Jane D and 2 others'
      end
    end
  end

  describe '#display_likers' do
    let(:entity) {
      FactoryGirl.create(:experience)
    }

    context 'with no likes' do

      it 'returns an empty string' do
        expect(display_likers(entity)).to eq ''
      end
    end

    context 'with one like' do

      let!(:like) {
        entity.liked_by(FactoryGirl.create(:user, first_name: 'John', last_name: 'Doe'), vote_scope: entity.default_like[:scope])
      }
      it 'returns the single user\'s display name' do
        expect(display_likers(entity)).to eq 'John D'
      end
    end

    context 'with two likes' do
      let!(:likes) {
        names = [%w(John Doe), %w(Jane Doe)]
        2.times do |idx|
          entity.liked_by(FactoryGirl.create(:user, first_name: names[idx][0], last_name: names[idx][1]), vote_scope: entity.default_like[:scope])
        end
      }

      it 'returns both commenters\' display name in reverse creation order' do
        expect(display_likers(entity)).to eq 'Jane D and John D'
      end
    end

    context 'with three likes' do
      let!(:comments) {
        names = [%w(John Doe), %w(Jane Doe), %w(Barack Obama)]
        3.times do |idx|
          entity.liked_by(FactoryGirl.create(:user, first_name: names[idx][0], last_name: names[idx][1]), vote_scope: entity.default_like[:scope])
        end
      }

      it 'shows the last two commenters and phrases the remainder correctly' do
        expect(display_likers(entity)).to eq 'Barack O, Jane D and 1 other'
      end
    end

    context 'with more than three likes' do
      let!(:comments) {
        names = [%w(John Doe), %w(Jane Doe), %w(Barack Obama), %w(Bill Gates)]
        4.times do |idx|
          entity.liked_by(FactoryGirl.create(:user, first_name: names[idx][0], last_name: names[idx][1]), vote_scope: entity.default_like[:scope])
        end
      }

      it 'shows the last two commenters and phrases the remainder correctly' do
        expect(display_likers(entity)).to eq 'Bill G, Barack O and 2 others'
      end
    end
  end
end