# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用
    let(:user) { FactoryBot.create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    # test_postを作成し、空欄での登録ができるか確認
    subject { test_post.valid? }
    let(:test_post) { post }


    context 'nameカラム' do
      it '空欄でないこと' do
        test_post.name = ''
        is_expected.to eq false;
      end
      it '31文字未満であること' do
        post.name = Faker::Lorem.characters(number:31)
        expect(post.valid?).to eq false;
      end
    end
    context 'categoryカラム' do
      it '空欄でないこと' do
        test_post.category = ''
        is_expected.to eq false;
      end
    end
    context 'captionカラム' do
      it '空欄でないこと' do
        test_post.caption = ''
        is_expected.to eq false;
      end
      it '501文字未満であること' do
        post.caption = Faker::Lorem.characters(number:501)
        expect(post.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Favoritesモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end