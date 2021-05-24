# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用
    let(:user) { FactoryBot.create(:user) }
    # test_userを作成し、空欄での登録ができるか確認
    subject { test_user.valid? }
    let(:test_user) { user }

    context 'nameカラム' do
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false;
      end
    end
      it '21文字未満であること' do
        user.name = Faker::Lorem.characters(number:21)
        expect(user.valid?).to eq false;
      end
    context 'emailカラム' do
      it '空欄でないこと' do
        test_user.email = ''
        is_expected.to eq false;
      end
    end
    context 'passwordカラム' do
      it '空欄でないこと' do
        test_user.password = ''
        is_expected.to eq false;
      end
    end
      it '6文字以上であること' do
        user.password = Faker::Internet.password(min_length: 6)
        expect(user.valid?).to eq false;
      end
    context 'introductionカラム' do
      it '51文字未満であること' do
        user.introduction = Faker::Lorem.characters(number:51)
        expect(user.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Favoritesモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end